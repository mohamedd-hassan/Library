void dump_buf(std::ostream& f, uint64_t ofs, unsigned char *buf, size_t size)
{
	size_t pos=0;
	uint64_t starting_offset=0;
	uint64_t i;

	f << std::hex << std::noshowbase << std::uppercase;

	while (size-pos)
	{
		size_t wpn;
		if ((size-pos)>16)
			wpn=16;
		else
			wpn=size-pos;

		//f << "0x" << std::uppercase << starting_offset + pos + ofs <<  ": ";
		f << "0x" << starting_offset + pos + ofs <<  ": ";

		for (i=0; i<wpn; i++)
			f << std::setw(2) << std::setfill ('0') << std::uppercase << (int)buf[pos+i] << ((i==7) ? '-' : ' ');

		if (wpn<16)
			for (i=0; i<16-wpn; i++)
				f << "   ";

		f << "\"";

		for (i=0; i<wpn; i++)
			if (isprint (buf[pos+i]))
				f << (char)buf[pos+i];
			else
				f << '.';

		if (wpn<16)
			for (i=0; i<16-wpn; i++)
				f << " ";

		f << "\"" << std::endl;

		pos+=wpn;
	};
	f << std::hex << std::showbase << std::nouppercase;
};
