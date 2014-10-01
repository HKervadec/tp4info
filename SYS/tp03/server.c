#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>

char text[64] = "pizza aux narines\n";

struct sigaction action;
sigset_t mask_nv;
sigset_t mask_anc;

void p_print(char *buffer, int length){
	int fd = open("pipe", O_WRONLY);
	if(fd == -1){
		perror("open");
		exit(1);
	}

	write(fd, buffer, length);

	close(fd);
}

void handler(){
	printf("J'handle.\n");
	p_print(text, 64);
}

int main(void){
	// bloque SIGUSR1
  sigemptyset(&mask_nv);
  sigaddset(&mask_nv, SIGUSR1);
  sigprocmask(SIG_BLOCK, &mask_nv, &mask_anc);

  //Définition du handler
  action.sa_handler = handler;
  sigaction(SIGUSR1, &action, NULL);

	while(1){
		sigsuspend(&mask_anc);
	}

	return 0;
}
