#include "EucHW.h"

/**
 * @brief EucHW calcula la distancia euclidiana entre los vectores A y B,
 * cuyo resultado es almacenado en el puntero C.
 * 
 * @param A Vector de entrada
 * @param B Vector de entrada
 * @param C Puntero resultado
 */
void eucHW (T A[LENGTH], T B[LENGTH], Tout C[1])
{
	#pragma HLS array_reshape variable=A type=cyclic  factor=512 dim=1
	#pragma HLS array_reshape variable=B type=cyclic  factor=512 dim=1

	Tout result = 0;
	sumLoop:for(int i=0;i<LENGTH;i++)
	{
		#pragma HLS UNROLL factor=512
		result += (A[i]-B[i])*(A[i]-B[i]);
	}
	C[0] =  hls::sqrt(result);
	return;
}
