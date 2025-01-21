echo tex
find . -name '*.tex' | wc -l

echo c
find . -name '*.c' | wc -l

echo cpp
find . -name '*.cpp' | wc -l

echo lst
find . -name '*.lst' | wc -l

echo asm
find . -name '*.asm' | wc -l

echo s
find . -name '*.s' | wc -l

echo py
find . -name '*.py' | wc -l

echo png
find . -name '*.png' | wc -l

echo jpg
find . -name '*.jpg' | wc -l

echo lines in all TeX files:
find . -name '*.tex' | xargs wc -l

echo lines in all lst files:
find . -name '*.lst' | xargs wc -l

echo lines in all c files:
find . -name '*.c' | xargs wc -l

echo lines in all cpp files:
find . -name '*.cpp' | xargs wc -l

echo lines in all s files:
find . -name '*.s' | xargs wc -l

echo lines in all asm files:
find . -name '*.asm' | xargs wc -l

echo lines in all py files:
find . -name '*.py' | xargs wc -l

