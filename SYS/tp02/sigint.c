#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>

pid_t pidFils;

void handler_pere(int sig){
	printf("\nOuhlala c'est la merde %d \n", pidFils);
	kill(pidFils, SIGUSR1);
	wait(NULL);

	printf("Allez hop, on saute du dixieme etage.\n");
	exit(0);
}

void handler_fils(int sig){
	printf("JE ME SUICIDE!!!!11!!\n");
	sleep(5);
	printf("MAIS PAS DE SUITE\n");
	exit(0);
}

int main(void){
	printf("Debut\n");

	pidFils = fork();
	if (pidFils != 0){
		signal(SIGINT, (*handler_pere));

		while(1){
			printf("ping\n");
		}
	}
	else{
		signal(SIGUSR1, (*handler_fils));
		printf("Le fils a spawn.\n");
		
		
		while(1){
			printf("Je suis le fils et je suis HEUREUX");
		}
	}

	return 0;
}
