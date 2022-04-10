# Tarea 4 P3.1 IPD432

Grupo Juan Aguilera - Ricardo Mardones

El propósito de este proyecto es el de ilustrar el proceso de diseño de un coprocesador que soporta el cálculo de la distancia euclidiana entre vectores de 1024 palabras de 8 bits cada una.
El proyecto se desarrolló usando las siguientes herramientas:

* Software  Vitis HLS 2021.1
* Software Vivado 2021.1
* Tarjeta de desarrollo Nexys 4 DDR

El sistema operativo utilizado fue Windows 10 /  Windwos 11.

Los tiempos estimados de síntesis e implementación fueron tomados operando en un computador con las siguientes caracterisiticas:

* Procesador: Intel Core i7-10750H CPU @ 2.60GHz
* Memoria (RAM): 12 GB @ 2933 MHz

## Guía para replicar resulados
### Procesador de vectores usando HLS para Nexys 4 DDR

Para reproducir la síntesis del coprocesador mediante Vitis HLS se utilizan los archivos fuente que se encuentran en  la carpeta ``` \SRC_VITIS_HLS``` dentro de este repositorio. Se deben seguir  las instrucciones descritas  a continuación:

* Abrir Vitis HLS 2021.1, seleccionando la opción ```Create Project```.
* Elegir un nombre y ubicación para el proyecto creado y hacer click en  el botón ```Next > ```.
* Añadir los archivos fuente correspondientes a archivos de diseño, estos son ```EucHW.cpp```, ```EucHW.h``` y  ```specs.h```. En esta misma ventana se debe definir la función principal, en este caso, ```EucHW```. Luego  hacer click en  el botón ```Next > ```.
* Añadir los archivos fuente correspondientes a archivos de <em>testbench</em>, estos son ```EucSW.cpp```, ```EucSW.h``` y  ```EucTB.cpp```. Luego  hacer click en  el botón ```Next > ```.

* Elegir nombre para la solución, escoger el periodo del reloj a utilizar en la síntesis (se conserva el valor por defecto de 10 ns para obtener un estimado del <em>timing</em> comparable con el esperado al cargar el diseño en la taejta).

* En la sección ```Part Selection```, ```Parts```, especificar la tarjeta en la cual se implementará el diseño, en este caso  ```XC7A100TCSG324-1``` .

* Conservar la configuración por defecto en la sección ```Flow Target``` y hacer click en el botón ```Finish ```

![Device part.](/Imagenes_Readme/Start_HLS.gif)

* Sintetizar el proyecto haciendo click en el botón ```Run``` de la barra superior del Software o  ```Run C Synthesis ``` ubicado en la sección ```Flow Navigator```.

 Si todo ha ido como corresponde, la síntesis debiese entregar resultados satisfactorios como los que se muestran en la Figura siguiente, cumpliendo con las restricciones de <em>timing</em> (sin <em>slack</em> negativo), y un uso de recursos  fisicamente implementable en la tarjeta de desarrollo a utilizar.

![Device part.](/Imagenes_Readme/performance_hls.png)

 * Ejecutar la Cosimulación con ``` Run Cosimulation ```. El error esta en torno a una unidad, debido a que estamso trabajando con numeros enteros comparados con flotantes. La función ``` hls::sqrt``` perteneciente a la biblioteca [hls_math.h](https://docs.xilinx.com/r/en-US/ug1399-vitis-hls/Vitis-HLS-Math-Library) proporcionada por Xilinx tambien aumenta este error, el cual se justifica, ya que esta función permite disminuir la latencia del procesador en 55 ciclos. En el caso de usar variables del tipo flotantes, el error se reduce casi en su totalidad, pero la latencia aumenta considerablemente.

* Exportar IP usando ```Export RTL```. Esta accion genera un archvio .zip, el cual al ser descomprimido puede ser añadido a ```Vivado``` como se mostrara más adelante.

### Uso de pragmas en Vitis HLS

En esta sección se explica el uso de los pragmas implementados al realizar la sección anterior, siguiendo la función definida en ```\SRC_VITIS_HLS\EucHW.cpp```, que se muestra a continuación:

```cpp
void eucHW (T A[LENGTH], T B[LENGTH], Tout *C)
{
	#pragma HLS ARRAY_RESHAPE variable=A type=cyclic factor=512 dim=1
	#pragma HLS ARRAY_RESHAPE variable=B type=cyclic factor=512 dim=1

	uint26_t result=0;
	sumLoop:for(int i=0;i<LENGTH;i++)
	{
		#pragma HLS UNROLL factor=512
		result +=  (A[i]-B[i])*(A[i]-B[i]);
	}
	*C= hls::sqrt(result);
	return;
}
```


### Implementación usando Vivado

Para reproducir la implementación del coprocesador mediante Vivado se utilizan los archivos fuente en la carpeta ``` \SRC_VIVADO_DESIGN``` dentro de este repositorio y seguir las instrucciones a continuación:

* Abrir Vivado y crear un nuevo proyecto con ```Create Project```.
* Elegir un nombre y directorio para el proyecto.
* Solo seleccionar ```RTL project```.
* En ```Add Source``` seleccionar ```Add Directories``` y seleccionar la carpeta ```\SRC_VIVADO_DESIGN\VIVADO_SRC\src``` que se encuentran en este repositorio.
* En ```Add Constraints``` seleccionar ```Add File``` y seleccionar el archivo ```\SRC_VIVADO_DESIGN\VIVADO_SRC\constraint\Nexys-4-DDR-Master.xdc``` presente en el respoitorio.
* En ```Default Part```, ```Boards``` elegir ```Nexys4 DDR```, si es necesario, descargar y Finalizar.

![Vivado Project process.](/Imagenes_Readme/create_vivado_project.gif)

* En el menu ```PROJECT MANAGER``` ir a ```IP Catalog```.
* En la ventana ```IP Catalog``` hacer click derecho y elegir la opcion ```Add Repository...```
* Elegir la carpeta ```\SRC_VIVADO_DESIGN\IP_SRC_eucHW\eucDistHW_512```. Esta carpeta deberia ser equivalente a la creada en el tutorial en VITIS HLS.

![Vivado Project IP.](/Imagenes_Readme/import_ip.gif)

* En ```PROGRAM AND DEBUG``` genera el Bitstream.

* Abrir ```Open Hardware Manager```, ```Open Target`Si ``, ```Program Device```.

* Usando el script de Matlab ```\MATLAB\coprocessorTesting.m``` pruebe los los resultados de la distancia euclidiana para vectores aleatorios.

### Reporte de frecuencia latencia y throughtput

### Uso de recursos

### Tiempo de sintesis
