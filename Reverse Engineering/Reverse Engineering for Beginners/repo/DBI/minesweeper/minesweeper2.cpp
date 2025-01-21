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

int my_rand(ADDRINT RA, THREADID threadid)
{
	PIN_GetLock(&lock, threadid+1);
	TraceFile << "my_rand() RA=" << RA << endl;
	PIN_ReleaseLock(&lock);

	return 0; // <- the value returned by our rand() implementation
};

VOID Image(IMG img, VOID *v)
{
	RTN randRtn = RTN_FindByName(img, RAND);
	if (RTN_Valid(randRtn))
	{
		PROTO protoOfRand = PROTO_Allocate( PIN_PARG(int), CALLINGSTD_DEFAULT, "protoOfRand", PIN_PARG_END() );

		RTN_ReplaceSignature (randRtn, (AFUNPTR)my_rand, 
			IARG_PROTOTYPE, protoOfRand,
			IARG_RETURN_IP,
			IARG_THREAD_ID,
			IARG_END);

		PROTO_Free (protoOfRand);
	};
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

	TraceFile.open("minesweeper2.out");
	TraceFile << hex;
	TraceFile.setf(ios::showbase);

	IMG_AddInstrumentFunction(Image, 0);
	PIN_AddFiniFunction(Fini, 0);

	// Never returns:
	PIN_StartProgram();

	return 0;
}
