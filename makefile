parser0.exe: parsetest.o parser.tab.o lex.yy.o errormsg.o util.o 
	gcc -o parser0 parsetest.o parser.tab.o lex.yy.o errormsg.o util.o 

lex.yy.c: parser.l parser.tab.h  util.h
	flex parser.l

parsetest.o: parsetest.c errormsg.h util.h
	gcc -c parsetest.c

parser.tab.o: parser.tab.c util.h errormsg.h
	gcc -c parser.tab.c

parser.tab.c: parser.y
	bison -dv parser.y

parser.tab.h: parser.tab.c
	echo "parser.tab.h was created at the same time as parser.tab.c"

errormsg.o: errormsg.c errormsg.h util.h
	gcc -c errormsg.c


lex.yy.o: lex.yy.c parser.tab.h errormsg.h util.h
	gcc -c lex.yy.c


util.o: util.c util.h
	gcc -c util.c


#²âÊÔÀıtest.c£¨ÕıÈ·ÊäÈë£©
test00:
	./parser0.exe testcases/test.c

#²âÊÔÀıtest0.p £¨´íÎóÊäÈë£©
test01:
	./parser0.exe testcases/test1.p


clean: 
	rm -f parser0.exe util.o parsetest.o lex.yy.o errormsg.o parser.tab.c parser.tab.h parser.tab.o *.stackdump parser.output *.out *.bak lex.yy.c

