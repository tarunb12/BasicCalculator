grammar Grammar;

NUM     : ([0-9]+)|([0-9]*'.'[0-9]+) ;  // (INT) | (FLOAT)
VAR     : [_a-zA-Z]+[_a-zA-Z0-9]* ;

// SIN : 's' ;
// COS : 'c' ;
// LOG : 'l' ;
// EXP : 'e' ;
// SQRT: 'sqrt' ;
// POW : '^' ;
MULT: '*' ;
DIV : '/' ;
ADD : '+' ;
SUBT: '-' ;
LPAR: '(' ;
RPAR: ')' ;
EQ  : '=' ;

LCOM: '/*' ;
RCOM: '*/' ;
NL  : '\n';
WS  : [ \t]+ -> skip;

prog: stat* ;

stat: expr NL?      # PrintExpr
    | varDef NL?    # Assign
    // | LCOM RCOM     # Comment
    | NL            # NewLine
    ;

varDef  : VAR EQ expr ;

expr
    : expr MULT expr        # Multiply
    | expr DIV expr         # Divide
    | expr ADD expr         # Add
    | expr SUBT expr        # Subtract
    | NUM                 # Number
    | VAR                   # Variable
    | LPAR expr RPAR        # Parenthesis
    ;

    // | expr op=POW expr      # Power
    // | SIN '(' expr ')'      # Sine
    // | COS '(' expr ')'      # Cosine
    // | LOG '(' expr ')'      # Logarithm
    // | EXP '(' expr ')'      # Exponential
    // | SQRT '(' expr ')'     # SquareRoot
