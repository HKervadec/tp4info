#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>

pid_t pidFils;  
int i = 0;
int sig_emis = 0;
int sig_recu = 0;

void handler(int sig){
	sig_recu++;
  printf("%d\n", i);
	printf("Recu: %d\n", sig_recu);
}

int main(void){
	pidFils = fork();
	if (pidFils != 0){
		while(1){
			sleep(5);
			sig_emis++;
			printf("Emis: %d\n", sig_emis);
			kill(pidFils, SIGUSR1);
		}
	}
	else{
		signal(SIGUSR1, (*handler));

		while(1){
			sleep(1);
			i++;
		}
	}

	return 0;
}
