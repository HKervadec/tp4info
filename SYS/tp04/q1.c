#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>

int init(){
        int mysem = semget(IPC_PRIVATE, 1, 0666 | IPC_CREAT);
        if(mysem < 0) perror("Error: semget");

        int retval;
        union semun
        {
                int val;
                struct semid_ds *buf;
                ushort *array;
        } arg;

        arg.val = 0;  // Valeur d'initialisation
        /* Init its value to arg.val (0) */
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
        if(retval != 0) perror("error: semop");
}

void V(int sem){
        struct sembuf op;

        op.sem_num = 0;
        op.sem_op = 1; //1=V, -1=P
        op.sem_flg = 0;

        int retval = semop(sem, &op, 1);
        if(retval != 0) perror("error: semop");
}

void delete(int sem){
        int retval = semctl(sem, 0, IPC_RMID, NULL);
        if(retval < 0) perror("Error: semctl");  
}

int main() {
        int mysem = init();
        
        if (!fork()) {
                printf("Toto\n");
                P(mysem);

                printf("Toto4\n");
                
                delete(mysem);

                printf("Toto5\n");
        } else {
                sleep(2);

                printf("Toto2\n");
                V(mysem);
                printf("Toto3\n");
        }    
        return 0;
}
