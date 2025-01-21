all:    UAL-EN UAL-RU UAL-DE UAL-FR UAL-JA UAL-IT UAL-PL RE4B-RU RE4B-EN RE4B-DE RE4B-FR RE4B-JA RE4B-IT RE4B-PL

clean:
	rm -f *.aux
	rm -f *.fls
	rm -f *.swp
	rm -f *.pdf
	rm -f *.out
	rm -f *.toc
	rm -f *.stackdump
	rm -f *.bbl
	rm -f *.blg
	rm -f *.fdb_latexmk
	rm -f *.idx
	rm -f *.ilg
	rm -f *.ind
	rm -f *.html
	rm -f *.tmp
	rm -f *-2k
	rm -f *.4ct
	rm -f *.4tc
	rm -f *.dvi
	rm -f *.glg
	rm -f *.glo
	rm -f *.gls
	rm -f *.idv
	rm -f *.ist
	rm -f *.xref
	rm -f *.torrent
	rm -f RE_for_beginners-*.log
	rm -f Reverse_Engineering_for_Beginners-*.log
	rm -f RE4B-*.log
	rm -f *~
	rm -f *.log
	rm -f *.lyx
	rm -f *.ni
	rm -f *.odt
	rm -f *.rtf
	rm -f *.bcf
	rm -f *.xml

# there are two xelatex invocations at the end, because \myref{} doesn't show pages correctly otherwise
define compile
	rm -f *.fls
	rm -f *.bbl
	rm -f *.aux
	xelatex $1
	makeindex $1
	makeglossaries $1
	xelatex $1
	xelatex $1
endef

RE4B-RU:
	$(call compile,RE4B-RU)

RE4B-EN:
	$(call compile,RE4B-EN)

RE4B-ES:
	$(call compile,RE4B-ES)

RE4B-PTBR:	
	$(call compile,RE4B-PTBR)

RE4B-PL:
	$(call compile,RE4B-PL)

RE4B-IT:
	$(call compile,RE4B-IT)

RE4B-DE:
	$(call compile,RE4B-DE)

RE4B-TH:
	$(call compile,RE4B-TH)

RE4B-NL:
	$(call compile,RE4B-NL)

RE4B-FR:
	$(call compile,RE4B-FR)

RE4B-JA:
	$(call compile,RE4B-JA)

RE4B-TR:
	$(call compile,RE4B-TR)

UAL-RU:
	$(call compile,UAL-RU)

UAL-EN:
	$(call compile,UAL-EN)

UAL-DE:
	$(call compile,UAL-DE)

UAL-FR:
	$(call compile,UAL-FR)

UAL-JA:
	$(call compile,UAL-JA)

UAL-TR:
	$(call compile,UAL-TR)

UAL-IT:
	$(call compile,UAL-IT)

UAL-PL:
	$(call compile,UAL-PL)
