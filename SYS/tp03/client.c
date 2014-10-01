#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>


int main(int argc, char *argv[]){
	int pid_serv = atoi(argv[1]);

	if(mkfifo("/tmp/pipe", 0666) == -1){
		perror("mkfifo");
		exit(1);
	}
	printf("Pipe prete.\n");

	int fd = open("/tmp/pipe", O_RDONLY);
	if(fd == -1){
		perror("open");
		exit(2);
	}	
	printf("Pipe ouverte.\n");

	while(1){
		system("pause");
		printf("test");
		kill(pid_serv, SIGUSR1);
	}
	


	close(fd);
	unlink("pipe");
	return 0;
}
