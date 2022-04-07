
%% A partir de aca se realizan las operaciones por medio de comandos al coprocesador
clear all
% Primero setear puerto serial
COM_port = serialport("COM8",115200);

% Los siguientes comandos son con formato tentativo. 
% Puede aplicar cambios menores para adaptarlos a su implementacion, lo cual debe quedar claramente documentado.
% En cualquier caso, debe incluir solo argumentos necesarios para cada operacion. 
% No aplique aca "parches de software" para cubrir deficiencias en el diseño de hardware.
% No se aceptarán comentarios del tipo: "hay que poner ese argumento porque sino no funciona", sin una justificacion adecuada.

%% 
N=1024;  % define el numero de elementos de cada vector
TESTS = 1000;
%Genera vectores A y B de 1024 elementos con numeros positivos 
%(puede adaptarse facilmente si usan negativos y positivos).

AVG_ERR = zeros(1,TESTS);

for i = 1:TESTS -1

    %creaciond e vectores
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

    % Calcula valores de referencia para las operaciones, realizadas en forma local en el host
    % sumVec_host = A+B;
    % avgVec_host = (A+B)/2;
    % man_host = sum(abs(A-B));
    euc_host = sqrt(sum((A-B).^2));
    
  
    %writeVec escribe un vector almacenado en un archivo de texto en la BRAM indicada por medio de la UART
    write2dev('vectorA.txt','BRAMA',COM_port); 
    write2dev('vectorB.txt','BRAMB',COM_port); 
    
    %realiza el calculo de la distancia Euclideana entre dos vectores y envia el resultado por la UART
    euc_device    = command2dev('eucDist', COM_port);

    euc_diff = abs(euc_host - euc_device);
    AVG_ERR(i) = euc_diff;
   
end

 fprintf("END TESTS");

%%
avg_err = sum(AVG_ERR)/TESTSS







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