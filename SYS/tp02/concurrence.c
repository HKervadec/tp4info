#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>

void handler(int sig){
  printf("Signal recu\n");
}

pid_t pidFils;  

struct sigaction action;
sigset_t mask_nv;
sigset_t mask_anc;

int main (int argc, char * argv[]){
	sigemptyset(&mask_nv);
  sigaddset(&mask_nv, SIGUSR1);
	sigprocmask(SIG_BLOCK, &mask_nv, &mask_anc);

	//Définition du handler
  action.sa_handler=handler;
  sigaction(SIGUSR1,&action,NULL);

	int i;
	pidFils = fork();
	if (pidFils != 0){
		for(i = 0 ; i < 10 ; ++i){
			printf("a");
		}
		printf("\n");
		sleep(2);

		kill(pidFils, SIGUSR1);
		
		wait(NULL);
	}
	else{
		sigsuspend(&mask_anc);
		for(i = 0 ; i < 10 ; ++i){
			printf("b");
		}
		printf("\n");
	}

	return 0;
}
