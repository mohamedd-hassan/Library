#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

uint64_t CRC64(uint64_t crc, uint8_t *buf, size_t len)
{
        int k;

        crc = ~crc;
        while (len--)
        {
                crc ^= *buf++;
                for (k = 0; k < 8; k++)
                        crc = crc & 1UL ? (crc >> 1) ^ 0x42f0e1eba9ea3693UL : crc >> 1;
        }
        return crc;
}

int check_license()
{
        FILE* f=fopen ("license.dat", "rt");
        assert (f!=NULL);
        char user[128];
        int tmp;
        tmp=fscanf(f, "%s", user);
        assert (tmp!=0);
        uint64_t SN;
        tmp=fscanf(f, "%llx", &SN);
        assert (tmp!=0);
        uint64_t must_be=CRC64(0, user, strlen(user));
        //printf ("must_be=0x%llx\n", must_be);
        //printf ("SN=0x%llx\n", SN);
        if (must_be==SN)
        {
                //printf ("License is OK\n");
                return 1;
        }
        else
        {
                //printf ("License check failed!\n");
                return 0;
        }
};

int main()
{
        printf ("A mega-software v2.0\n");
        if (check_license())
                printf ("Now we are going to do something important...\n");
        else
                printf ("No license, exiting\n");

        printf ("... did something ...\n");

        if (check_license())
                printf ("Now we are going to do something important...\n");
        else
                printf ("No license, exiting\n");

        printf ("... did something ...\n");

        if (check_license())
                printf ("Now we are going to do something important...\n");
        else
                printf ("No license, exiting\n");
};

