%{
#include <stdio.h>
#include <string.h>
#include "util.h" 
#include "errormsg.h"
#define YYDEBUG 1
int yylex(void); /* function prototype */

/* 该函数显示错误信息s，显示时包含了错误发生的位置。*/
void yyerror(char *s)
{
 EM_error(EM_tokPos, "%s", s);
}

%}
%union {
	int ival;
	string sval;
	bool bval;
}

 /* 定义各个终结符，以及他们的属性值的类型 */
%token IDENT INT BOOL STRUCT NUMBER COMMA SEMICOLON LBRACE RBRACE TRUE1 FALSE1  IF ELSE WHILE RETURN /* id */  
%right ASSIGN
%left OR AND
%left EQ NE
%left LT LE GT GE
%right   PLUS MINUS
%left MULTI DIVIDE MOD
%right NOT UMINUS
%left POINT
%left  LBRACKET RBRACKET LPARENTHESIS RPARENTHESIS 


%debug /* 允许跟踪错误 */

%%
program : dec
        ;
dec : dec1
    | structdec dec
	;
dec1 : dec2
     | vardec dec1
	 ;
dec2 : 
      | fundef dec2
	  ;

    

structdec : STRUCT IDENT
            LBRACE
            vardec vardeclist
            RBRACE SEMICOLON
            ;
vardeclist : 
           | vardec vardeclist
           ;
vardec : type idlist SEMICOLON
       ;
idlist : IDENT 
       | IDENT COMMA idlist 
       ;       

fundef : type IDENT LPARENTHESIS paramlist RPARENTHESIS body
       ;
paramlist : 
         | tyidlist
         ;
tyidlist : type IDENT
         | type IDENT COMMA tyidlist
         ;
body : LBRACE vardeclist strmlist RBRACE
     ;

type : BOOL
     | INT
     | STRUCT IDENT
     | type LBRACKET NUMBER RBRACKET
     ;

strmlist : 
         | strm strmlist
         ;
strm : lval ASSIGN exp SEMICOLON
     | IF LPARENTHESIS exp RPARENTHESIS block SEMICOLON
     | IF LPARENTHESIS exp RPARENTHESIS block ELSE block 	SEMICOLON
     | WHILE  LPARENTHESIS exp RPARENTHESIS block SEMICOLON
     | RETURN exp SEMICOLON
     ;
block : strm
      |LBRACE strmlist RBRACE
      ;
exp : LPARENTHESIS exp RPARENTHESIS
    | NUMBER 
	| TRUE1 
	|FALSE1
    | lval
    | UMINUS exp %prec UMINUS
	| NOT exp
    | exp PLUS exp 
	| exp MINUS exp
	| exp MULTI exp
	| exp DIVIDE exp
	| exp MOD exp
	| exp OR exp
	| exp AND exp 
    | exp LT exp 
	| exp GT exp
	| exp LE exp
	| exp GE exp
	| exp EQ exp
	| exp NE exp
    | IDENT LPARENTHESIS rparam RPARENTHESIS
    ;
rparam : 
       | explist
       ;
explist : exp 
        | exp COMMA explist
        ;
lval : LPARENTHESIS lval RPARENTHESIS
		 | IDENT
		 | lval LBRACKET exp RBRACKET
		 | lval POINT IDENT
		 ;



          