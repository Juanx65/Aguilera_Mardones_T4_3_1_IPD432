#ifndef SPECS_H
#define SPECS_H

#import <cstdint>	/* Se usa para tener acceso al tipo uint8_t y uint32_t
 	 	 	 	 	 */
#include "ap_int.h"

typedef uint8_t T; // Tipo de variable para Vectores entrantes

typedef ap_uint<26> uint26_t;  // Tipo variable intermedia
typedef uint32_t Tout;  // Tipo variable resultante

#define LENGTH 1024 // largo en palabras de vectores a operar

#endif
