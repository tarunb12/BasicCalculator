grammar Grammar;

NUM     : '-'?([0-9]+)|([0-9]*'.'[0-9]+) ;  // -?((INT) | (FLOAT))
VAR     : [_a-zA-Z]+[_a-zA-Z0-9]* ;     // (_alphabet)+(_alphanumeric)*

// SIN : 's' ;
// COS : 'c' ;
// LOG : 'l' ;
// EXP : 'e' ;
POW : '^' ;
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

sqrtExpr: 'sqrt' LPAR expr RPAR ;

expr
    : expr POW expr         # Power
    | sqrtExpr              # SquareRoot
    | expr MULT expr        # Multiply
    | expr DIV expr         # Divide
    | expr ADD expr         # Add
    | expr SUBT expr        # Subtract
    | NUM                   # Number
    | VAR                   # Variable
    | LPAR expr RPAR        # Parenthesis
    ;

    // | SIN '(' expr ')'      # Sine
    // | COS '(' expr ')'      # Cosine
    // | LOG '(' expr ')'      # Logarithm
    // | EXP '(' expr ')'      # Exponential
