%%clear all; % borra el workspace

%% Acondicionamiento del workspace
COM_port = 0; %inicialización auxiliar del puerto serial
N=1024;  % define el numero de elementos de cada vector


%% Creación de los vectores de prueba

%Genera vectores A y B de 1024 elementos con numeros positivos 
%(puede adaptarse facilmente si usan negativos y positivos).

A=ceil(rand(N,1)*254);
B=ceil(rand(N,1)*254);

%Guarda vectores A y B (cada uno de una columna de 1024 filas) en un
%archivo de texto. Cada linea del archivo contiene un elemento.
h= fopen('VectorA.txt', 'w');
fprintf(h, '%i\n', A);
fclose(h);

h= fopen('VectorB.txt', 'w');
fprintf(h, '%i\n', B);
fclose(h);

% Calcula valores de referencia resultantes para las operaciones, realizadas en forma local en el host
sumVec_host = A+B;
avgVec_host = (A+B)/2;
man_host = sum(abs(A-B));
euc_host = sqrt(sum((A-B).^2));

%% Configuración del puerto serial para comunicar host-device

% Primero setear puerto serial
clear COM_port

port = "COM8"; %modificar esta linea según el puerto serial al que se conectó la tarjeta en su ordenador
COM_port = serialport(port,115200);

%%  Almacenamiento de los vectores en BRAM

%writeVec escribe un vector almacenado en un archivo de texto en la BRAM indicada por medio de la UART
write2dev('vectorA.txt','BRAMA',COM_port); 
write2dev('vectorB.txt','BRAMB',COM_port); 
%% Calculo de la distancia euclidiana entre vectores A y B
euc_device    = command2dev('eucDist', COM_port); %realiza el calculo de la distancia Euclideana entre dos vectores y envia el resultado por la UART
%% Validacion.
%calcula el error entre el resultado esperado de la operación y el obtenido
%mediante el procesador implementado

euc_diff = abs(euc_host - euc_device)



%% funciones

function write2dev(file,memoria,puerto)
    N = 1024;
    f = fopen(file);
    data = textscan(f,'%s');
    fclose(f);
    vector = str2double(data{1});
    
    if strcmp(memoria,'BRAMA')
        write(puerto, uint8(1),"uint8");
    elseif strcmp(memoria,'BRAMB')
        write(puerto, uint8(2),"uint8");
    else
        dsip('Error: BRAM invalida.');
        return
    end 
    write(puerto,uint8(vector(1:N)),"uint8"); 
end

function vector = command2dev(varargin)
    if(nargin == 2)
        vector = command2dev_op(varargin{1}, varargin{2}); 
    elseif(nargin == 3)
        vector = command2dev_read(varargin{1}, varargin{2}, varargin{3});
    else
        dsip('Error: numero de argumentos invalido.');
        return
    end      
end
function vector = command2dev_read(comando, memoria, puerto)
    N = 1024;
    write(puerto, uint8(3),"uint8");
    if strcmp(comando,'readVec')
       if strcmp(memoria,'BRAMA')
           write(puerto, uint8(1),"uint8");
       elseif strcmp(memoria,'BRAMB')
           write(puerto, uint8(2),"uint8");
       else
           dsip('Error: BRAM invalida.');
           return
       end
    else
        dsip('Error: commando invalido.');
        return
    end
    vector = read(puerto,N,"uint32");
end

function vector = command2dev_op(comando, puerto)
    write(puerto, uint8(3),"uint8");
    if strcmp(comando,'sumVec')
        N = 1024;
        write(puerto, uint8(3),"uint8");
    elseif strcmp(comando,'avgVec')
        N = 1024;
        write(puerto, uint8(4),"uint8");
    elseif strcmp(comando,'manDist')
        N = 1;
        write(puerto, uint8(5),"uint8");
    elseif strcmp(comando,'eucDist')
        N = 1;
        write(puerto, uint8(6),"uint8");
    else
        dsip('Error: comando invalido.');
        return
    end
    vector = read(puerto,N,"uint32");
end