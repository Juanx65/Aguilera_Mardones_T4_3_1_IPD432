#include "eucSW.h"

void eucSW (T A[LENGTH], T B[LENGTH],float C[1])
{
	C[0] = 0;
	for (int i = 0; i < LENGTH; i++)
	{
		C[0] = C[0] + (A[i]-B[i])*(A[i]-B[i]);
	}
	C[0] = sqrt(C[0]);
	return;
}
