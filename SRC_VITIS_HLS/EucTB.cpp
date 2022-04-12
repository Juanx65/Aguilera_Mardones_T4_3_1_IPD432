
#include <iostream>
#include <math.h>
#include "specs.h"
#include "EucHW.h"
#include "EucSW.h"

using namespace std;

void genRandArray(int min, int max, int size, T *array);
int compare(float* gold, Tout* result, int size, double th);

int main (){
	int errors = 0;
	int tests = 100;

	T A[LENGTH], B[LENGTH];
	Tout C_HW[1];
	float C_SW[1];

	double diff;
	double th = 0.9; // vamos a aceptar un error bastante alto, el cual se reduce considerablemente con el uso de flotantes en el resultado.
	int min = 0;
	int max = 254;
	cout << "Euc Dist calculation: "<< endl;
	for (int i=0; i<tests; i++){
		genRandArray(min, max, LENGTH, A);
		genRandArray(min, max, LENGTH, B);

		eucSW (A, B, C_SW);
		eucHW (A, B, C_HW);

		errors += compare(C_SW, C_HW, 1, th);
		cout << "C_SW: " << C_SW[0] << ", C_HW: " << C_HW[0] << endl;
	}
	cout <<"Number of errors: " << errors << endl;
	if (errors){
		return 1;
	}
	return 0;
}


void genRandArray(int min, int max, int size, T *array){
    for(int i=0; i<size; i++){
        array[i] = rand()%255; // min + static_cast <T> (rand()) / ( static_cast <T> (RAND_MAX/(max-min)));
    }
}

int compare(float* gold, Tout* result, int size, double th){
        int errors = 0;
        double dif = 0;
        for (int i=0; i<size; i++){
                dif = fabs((double)gold[i] - (double)result[i]);
                // a comparison with NaN will always be false
                if (!(dif <= (double)th)){
                        errors++;
                }
        }
        return errors;
}
