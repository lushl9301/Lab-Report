//----------------------------------------------------------------------
// VpnToPhyPage
//      Gets a phyPage for a vpn, if exists in ipt.
//----------------------------------------------------------------------

int VpnToPhyPage(int vpn) {
    IptEntry *iptEntryPtr = hashIPT(vpn, currentThread->pid);
    
    while (iptEntryPtr->next) {
        iptEntryPtr = iptEntryPtr->next;
        if (iptEntryPtr->pid == currentThread->pid
            && iptEntryPtr->vPage == vpn) {
            //page found
            return iptEntryPtr->phyPage;
        }
    }
    //page fault
    return -1;     
}

//----------------------------------------------------------------------
// InsertToTLB
//      Put a vpn/phyPage combination into the TLB. If TLB is full, use FIFO 
//	replacement
//----------------------------------------------------------------------

static int FIFOPos = 0;

void InsertToTLB(int vpn, int phyPage) {
    int i = 0; //entry in the TLB
    for (; i < TLBSize; ++i) { //find the first valid entry
        if (!machine->tlb[i].valid) {
            break;
        }
    }
    if (i == TLBSize) {
        i = FIFOPos;
        //cannot find
        //set to FIFO
    }
    FIFOPos = (i + 1) % TLBSize;
    
    if(machine->tlb[i].valid){
        memoryTable[machine->tlb[i].physicalPage].dirty=machine->tlb[i].dirty;
        memoryTable[machine->tlb[i].physicalPage].TLBentry=-1;
    }
    
    //update the TLB entry
    machine->tlb[i].virtualPage  = vpn;
    machine->tlb[i].physicalPage = phyPage;
    machine->tlb[i].valid        = TRUE;
    machine->tlb[i].readOnly     = FALSE;
    machine->tlb[i].use          = FALSE;
    machine->tlb[i].dirty        = memoryTable[phyPage].dirty;
    
    //update the corresponding memoryTable
    memoryTable[phyPage].TLBentry=i;
    DEBUG('p', "The corresponding TLBentry for Page %i in TLB is %i ", vpn, i);
    memoryTable[phyPage].clockCounter=0;
}

//----------------------------------------------------------------------
// clockAlgorithm
//      Determine where a vpn should go in phymem, and therefore what
// should be paged out. This clock algorithm is a variant of the one 
// discussed in the lectures.
//----------------------------------------------------------------------

static int clockPos = 0;

int clockAlgorithm(void) {
    int phyPage;
    while (true) {
        if ((!memoryTable[clockPos].valid)
            || ((!memoryTable[clockPos].dirty) && (memoryTable[clockPos].clockCounter >= OLD_ENOUGH))
            || ((memoryTable[clockPos].dirty) && (memoryTable[clockPos].clockCounter >= OLD_ENOUGH + DIRTY_ALLOWANCE))) {
            phyPage = clockPos;
            break;
        }
        ++memoryTable[clockPos].clockCounter; //aging
        clockPos = (clockPos + 1) % NumPhysPages;
    }

    clockPos = (clockPos + 1) % NumPhysPages; //advance clock to next entry
    return phyPage;
}
