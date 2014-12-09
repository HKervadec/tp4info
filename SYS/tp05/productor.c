
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

void write(){
	tab = shmat(id, NULL, 0);
	P(sem_nvide);
	P(muttex);
	first = tab[5];
	tab[first] = nb;
	tab[5] = (tab[5]+1) % 5;
	V(muttex);
	V(sem_nplein);
}

int main(int argc, char *argv[]){

	// atoyage
	id = atoi(argv[1]);
	sem_nvide = atoi(argv[2]);
	sem_nplein = atoi(argv[3]);
	muttex = atoi(argv[4]);
	nb = atoi(argv[5]);

	while(1){
		write();
		sleep(2);
	}
	return 0;
}