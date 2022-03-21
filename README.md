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

* Elegir nombre para la solución, así como especificar el código de FPGA a utilizar, en este caso ```XC7A100TCSG324-1``` como se muestra a continuación:

![Device part.](/Imagenes_Readme/device.png)

* Sintetizar el proyecto usando ```Run``` o ```Run C Synthesis ```
obs: es importante notar que se usa un periodo de 10 ns, el cual concuerda con los resultados obtenidos más adelante para el WNS obtenido...

* Ejecutar la Cosimulación con ``` Run Cosimulation ```

* Exportar IP usando ```Export RTL``` 

## Pasos de implementación

## Uso de pragmas

## Reporte de frecuencia latencia y throughtput

## Uso de recursos

## Tiempo de sintesis
