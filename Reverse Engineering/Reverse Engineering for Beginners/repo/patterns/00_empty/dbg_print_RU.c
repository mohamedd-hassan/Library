void dbg_print (const char *fmt, ...)
{
#ifdef _DEBUG
        // открыть лог-файл
        // записать в лог-файл
        // закрыть лог-файл
#endif
};

void some_function()
{
        ...

        dbg_print ("we did something\n");

        ...
};
