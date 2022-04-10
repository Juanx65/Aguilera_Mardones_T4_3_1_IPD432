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

 * Para validar el diseño se ejecuta la Cosimulación  haciendo click en botón de ``` Run Cosimulation ``` ubicado en la sección ```Flow Navigator ```.

  Con este diseño se espera un error debido a que  se está trabajando con datos del tipo entero, y se están comparando con datos flotantes para la validación. Sin embargo el error obtenido se encuentra por debajo del 1%.

 La función ``` hls::sqrt``` perteneciente a la biblioteca [hls_math.h](https://docs.xilinx.com/r/en-US/ug1399-vitis-hls/Vitis-HLS-Math-Library)  tambien afecta a este error, pero su uso se justifica  ya que esta función permite disminuir la latencia del procesador en 16 ciclos respecto a la función ```sqrt``` de la librería ```math.h```que si bien es más precisa impone un <em>overhead</em> a la latencia del sistema. En el caso de usar datos del tipo flotantes, el error se reduce casi en su totalidad, pero la latencia aumenta significativamente.

* Exportar IP hacienco click en el botón ```Export RTL``` en la sección ```Flow navigator```. Esta acción genera un archvio .zip, el cual al ser descomprimido puede ser añadido a ```Vivado``` como se mostrará más adelante.

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

* Abrir ```Open Hardware Manager```, ```Open Target`Si ```, ```Program Device```.

* Usando el script de Matlab ```\MATLAB\coprocessorTesting.m``` pruebe los los resultados de la distancia euclidiana para vectores aleatorios.

 Adicionalmente, se programó el script de Matlab ``` \MATLAB\coprocessorTesting_all.m ``` donde se generan 1000 instancias de prueba, donde llegamos a un error promedio de 0.24, el cual es menor al 1% de error promedio.

### Reporte de frecuencia, latencia y throughtput

El proyecto se implemento con una frecuencia de 100 MHz, como se sugeira en la sintesis de HLS. Los resultados finales muestran que se cumplen todas las restricciones de timepo, logrando un WNS de 0.081 ns, como se muestra en la Figura siguiente:

![Vivado Project IP.](/Imagenes_Readme/time_summary.png)

### Uso de recursos

El uso de recursos se muestra en la Figura siguiente:

![Vivado Project IP.](/Imagenes_Readme/uso_recursos.png)



### Tiempo de sintesis

* Sintesis (HLS) = 4 minutos 38 segundos
* Sintesis (Vivado) = 5 minutos 40 segundos
* Implementacion = 10 minutos 47 segundos
