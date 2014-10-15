#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/shm.h>
#include "sem.h"

#define CLE 10012

void init_mem();
void super_fork(int deb, int fin);
void fusion(int deb, int fin);

int *tab;
int id;
int deb = 0;
int fin = 13;
int sem;

int i;

void init_mem(){
	id = shmget(CLE, 14*sizeof(int), IPC_CREAT | 0777);
	sem = init_sem(0);

	if(id == -1){
		return;
	}

	tab = shmat(id, NULL, 0);

	for(i = 13 ; i >= 0 ; i--){
		tab[13 - i] = i;
	}
}

void super_fork(int deb, int fin){
	int interv = fin - deb;
	printf( "%d \n", interv );
	if((fin - deb) <= 7){
		return;
	}else{
		if(fork()){
			printf("%d %d\n", deb, fin/2);
			super_fork(deb, fin/2);
			exit(0);
		}
		if(fork()){
			printf("%d %d\n", fin/2 + 1, fin);
			super_fork(fin/2 + 1, fin);
			exit(0);
		}
		P(sem);
		fusion(deb, fin);
		V(sem);
	}
}

void fusion(int deb, int fin){
	int *result = malloc((fin - deb) * sizeof(int));

	int iA = deb, iB = fin/2 + 1, iR = 0;

	while(iA < fin/2 && iB <= fin){
		if(tab[iA] <= tab[iB]){
			result[iR] = tab[iA];
			iA++;
		}else{
			result[iR] = tab[iB];
			iB++;
		}
		iR++;
	}
	for(; iA < fin/2 ; iA++){
		result[iR] = tab[iA];
		iR++;
	}
	for(; iB <= fin ; iB++){
		result[iR] = tab[iB];
		iR++;
	}

	for(i = 0 ; i < (fin - deb) ; i++){
		tab[deb + i] = result[i];
	}

	free(result);
}


int main(int argc, char *argv[]){
	init_mem();

	for(i = 0 ; i < 13 ; i++){
		printf("%d ", tab[i]);
	} 
	printf("\n");

	super_fork(0, 13);

	for(i = 0 ; i < 13 ; i++){
		printf("%d ", tab[i]);
	} 
	printf("\n");
	
	return 0;
}

 
