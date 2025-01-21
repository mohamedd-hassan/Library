#include "pin.H"

#include <iostream>
#include <iomanip>
#include <fstream>
#include <map>
#include <vector>
#include <set>
#include <algorithm>

#include <math.h>
#include <ctype.h>
#include <stdint.h>
#include <assert.h>

#define MALLOC "malloc"
#define FREE "free"
#define REALLOC "realloc"
#define RAND "rand"

#include "dump_buf.h"

#define WIDTH 9
#define HEIGHT 9
#define MINES 10
#define ADDR_OF_RAND 0x10002770d

PIN_LOCK lock;

int memory_track=1;

std::ofstream TraceFile;
std::map<ADDRINT, ADDRINT> blocks; // addr, size
std::set<ADDRINT> blocks_between_rand; // was modified between 1st and 2nd rand() calls

bool MallocEntered=false;
ADDRINT MallocEntered_arg1;

bool ReallocEntered=false;
ADDRINT ReallocEntered_arg1;
ADDRINT ReallocEntered_arg2;

int count_distinct(int *p, size_t n)
{
	std::vector<int> t(p, p+n);
	std::sort(t.begin(), t.end());
	auto it=std::unique(t.begin(), t.end());
	t.resize(distance(t.begin(), it));
	
	return t.size();
};

void try_to_dump_cells(std::ostream& f, unsigned char *buf, size_t size)
{
	int *p=(int *)buf;

	// must be aligned on 4-byte boundary
	if (size&3)
		return;
	size_t n=size/4;

	if (n>WIDTH*HEIGHT)
		return;

	//are all cells in 0..WIDTH*HEIGHT range?
	for (int i=0; i<n; i++)
		if (p[i]>=WIDTH*HEIGHT)
			return;

	int cells[HEIGHT][WIDTH];
	memset(cells, 0, sizeof(cells));

	for (int i=0; i<n; i++)
	{
		int row=p[i] / WIDTH;
		int col=p[i] % HEIGHT;
		if (row>=0 && row<HEIGHT && col>=0 && col<WIDTH)
			cells[row][col]=1;
	};

	int uniq=count_distinct(p, n);
	
	TraceFile << __FUNCTION__ "(). unique elements=" << uniq << endl;

	if (uniq==MINES)
		memory_track=0;

	for (int r=0; r<HEIGHT; r++)
	{
		for (int c=0; c<WIDTH; c++)
			TraceFile << (cells[r][c] ? "*" : ".");

		TraceFile << endl;
	};
};

VOID MallocBefore(ADDRINT size, VOID* ip, THREADID threadid)
{
	PIN_GetLock(&lock, threadid+1);
	TraceFile << "malloc" << "(" << size << ") IP=" << ip << endl;
	MallocEntered=true;
	MallocEntered_arg1=size;
	PIN_ReleaseLock(&lock);
}

VOID MallocAfter(ADDRINT ret, THREADID threadid)
{
	if (MallocEntered==false)
		return;
	PIN_GetLock(&lock, threadid+1);
	TraceFile << "malloc() returns " << ret << endl;
	blocks[ret]=MallocEntered_arg1;
	MallocEntered=false;
	PIN_ReleaseLock(&lock);
}

VOID ReallocBefore(ADDRINT addr, ADDRINT size, VOID* ip, THREADID threadid)
{
	PIN_GetLock(&lock, threadid+1);
	TraceFile << "realloc(" << addr << " " << size << ") IP=" << ip << endl;
	ReallocEntered=true;
	ReallocEntered_arg1=addr;
	ReallocEntered_arg2=size;
	PIN_ReleaseLock(&lock);
}

VOID ReallocAfter(ADDRINT ret, THREADID threadid)
{
	if (ReallocEntered==false)
		return;
	PIN_GetLock(&lock, threadid+1);
	TraceFile << "realloc() returns " << ret << endl;
	blocks.erase(ReallocEntered_arg1);
	blocks[ret]=ReallocEntered_arg2; // new size for new addr
	if (blocks_between_rand.find(ReallocEntered_arg2) != blocks_between_rand.end())
	{
		blocks_between_rand.erase(ReallocEntered_arg2);
		blocks_between_rand.insert(ret);
	};
	ReallocEntered=false;
	PIN_ReleaseLock(&lock);
}

VOID FreeBefore(ADDRINT addr, THREADID threadid)
{
	PIN_GetLock(&lock, threadid+1);
	TraceFile << "free(" << addr << ")" << endl;

	if (blocks.find(addr)!=blocks.end())
	{
		ADDRINT size=blocks[addr];

		TraceFile << "free(): we have this block in our records, size=" << size << endl;

		if (blocks_between_rand.find(addr)!=blocks_between_rand.end())
		{
			unsigned char* buf=(unsigned char*)malloc(size);
			PIN_SafeCopy (buf, (VOID*)addr, size);

			dump_buf(TraceFile, addr, buf, size);
			try_to_dump_cells(TraceFile, buf, size);

			free (buf);

			blocks_between_rand.erase(addr);
		};

		blocks.erase(addr);
	}
	else
		TraceFile << "free(): we don't find this block in our records" << endl;
	PIN_ReleaseLock(&lock);
}

int our_rand_called=0;

VOID RandAfter(ADDRINT ret, ADDRINT RA, CONTEXT *ctxt, THREADID threadid)
{
	PIN_GetLock(&lock, threadid+1);
	TraceFile << "rand() returns " << ret << ", RA=" << RA << endl;
	if (RA==ADDR_OF_RAND)
		our_rand_called++;
	if (our_rand_called==2)
		TraceFile << "blocks_between_rand.size()=" << blocks_between_rand.size() << endl;

	PIN_ReleaseLock(&lock);
}
 
VOID Image(IMG img, VOID *v)
{
	RTN mallocRtn = RTN_FindByName(img, MALLOC);
	if (RTN_Valid(mallocRtn))
	{
		RTN_Open(mallocRtn);

		RTN_InsertCall(mallocRtn, IPOINT_BEFORE, (AFUNPTR)MallocBefore,
			IARG_FUNCARG_ENTRYPOINT_VALUE, 0,
			IARG_INST_PTR, IARG_THREAD_ID,
			IARG_END);
		RTN_InsertCall(mallocRtn, IPOINT_AFTER, (AFUNPTR)MallocAfter,
			IARG_FUNCRET_EXITPOINT_VALUE, IARG_THREAD_ID, IARG_END);

		RTN_Close(mallocRtn);
	}

	RTN reallocRtn = RTN_FindByName(img, REALLOC);
	if (RTN_Valid(reallocRtn))
	{
		RTN_Open(reallocRtn);

		RTN_InsertCall(reallocRtn, IPOINT_BEFORE, (AFUNPTR)ReallocBefore,
			IARG_FUNCARG_ENTRYPOINT_VALUE, 0,
			IARG_FUNCARG_ENTRYPOINT_VALUE, 1,
			IARG_INST_PTR, IARG_THREAD_ID,
			IARG_END);
		RTN_InsertCall(reallocRtn, IPOINT_AFTER, (AFUNPTR)ReallocAfter,
			IARG_FUNCRET_EXITPOINT_VALUE, IARG_THREAD_ID, IARG_END);

		RTN_Close(reallocRtn);
	}

	RTN freeRtn = RTN_FindByName(img, FREE);
	if (RTN_Valid(freeRtn))
	{
		RTN_Open(freeRtn);

		RTN_InsertCall(freeRtn, IPOINT_BEFORE, (AFUNPTR)FreeBefore,
			IARG_FUNCARG_ENTRYPOINT_VALUE, 0, IARG_THREAD_ID,
			IARG_END);
		RTN_Close(freeRtn);
	}

	RTN randRtn = RTN_FindByName(img, RAND);
	if (RTN_Valid(randRtn))
	{
		RTN_Open(randRtn);

		RTN_InsertCall(randRtn, IPOINT_AFTER, (AFUNPTR)RandAfter,
			IARG_FUNCRET_EXITPOINT_VALUE, IARG_RETURN_IP, IARG_CONTEXT, IARG_THREAD_ID, IARG_END);

		RTN_Close(randRtn);
	}
}

VOID Fini(INT32 code, VOID *v)
{
	TraceFile.close();
}

// if val in [begin, end]
bool in_range_incl (ADDRINT val, ADDRINT begin, ADDRINT end)
{
	return val>=begin && val<=end;
};

VOID RecordMemWrite(VOID * ip, VOID* addr, UINT32 size, THREADID threadid)
{
	if (our_rand_called==0)
		return;
	if (our_rand_called>MINES)
		return;
	if (memory_track==0)
		return;

	PIN_GetLock(&lock, threadid+1);
	
	// enumerate all known blocks
	for (auto k=blocks.begin(); k!=blocks.end(); k++)
	{
		// is it ours?
		if (in_range_incl ((ADDRINT)addr, k->first, k->first + k->second))
		{
			// are we between two first rand() calls?
			if (our_rand_called==1)
				blocks_between_rand.insert(k->first);
			break;
		};
	};
	PIN_ReleaseLock(&lock);
}

VOID Instruction(INS ins, VOID *v)
{
	UINT32 memOperands = INS_MemoryOperandCount(ins);

	for (UINT32 memOp = 0; memOp < memOperands; memOp++)
	{
		if (INS_MemoryOperandIsWritten(ins, memOp))
		{
			INS_InsertPredicatedCall(
				ins, IPOINT_BEFORE, (AFUNPTR)RecordMemWrite,
				IARG_INST_PTR,
				IARG_MEMORYOP_EA, memOp,
				IARG_MEMORYWRITE_SIZE, IARG_THREAD_ID,
				IARG_END);
		}
	}
}

int main(int argc, char *argv[])
{
	PIN_InitSymbols();
	if( PIN_Init(argc,argv) )
		return 0;

	TraceFile.open("minesweeper3.out");
	TraceFile << hex;
	TraceFile.setf(ios::showbase);

	IMG_AddInstrumentFunction(Image, 0);
	INS_AddInstrumentFunction(Instruction, 0);
	PIN_AddFiniFunction(Fini, 0);

	// Never returns:
	PIN_StartProgram();

	return 0;
}
