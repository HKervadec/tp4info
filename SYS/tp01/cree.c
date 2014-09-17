#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>


pid_t pidFils;  

main(){
  for(int i = 0 ; i < 10 ; i++){
	  pidFils = fork();
	  if(pidFils == 0){
	  	break;
	}
  }
  if (pidFils!=0){
    /* ------------ code du père ----------------- */
    int i;
    for(i=0;i<10;i++){
      printf("je suis le pere %d\n", getpid());
      sleep(3);
    }

  }
  else{
    /* ------------ code du fils ----------------- */
    int i;
    for (i=0;i<10;i++){
    printf("je suis le fils %d et papa est %d\n", getpid(), getppid());
    sleep(3);
    }
  }

}
