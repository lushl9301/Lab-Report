#include "syscall.h"
#include "ipt.h"
#include "system.h"
#include "thread.h"

//----------------------------------------------------------------------
// hashIpt
//      Function to hash into IptHashTable.  Take a virtual page number
// and process Id.  Returns an IptEntry.
//----------------------------------------------------------------------

IptEntry *hashIPT(unsigned int vpn, SpaceId id) {
  return iptHashTable[(vpn+(id*PRIMESIZE))%IPT_HASH_TABLE_SIZE].entries;
}

//----------------------------------------------------------------------
// IptEntry::IptEntry
//      Inits data.
//----------------------------------------------------------------------

IptEntry::IptEntry(int vpnArg, int phyPageArg, IptEntry *prevIptArg)
{
  pid=currentThread->pid;
  vPage=vpnArg;
  phyPage=phyPageArg;
  prev=prevIptArg;
  next=0;
}

//----------------------------------------------------------------------
// IptEntry::~IptEntry
//      Removes from list.
//----------------------------------------------------------------------

IptEntry::~IptEntry(void)
{
  if(prev)
    prev->next=next;
  if(next)
    next->prev=prev;
}

//----------------------------------------------------------------------
// IptHashTable::IptHashTable
//      Setup the sentinel
//----------------------------------------------------------------------

IptHashTable::IptHashTable(void)
{
  entries=new IptEntry(0, 0, 0); // sentinel
}

//----------------------------------------------------------------------
// IptHashTable::~IptHashTable
//      Remove entries
//----------------------------------------------------------------------

IptHashTable::~IptHashTable(void)
{
  while(entries->next)
    delete entries->next;
  delete entries;
}

//----------------------------------------------------------------------
// MemoryTable::MemoryTable
//      set invalid
//----------------------------------------------------------------------

MemoryTable::MemoryTable(void)
{
  valid=FALSE;
}

//----------------------------------------------------------------------
// MemoryTable::~MemoryTable
//      null body
//----------------------------------------------------------------------

MemoryTable::~MemoryTable(void)
{
  // null body
}
