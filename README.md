# Tarea 4 P3.1 IPD432

Grupo Juan Aguilera - Ricardo Mardones

El propósito de este proyecto es el de ilustrar el proceso de diseño de un coprocesador que soporta el cálculo de la distancia euclidiana entre vectores de 1024 palabras de 8 bits cada una.
El proyecto se elaboró usando las siguientes plataformas:

* Vitis HLS 2021.1
* Vivado 2021.1
* Nexys 4 DDR

El proyecto se desarrollo en el SO Windows 10 /  Windwos 11.

## Guía
### Procesador de vectores usando HLS para Nexys4 DDR

Para reproducir la síntesis del coprocesador mediante Vitis HLS se utilizan los archivos fuente en la carpeta ``` \SRC_VITIS_HLS``` dentro de este repositorio y seguir las instrucciones a continuación:

* Abrir Vitis HLS 2021.1, eligiendo la opción ```Create Project```.
* Elegir un nombre y ubicación para el proyecto creado.
* Añadir los archivos fuente del repositorio donde se deben subir los archivos de diseño así como elegir la función principal, en este caso, ```EucHW```. Luego se pide subir los archivos para generar los Testbench, como se muestra en la Figura siguiente:

![Archivos añadidos.](/Imagenes_Readme/Vitis_HLS_Files.png)

* Elegir nombre para la solución, así como especificar la tarjeta de desarrollo utilizada seleccionando en ```Part Selection```, ```Parts```,  ```XC7A100TCSG324-1``` como se muestra a continuación:

![Device part.](/Imagenes_Readme/device.png)

* Sintetizar el proyecto usando ```Run``` o ```Run C Synthesis ```. Es importante notar que se usa un periodo de 10 ns, el cual concuerda con los resultados obtenidos más adelante, permitiendo un WNS positivo.

* La síntesis da resultados de timing, latencia y recursos satisfactorios, estos se muestran en la Figura siguiente:

![Device part.](/Imagenes_Readme/performance_hls.png)

 * Ejecutar la Cosimulación con ``` Run Cosimulation ```. El error obtenido es bastante alto, en torno a una unidad, el cual proviene de la función ``` hls::sqrt``` perteneciente a la biblioteca [hls_math.h](https://docs.xilinx.com/r/en-US/ug1399-vitis-hls/Vitis-HLS-Math-Library) proporcionada por Xilinx, además del uso de enteros. El error se justifica, ya que esta función permite disminuir la latencia del procesador en 55 ciclos. En el caso de usar variables del tipo flotantes, el error se reduce casi en su totalidad, pero la latencia aumenta considerablemente.

* Exportar IP usando ```Export RTL```. Esta accion genera un archvio .zip, el cual al ser descomprimido puede ser añadido a ```Vivado``` como se mostrara más adelante.

### Pasos de implementación

Para reproducir la implementación del coprocesador mediante Vivado se utilizan los archivos fuente en la carpeta ``` \SRC_VIVADO_DESIGN``` dentro de este repositorio y seguir las instrucciones a continuación:

* Abrir Vivado y crear un nuevo proyecto con ```Create Project```.
* Elegir un nombre y directorio para el proyecto.
* Solo seleccionar ```RTL project```.
* En ```Add Source``` seleccionar ```Add Directories``` y seleccionar la carpeta ```\SRC_VIVADO_DESIGN\VIVADO_SRC\src``` que se encuentran en este repositorio.
* En ```Add Constraints``` seleccionar ```Add File``` y seleccionar el archivo ```\SRC_VIVADO_DESIGN\VIVADO_SRC\constraint\Nexys-4-DDR-Master.xdc``` presente en el respoitorio.
* En ```Default Part```, ```Boards``` elegir ```Nexys4 DDR```, si es necesario, descargar y Finalizar.

![Vivado Project process.](/Imagenes_Readme/create_vivado_project.gif)

### Uso de pragmas

### Reporte de frecuencia latencia y throughtput

### Uso de recursos

### Tiempo de sintesis
