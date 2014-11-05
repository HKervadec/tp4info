
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/shm.h>
#include "sem.h"

int *tab;
int first = 5;
int last = 6;
int sem_nvide;
int sem_nplein;
int muttex;
int id;
int first;
int last;
int nb;

void read(){
	tab = shmat(id, NULL, 0);
	P(sem_nplein);
	P(muttex);
	last = tab[6];
	printf("consomator : %d \n", tab[last]);
	tab[6] = (tab[6]+1) % 5;
	V(muttex);
	V(sem_nvide);
}

int main(int argc, char *argv[]){

	// atoyage
	id = atoi(argv[1]);
	sem_nvide = atoi(argv[2]);
	sem_nplein = atoi(argv[3]);
	muttex = atoi(argv[4]);
	nb = atoi(argv[5]);
	while(1){
		read();
		sleep(2);
	}
	return 0;
}