#ifndef EUCDISTHW_H
#define EUCDISTHW_H

#include "specs.h"
#include <math.h>
#include <hls_math.h>  /* Se incluyue para el uso de la funcion hls::sqrt 
                        * que disminuye la latencia respecto a sdt::sqrt,
                        * con el costo de tener un mayor error.
                        */
void eucHW (T A[LENGTH], T B[LENGTH], Tout *C);
#endif
