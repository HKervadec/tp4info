#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>


pid_t pidFils;  
int histoire[3];

void fork_super(int r){
	if(r <= 0){
		return;
	}
	for(int i = 0 ; i < 2 ; i++){
		histoire[r-1] = getpid();
		pidFils = fork();
		if(pidFils == 0){
			fork_super(r - 1);
			return;
		}
	}
}

void afficher_histoire(){
	printf("Je suis %d et mon histoire est:", getpid());
	for(int i = 0 ; i < 3 ; i++){
		printf("%d ", histoire[i]);
	}

	printf("\n");
}

main(){
  fork_super(3);
  afficher_histoire();
}
