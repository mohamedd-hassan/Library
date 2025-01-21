// based on emudiv.cpp

// by dennis(a)yurichev.com

#include <stdio.h>
#include "pin.H"
#include <iostream>
#include <fstream>

std::ofstream TraceFile;

KNOB<string> KnobOutputFile(KNOB_MODE_WRITEONCE, "pintool",
	"o", "XOR_ins.out", "specify trace file name");

std::map<ADDRINT, int> XORs;
PIN_LOCK lock;

// ==== these functions executed during runtime (begin) ====
VOID log_info (ADDRINT ip, ADDRINT op1, ADDRINT op2)
{
	if (op1!=op2 && op1!=0 && op2!=0 && op1!=0xffffffff && op2!=0xffffffff)
	{
		//TraceFile << "ip=" << ip << " op1=" << op1 << " op2=" << op2 << endl;
		XORs[ip]=XORs[ip]+1;
	};
};

VOID XOR_reg_reg(ADDRINT ip, ADDRINT op1, ADDRINT op2, THREADID threadid)
{
	PIN_GetLock(&lock, threadid+1);
	log_info (ip, op1, op2);
	PIN_ReleaseLock(&lock);
}

VOID XOR_mem_reg(ADDRINT ip, ADDRINT *op1_addr, unsigned int op1_size, ADDRINT op2, THREADID threadid)
{
	PIN_GetLock(&lock, threadid+1);
	ADDRINT op1;
	PIN_SafeCopy(&op1, op1_addr, op1_size);
	log_info (ip, op1, op2);
	PIN_ReleaseLock(&lock);
};

// save stat, do not track registers (yet)
VOID PXOR(ADDRINT ip, THREADID threadid)
{
	PIN_GetLock(&lock, threadid+1);
	//TraceFile << "PXOR at " << ip << endl;
	XORs[ip]=XORs[ip]+1;
	PIN_ReleaseLock(&lock);
}
// ==== these functions executed during runtime (end) ====

// this function executed only during startup, so no need to optimize anything here:
VOID InstrumentXOR(INS ins, VOID* v)
{
	// XOR reg, reg
	if ((INS_Mnemonic(ins) == "XOR") && (INS_OperandIsReg(ins, 0)) && (INS_OperandIsReg(ins, 1)))
	{
		INS_InsertCall(ins,
			IPOINT_BEFORE,
			AFUNPTR(XOR_reg_reg),
			IARG_INST_PTR,
			IARG_REG_VALUE, REG(INS_OperandReg(ins, 0)),
			IARG_REG_VALUE, REG(INS_OperandReg(ins, 1)),
			IARG_THREAD_ID,
			IARG_END);
	}

	// XOR mem, reg
	if ((INS_Mnemonic(ins) == "XOR") && INS_OperandIsMemory(ins, 0) && INS_OperandIsReg(ins, 1))
	{
		INS_InsertCall(ins,
			IPOINT_BEFORE,
			AFUNPTR(XOR_mem_reg),
			IARG_INST_PTR,
			IARG_MEMORYREAD_EA,
			IARG_MEMORYREAD_SIZE,
			IARG_REG_VALUE, REG(INS_OperandReg(ins, 1)),
			IARG_THREAD_ID,
			IARG_END);
	}

	// XOR reg, mem
	if ((INS_Mnemonic(ins) == "XOR") && INS_OperandIsReg(ins, 0) && INS_OperandIsMemory(ins, 1))
	{
		INS_InsertCall(ins,
			IPOINT_BEFORE,
			AFUNPTR(XOR_mem_reg),
			IARG_INST_PTR,
			IARG_MEMORYREAD_EA,
			IARG_MEMORYREAD_SIZE,
			IARG_REG_VALUE, REG(INS_OperandReg(ins, 0)),
			IARG_THREAD_ID,
			IARG_END);
	}

	if ((INS_Mnemonic(ins) == "PXOR"))
	{
		INS_InsertCall(ins,
			IPOINT_BEFORE,
			AFUNPTR(PXOR),
			IARG_INST_PTR,
			IARG_THREAD_ID,
			IARG_END);
	}
}

INT32 Usage()
{
	cerr << "This tool intercepts XOR/PXOR" << endl;
	cerr << KNOB_BASE::StringKnobSummary() << endl << flush;
	return -1;
}

VOID Fini(INT32 code, VOID *v)
{
	for (auto i=XORs.begin(); i!=XORs.end(); i++)
		TraceFile << "ip=" << i->first << " count=" << i->second << endl;
	TraceFile.close();
}

int main(int argc, char * argv[])
{
	if (PIN_Init(argc, argv))
		return Usage();

	TraceFile.open(KnobOutputFile.Value().c_str());

	TraceFile << std::hex << std::showbase;
	INS_AddInstrumentFunction(InstrumentXOR, 0);
	PIN_AddFiniFunction(Fini, 0);
	PIN_StartProgram();// Never returns

	return 0;
}
