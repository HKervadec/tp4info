
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


int *tab;
int id;
const int tabsize =5;
int sem_nvide;
int sem_nplein;
int muttex;

int i;
int pidFils ;

void init_mem(){
	id = shmget(CLE, 7*sizeof(int), IPC_CREAT | 0777);
	sem_nvide = init_sem(tabsize);
	sem_nplein = init_sem(0);
	muttex = init_sem(1);
	if(id == -1){
		return;
	}

}

int main(int argc, char *argv[]){
	init_mem();
	printf("[MainProgram] memory initialisation done");
	char str_id[40];
	sprintf(str_id, "%d", id);
	char str_sem_nvide[40];
	sprintf(str_sem_nvide, "%d", sem_nvide);
	char str_sem_nplein[40];
	sprintf(str_sem_nplein, "%d", sem_nplein);
	char str_muttex[40];
	sprintf(str_muttex, "%d", muttex);
	char str_i[10];
	
	for(i = 0 ; i < 4 ; i++){
		
		pidFils = fork();

		if (pidFils==0){
			execl("productor.out","productor.out",str_id,str_sem_nplein,str_sem_nvide,NULL);
		}
		
	}

		for(i = 0 ; i < 4 ; i++){
		
		pidFils = fork();
		sprintf(str_i, "%d", i);
		if (pidFils==0){
			execl("consomator.out","consomator.out",str_id,str_sem_nplein,str_sem_nvide,str_i,NULL);
		}
		
	}
	



	
	return 0;
}

 
