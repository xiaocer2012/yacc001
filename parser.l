
%{
#include "util.h" 
#include "parser.tab.h"
int yywrap (void){
  return 1;
}

%}

 
/*变量、数字、空白等的正则表达式*/
ident   [A-Za-z][0-9A-Za-z]*
number  [0-9][0-9]*
delim		[ \t \n]
ws			{delim}+
/*
   处理注释（两种注释）
   若使用ECHO，则可以将注释打印出来；
   若不使用ECHO，则注释直接被忽略。
*/
%s COMMENT1 COMMENT2
%%
<INITIAL>"/*"						  {BEGIN COMMENT1;}
<COMMENT1>"*/"						{BEGIN INITIAL;}
<COMMENT1>.|\n                    {;}
<INITIAL>"//"             {BEGIN COMMENT2;} 
<COMMENT2>\n              {BEGIN INITIAL;}
<COMMENT2>.|\n                    {;}
 
<INITIAL>{ws}	               {;}
<INITIAL>"if"	               {return (IF);}
<INITIAL>"else"		           {return (ELSE);}
<INITIAL>"while"				     {return (WHILE);}
<INITIAL>"int"	             {return (INT);}
<INITIAL>"bool"	             {return (BOOL);}
<INITIAL>"struct"	           {return (STRUCT);}
<INITIAL>"true"	             {return (TRUE1);}
<INITIAL>"false"	           {return (FALSE1);}

<INITIAL>"<"	          {return (LT);}
<INITIAL>"<="	          {return (LE);}
<INITIAL>">"	          {return (GT);}
<INITIAL>">="	          {return (GE);}
<INITIAL>"=="	          {return (EQ);}
<INITIAL>"!="	          {return (NE);}

<INITIAL>{ident}	              {return (IDENT);}
<INITIAL>{number}	          {return (NUMBER);}

<INITIAL>"&&"	          {return (AND);}
<INITIAL>"||"	          {return (OR);}
<INITIAL>"!"	          {return (NOT);}
<INITIAL>"="	          {return (ASSIGN);}
<INITIAL>"+"	          {return (PLUS);}
<INITIAL>"-"	          {return (MINUS);}
<INITIAL>"*"	          {return (MULTI);}
<INITIAL>"/"	          {return (DIVIDE);}
<INITIAL>"%"            {return (MOD);}
<INITIAL>"."            {return (POINT);}
<INITIAL>";"	          {return (SEMICOLON);}
<INITIAL>","	          {return (COMMA);}

<INITIAL>"("	          {return (LPARENTHESIS);}
<INITIAL>")"	          {return (RPARENTHESIS);}
<INITIAL>"["	          {return (LBRACKET);}
<INITIAL>"]"	          {return (RBRACKET);}
<INITIAL>"{"	          {return (LBRACE);}
<INITIAL>"}"	          {return (RBRACE);}

<INITIAL>.				  {;}
%%

/* 该函数重置lex状态为初始状态 */
void resetLexState(){
  BEGIN INITIAL;
}
