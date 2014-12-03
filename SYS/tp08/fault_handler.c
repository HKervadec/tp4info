/*
 * fault_handler.c
 *
 *  Created on: 1 nov. 2008
 *      Author: lescouarnecn
 */
#include "mmu.h"
#include "physical_memory.h"
#include "swap.h"
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <assert.h>

#include <time.h>

// Page fault handler
//     Free one page if needed
//     Get free page
//     Load
//     Update MMU

enum state_page {SWAPPED, ALLOCATED, NOTMAPPED};

#define PRECLEAN

struct page_table_entry{
	enum state_page status;
	page_phys pp;
};

// Page table
struct page_table_entry* page_table;
int page_table_size;

// List of allocated pages
page_virt* allocated_pages;
int allocated_pages_capacity;
int allocated_pages_size;
int allocated_pages_first;
int allocated_pages_free;




void init_faultHandler(int nb_pages_virt, int nb_pages_phys){
	srand(time(NULL));
	int i;
	page_table = (struct page_table_entry*)malloc(sizeof(struct page_table_entry)*nb_pages_virt);
	page_table_size = nb_pages_virt;
	for(i = 0 ; i < nb_pages_virt ; i++){
		page_table[i].pp = INVALID;
		page_table[i].status = NOTMAPPED;
	}

	allocated_pages = (page_virt*)malloc(sizeof(page_virt)*nb_pages_phys);
	allocated_pages_capacity = nb_pages_phys;
	for(i = 0 ; i < nb_pages_phys ; i++){
		allocated_pages[i] = INVALID;
	}
}

void unloadAPage();
void loadAPage(page_virt pv);

void page_fault_handler(page_virt pv){
	// Get a Free block
	if(pm_isFull()){
		printf("PF: Unload a page\n");
		unloadAPage(); // fill
	}
	page_phys pp = pm_getFreePage();

	// Mark page as loaded
	printf("PF: Load a page (%d)\n",pv);
	loadAPage(pv); // fill

	// Read from Swap
	if(page_table[pv].status == SWAPPED){
		swap_read(pv,pp);
	}

	// Update page table
	page_table[pv].pp=pp;
	page_table[pv].status=ALLOCATED;

	// Write to MMU
	mmu_addTranslation(pv,pp);

	// That's all
}

#ifdef POLICY_FIFO
void unloadAPage(){
	// Fill
}

void loadAPage(page_virt pv){
	// Fill
}
#endif

#ifdef POLICY_RANDOM
void unloadAPage(){
	int pp_id = rand() % allocated_pages_capacity;

	page_virt pv = allocated_pages[pp_id];
	page_phys pp = page_table[pv].pp;

	swap_write(pv, pp);
	page_table[pv].status = SWAPPED;

	allocated_pages[pp_id] = INVALID;
	pm_freePage(pp);

	mmu_invalidatePage(pv);

	allocated_pages_free = pp_id;
}

void loadAPage(page_virt pv){
	allocated_pages[allocated_pages_free++] = pv;
}
#endif

#ifdef POLICY_CLOCK
void unloadAPage(){


	// 
}

void loadAPage(page_virt pv){
	// Fill
}
#endif


