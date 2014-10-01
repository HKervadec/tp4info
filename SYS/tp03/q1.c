#include <stdio.h>
#include <unistd.h>

int pid;

int main(void){
	int fp[2]; // fp[0] : lecture, fp[1] : ecriture
	pipe(fp);	

	char *toto = "Lalala\n";
	char buffer[256];

	pid = fork();

	if(pid != 0){
		close(fp[1]);

		dup2(fp[0], STDIN_FILENO);
		execlp("/bin/grep", "grep", "pts", NULL);

		close(fp[0]);
	}else{
		close(fp[0]);

		dup2(fp[1], STDOUT_FILENO);
		execlp("/bin/who", "who", NULL);

		close(fp[1]);
	}

	return 0;
}
