
#ifndef _HEADER_SEM_
#define _HEADER_SEM_
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>


int init_sem(int val);
    
void P(int sem);

void V(int sem);

void delete_sem(int sem);

#endif