#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>

int init(int val){
        int mysem = semget(IPC_PRIVATE, 1, 0666 | IPC_CREAT);
        if(mysem < 0) perror("Error: semget");

        int retval;
        union semun
        {
                int val;
                struct semid_ds *buf;
                ushort *array;
        } arg;

        arg.val = val;
        /* Init its value to arg.val */
        retval = semctl(mysem, 0, SETVAL, arg);
        if(retval < 0) perror("Error: semctl");

        return mysem;
}

void P(int sem){
        struct sembuf op;

        op.sem_num = 0;
        op.sem_op = -1; //1=V, -1=P
        op.sem_flg = 0;

        int retval = semop(sem, &op, 1);
        if(retval != 0) perror("error: semop P");
}

void V(int sem){
        struct sembuf op;

        op.sem_num = 0;
        op.sem_op = 1; //1=V, -1=P
        op.sem_flg = 0;

        int retval = semop(sem, &op, 1);
        if(retval != 0) perror("error: semop V");
}

void delete(int sem){
        int retval = semctl(sem, 0, IPC_RMID, NULL);
        if(retval < 0) perror("Error: semctl");  
}

int p_print(int id){
        switch(id){
        case 0:
                printf("J'aime les frites.\n");
                break;
        case 1:
                printf("Le cheval c'est trop genial.\n");
                break;
        case 2:
                printf("Il etait un petit navire.\n");
                break;
        case 3:
                printf("Ils ont des chapeaux ronds.\n");
                break;
        case 4:
                printf("J'en ai pour plus d'une barre de fringues sur moi.\n");
                break;
        }
}

int main(int argc, char *argv[]){
        int i;

        /*for(i = 0 ; i < argc ; i++){
                printf("%s\n", argv[i]);
        }*/

        int pid[10];

        if(argc == 1){
                printf("Root\n");
                int sem = init(1);

                for(i = 0 ; i < 10 ; i++){
                        pid[i] = fork();
                        if(pid[i]){
                                char a1[10], a2[10];
                                sprintf(a1, "%d", i % 5);
                                sprintf(a2, "%d", sem);

                                execlp(argv[0], argv[0], a1, a2, NULL);
                        }
                }

                for(i = 0 ; i < 10 ; i++){
                        waitpid(pid[i], 0, 0);
                }
                delete(sem);
        }
        else{
                int id = atoi(argv[1]);
                int sem = atoi(argv[2]);

                P(sem);

                int i;
                for(i = 0 ; i < 10 ; i++){
                        p_print(id);
                }

                V(sem);
        }       

        return 0;
}