# Want to translate this book to another language?

Get a source code: https://beginners.re/src/
Or: git clone https://beginners.re/git/

Take a look on git repository: https://beginners.re/current-tree/
For example, `main_EN.tex` for English, `main_RU.tex` for Russian, etc.
So just find `filename_EN.tex` file you want to translate, copy to filename_XX.tex (where XX is your language)
and replace English text by yours.
No special TeX/LaTeX knowledge is needed.
Then just send it to me: dennis(a)yurichev.com

Please submit your work as early as possible: other translators will be aware of the piece of work already done.

Korean and Persian languages are reserved by publishers.

## Content over everything else

Do not focus on typography, fonts, nice-looking visual candy and other fancy TeX features.
The most important thing here is a text, so this is first priority.

Also, you may ignore all TeX errors, I'll fix them later.

## Style

I deeply convinced that technical literature should should be terse and formal.
Imagine you've got some reference book on your bookshelf.
You need it once a month, to get Pi exact value from it or something like that.
Perfect reference is a book where you'll see "Pi=3.14159..." and nothing else.
Informal or verbose language in technical books annoys you each time you looking up for the information you need.

## Language

On the other hand, terminology may be informal, just as typical modern IT bloggers use.
Don't hesitate to use English words in your language if this is norm in IT speech of your language and there are no good translation yet.
For example, Russian IT language is a mix of Russian and English words, and this is current language norm (at least in 2016), so I use this language in the book.

## Defined macros

Spanish: `\ES{}`
Brazilian Portuguese: `\PTBR{}`
Polish: `\PL{}`
Italian: `\ITA{}`
German: `\DE{}`
Thai: `\THA{}`
Dutch: `\NL{}`

There are also `\ESph{}`, `\PTBRph{}`, `\PLph{}`, `\DEph{}` and `\ITAph{}` placeholder macros in `*.tex` files, where the translated text must be.

## Compiling

To check your results, just run `make RE4B-ES`, `make RE4B-PTBR`, `make RE4B-PL`, `make RE4B-IT`, `make RE4B-DE`.
You'll see almost blank pages with only listings and screenshots, without any text, but your text will be present.

## Coordination

It's very frustrating to find out that a piece of text you have just translated has been translated by someone else
at the very same time.
For a simple coordination, you can leave a text file named like "Note_to_German_translators.txt"
in the directory you're currently working with contents like

	I'm going to translate this part soon.
	-- my@email.com, username@github.com, DD/MM/YYYY.

You can jokingly call it "mutex".
Feel free to add any other notes for rest of translators.

If you are not familiar with git, just send me fragment you translated, so I could add it as early as possible.

## Keeping translation in sync

Whenever I add/modify some part of text, I also add "\ac{TBT}" (To Be Translated) mark to other translations,
into a place where translation should be updated.
And/or, I add commentary at the first line of each translated file, which should be updated.

## Listings

There was a time (before Jan-2019) when I wrote this:

	listings TeX package sometimes goes crazy if it encounters UTF-8 character(s) and digit(s) in one line: [stack overflow discussion](http://tex.stackexchange.com/questions/24528/having-problems-with-listings-and-utf-8-can-it-be-fixed).
	So it must be escaped, and in this project, "paragraph" symbol is used: `§`.
	(Almost) all Cyrillic comments in listings are escaped.
	How to escape French diacritic symbols...
	Do not worry about misplacing them or not placing at all, I'll fix it by myself.

	For those, who interested, § symbol is in fact switches you into TeX mode, and you can write anything here as in .tex files, like `\IT{italic}`, etc.
	This is why single `$` symbol cannot be used inside escaped line.

In Jan-2019 I learnt about "texcl=true" and now all comments in listings are already in TeX mode.
But, several characters needs to be escaped, as in usual TeX code: $, #, %, \, etc.
To be on safe side, use \verb|comment|.
But if a comment itself contains pipe symbol ("|"), you can do this: \verb!comment!.

However, \verb|long_string| is unbreakable and thus is not suitable for long strings...
In this case, I enclose smaller parts of comment in listing...

"§" symbol is still to be used in code, but not in comments.
This is a case of translated variable names, like:
https://beginners.re/current-tree/patterns/09_loops/simple/loops_1_RU.c
https://beginners.re/current-tree/patterns/09_loops/simple/loops_3_RU.c

## Contact me

Do not hesitate to contact me if you have any questions: dennis(a)yurichev.com

