#include "EucHW.h"

/**
 * @brief EucHW calcula la distancia euclidiana entre los vectores A y B,
 * cuyo resultado es almacenado en el puntero C.
 * 
 * @param A Vector de entrada
 * @param B Vector de entrada
 * @param C Puntero resultado
 */
void eucHW (T A[LENGTH], T B[LENGTH], Tout *C)
{
	#pragma HLS ARRAY_PARTITION variable=A type=cyclic factor=512 dim=1
	#pragma HLS ARRAY_PARTIRION variable=B type=cyclic factor=512 dim=1

	uint26_t result=0;
	sumLoop:for(int i=0;i<LENGTH;i++)
	{
		#pragma HLS UNROLL factor=512
		result +=  (A[i]-B[i])*(A[i]-B[i]);
	}
	*C=  hls::sqrt(result);
	return;
}
