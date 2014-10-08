#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>


int main() {
        /* Create a set of one semaphore. */
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

        struct sembuf op;

        if (!fork()) {
                op.sem_num = 0;
                op.sem_op = -1; //1=V, -1=P
                op.sem_flg = 0;

                printf("Toto\n");
                /* Do the P with the semaphore */
                retval = semop(mysem, &op, 1);
                if(retval != 0) perror("error: semop");

                printf("Toto4\n");
                /* Remove the semaphore and awake all P */
                retval = semctl(mysem, 0, IPC_RMID, arg);
                printf("Toto5\n");
                if(retval < 0) perror("Error: semctl");  
        } else {
                sleep(2);
                op.sem_num = 0;
                op.sem_op = 1; //1=V, -1=P
                op.sem_flg = 0;

                printf("Toto2\n");
                /* Do the V to the semaphore */
                retval = semop(mysem, &op, 1);
                printf("Toto3\n");
                if(retval != 0) perror("error: semop");
        }    
        return 0;
}
