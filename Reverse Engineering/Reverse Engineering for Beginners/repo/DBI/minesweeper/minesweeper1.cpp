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

#define RAND "rand"

PIN_LOCK lock;

std::ofstream TraceFile;

VOID RandAfter(ADDRINT ret, ADDRINT RA, CONTEXT *ctxt, THREADID threadid)
{
	PIN_GetLock(&lock, threadid+1);
	TraceFile << "rand() returns " << ret << ", RA=" << RA << endl;
	PIN_ReleaseLock(&lock);
}
 
VOID Image(IMG img, VOID *v)
{
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

int main(int argc, char *argv[])
{
	PIN_InitSymbols();
	if( PIN_Init(argc,argv) )
		return 0;

	TraceFile.open("minesweeper1.out");
	TraceFile << hex;
	TraceFile.setf(ios::showbase);

	IMG_AddInstrumentFunction(Image, 0);
	PIN_AddFiniFunction(Fini, 0);

	// Never returns:
	PIN_StartProgram();

	return 0;
}
