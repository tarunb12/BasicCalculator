grammar Grammar1;

@header {
	import java.util.HashMap;
	import java.util.Map;
	import java.util.Stack;
	import java.lang.NumberFormatException;
}

@members {
    Map<String, Double> varDefs = new HashMap<String, Double>();
}

NUM     : ([0-9]+)|([0-9]*'.'[0-9]+) ;  // -?((INT) | (FLOAT))
VAR     : [_a-zA-Z]+[_a-zA-Z0-9]* ;     	// (_alphabet)+(_alphanumeric)*

POW : '^' ;
MULT: '*' ;
DIV : '/' ;
ADD : '+' ;
SUBT: '-' ;
LPAR: '(' ;
RPAR: ')' ;
EQ  : '=' ;

NOT : '!' ;
AND : '&&' ;
OR  : '||' ;

LCOM: '/*' ;
RCOM: '*/' ;
NL  : '\r'? '\n';
WS  : [ \t]+ -> skip;

prog
	: stat ( ';' stat )* ';'?
	;

stat
	: expr { System.out.println($expr.result); }
    // | varDef
    // | comment
    // | NL
    ;

varDef
	: var=VAR EQ exp=expr
	;

comment
	: '/*' (.)*? '*/'
	;

// sinFunc : 's' LPAR exp=expr RPAR	{ $result = Math.sin($exp.result); } ;
// cosFunc : 'c' LPAR exp=expr RPAR	{ $result = Math.cos($exp.result); } ;
// logFunc : 'l' LPAR exp=expr RPAR	{ $result = Math.log10($exp.result); } ;
// expFunc : 'e' LPAR exp=expr RPAR { $result = Math.exp($exp.result); } ;
// sqrtFunc: 'sqrt' LPAR exp=expr RPAR { $result = Math.sqrt($exp.result); } ;

// function: expFunc
//         | logFunc
//         | sqrtFunc
//         | sinFunc
//         | cosFunc
//         ;

expr returns [double result]
    : left=expr POW right=expr	{ $result = Math.pow($left.result, $right.result); }
    // | function
    | left=expr op=AND right=expr	{ $result = $left.result != 0.0 && $right.result != 0 ? 1.0 : 0.0; }
    | left=expr op=OR right=expr	{ $result = $left.result != 0.0 || $right.result != 0 ? 1.0 : 0.0; }
    | NOT exp=expr					{ $result = $exp.result != 0.0 ? 1.0 : 0.0; }
    | left=expr op=MULT right=expr	{ $result = $left.result * $right.result; }
    | left=expr op=DIV right=expr	{ $result = $left.result / $right.result; }
    | left=expr op=ADD right=expr	{ $result = $left.result + $right.result; }
    | left=expr op=SUBT right=expr	{ $result = $left.result - $right.result; }
	| num=NUM					{ $result = Double.parseDouble($num.text); }
    // | var=VAR					{ $result = varDefs.containstKey($var.text) ? varDefs.get($var.text) : 0.0; }
	| LPAR exp=expr RPAR
    ;