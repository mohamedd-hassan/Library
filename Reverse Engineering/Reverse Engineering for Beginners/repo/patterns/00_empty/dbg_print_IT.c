void dbg_print (const char *fmt, ...)
{
#ifdef _DEBUG
        // apri file di log
        // scrivi nel file di log
        // chiudi il file di log
#endif
};

void some_function()
{
        ...

        dbg_print ("we did something\n");

        ...
};
