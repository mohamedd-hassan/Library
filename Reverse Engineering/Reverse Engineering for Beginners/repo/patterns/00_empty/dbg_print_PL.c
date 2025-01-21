void dbg_print (const char *fmt, ...)
{
#ifdef _DEBUG
        // otwórz plik z logami
        // zapisz do pliku z logami
        // zamknij plik z logami
#endif
};

void some_function()
{
        ...

        dbg_print ("we did something\n");

        ...
};
