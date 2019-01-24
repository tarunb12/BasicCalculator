grammar Grammar;

// INT     : [0-9]+ ;
// FLOAT   : [0-9]*'.'[0-9]+ ;
// VAR     : [_a-zA-Z][_a-zA-Z0-9]* ;

// SIN : 's' ;
// COS : 'c' ;
// LOG : 'l' ;
// EXP : 'e' ;
// POW : '^' ;
// MULT: '*' ;
// DIV : '/' ;
// ADD : '+' ;
// SUBT: '-' ;
// LPAR: '(' ;
// RPAR: ')' ;
// EQ  : '=' ;

// NL  : '\n';
// WS  : [ \t]+ -> skip;

// varDef  : VAR EQ expr ;

// expr
//     : func=SIN LPAR rad=expr RPAR
//     | func=COS LPAR rad=expr RPAR
//     | func=LOG LPAR num=expr RPAR
//     | func=EXP LPAR num=expr RPAR
//     | left=expr op=MULT right=expr
//     | left=expr op=DIV right=expr
//     | left=expr op=ADD right=expr
//     | left=expr op=SUBT right=expr
//     | INT
//     | VAR
//     | LPAR expr RPAR
//     ;

prog    : stat+ ;

stat: expr NL
    | ID '=' expr NL
    | NL
    ;

expr: expr ('*'|'/') expr
    | expr ('+'|'-') expr
    | INT
    | ID
    | '(' expr ')'
    ;

ID  : [a-zA-Z]+ ;
INT : [0-9]+ ;
NL  : '\r'? '\n' ;
WS  : [ \t]+ -> skip ;