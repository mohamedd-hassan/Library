#include <stdio.h>
#include <stdint.h>
#include <assert.h>

#define ARRAY_SIZE (0x1000/2*3)
uint8_t array[ARRAY_SIZE]; // tableau de triplets assez grand

unsigned int get_from_array (unsigned int idx)
{
	// trouver le bon triplet dans array:
	int triple=(idx>>1);
	int array_idx=triple*3;
	// \verb|assert (array_idx<ARRAY_SIZE);|

	if (idx&1)
	{
		// ceci est un élément impair

		// composer la valeur en utilisant l'octet du milieu et celui le plus à droite:
		return ((array[array_idx+1]&0xF) << 8)|array[array_idx+2];
	}
	else
	{
		// ceci est un élément pair

		// composer la valeur en utilisant l'octet le plus à gauche et celui du milieu:
		return array[array_idx]<<4 | ((array[array_idx+1]>>4)&0xF);
	};
};

void put_to_array (unsigned int idx, unsigned int val)
{
	//assert (val<=0xFFF);

	// trouver le bon triplet dans array:
	int triple=(idx>>1);
	int array_idx=triple*3;
	// \verb|assert (array_idx<ARRAY_SIZE);|

	if (idx&1)
	{
		// ceci est un élément impair
		// mettre la valeur dans l'octet du milieu et celui le plus à droite:

		// décomposer la valeur qui doit être stockée:
		uint8_t val_lowest_byte=val&0xFF; // isoler les 8 bits les plus bas
		uint8_t val_highest_nibble=val>>8; // pas besoin d'appliquer \&0xF, nous connaissons déjà val<=0xFFF

		// effacer les 4 bits bas de l'octet du milieu:
		array[array_idx+1]=array[array_idx+1]&0xF0;

		array[array_idx+1]=array[array_idx+1]|val_highest_nibble;
		array[array_idx+2]=val_lowest_byte;
	}
	else
	{
		// ceci est un élément pair
		// mettre la valeur dans l'octet le plus à gauche et celui du milieu:

		// décomposer la valeur qui doit être stockée:
		uint8_t val_highest_byte=val>>4;
		uint8_t val_lowest_nibble=val&0xF;

		array[array_idx]=val_highest_byte;

		// effacer les 4 bits haut de l'octet du milieu:
		array[array_idx+1]=array[array_idx+1]&0xF;
		array[array_idx+1]=array[array_idx+1]|val_lowest_nibble<<4;
	};
};

int main()
{
	int i;

	// tester
	for (i=0; i<0x1000; i++)
	{
		put_to_array(i, i);
	};

	for (i=0; i<0x1000; i++)
	{
		assert(get_from_array(i)==i);
	};
	// \verb|put_to_array(0x1000, 1); // va planter à cause de assert()|

	// afficher les triples:
	for (int i=0;i<0x1000/2;i++)
		printf ("0x%02X%02X%02X\n",array[i*3],array[i*3+1],array[i*3+2]);
};
