#include "sem.h"

int init_sem(int val){
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

void delete_sem(int sem){
        int retval = semctl(sem, 0, IPC_RMID, NULL);
        if(retval < 0) perror("Error: semctl");  
}