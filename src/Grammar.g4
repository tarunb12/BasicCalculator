grammar Grammar ;

@header {
	import java.util.HashMap;
	import java.util.Map;
}

@members {
    Map<String, Double> varDefs = new HashMap<String, Double>();
    boolean readMode = false;
}


INT     : [0-9]+ ;
DOUBLE  : [0-9]*'.'[0-9]+;

VAR     : [_a-zA-Z]+[_a-zA-Z0-9]* ;

POW : '^' ;
MULT: '*' ;
DIV : '/' ;
ADD : '+' ;
SUBT: '-' ;
LPAR: '(' ;
RPAR: ')' ;
EQ  : '=' ;
read: 'read';
exp : 'e' ;
log : 'l' ;
sqrt: 'sqrt' ;
sin : 's' ;
cos : 'c' ;

NOT : '!' ;
AND : '&&' ;
OR  : '||' ;

LCOM: '/*' ;
RCOM: '*/' ;
NL  : '\r'? '\n' ;
WS  : [ \t]+ -> skip ;

prog: NL*? stat ( NL stat )* NL*? ;

stat: expr                      { if (!readMode) { System.out.println($expr.result); } else { varDefs.put("read()", $expr.result); readMode = false; } }
    | varDef
    | comment
    ;

varDef
	: var=VAR EQ expr           { varDefs.put($var.text, $expr.result); }
	;

comment
    : '/*' (.)*? '*/'
    ;

num 
    : INT
    | DOUBLE
    ;

expr returns [double result]
    : exp LPAR expr RPAR        { $result = Math.exp($expr.result); }
    | log LPAR expr RPAR        { $result = Math.log10($expr.result); }
    | sqrt LPAR expr RPAR       { $result = Math.sqrt($expr.result); }
    | sin LPAR expr RPAR        { $result = Math.sin($expr.result); }
    | cos LPAR expr RPAR        { $result = Math.cos($expr.result); }
    | left=expr POW right=expr	{ $result = Math.pow($left.result, $right.result); }
    | left=expr AND right=expr	{ $result = $left.result != 0.0 && $right.result != 0 ? 1.0 : 0.0; }
    | left=expr OR right=expr	{ $result = $left.result != 0.0 || $right.result != 0 ? 1.0 : 0.0; }
    | NOT expr					{ $result = $expr.result != 0.0 ? 1.0 : 0.0; }
    | left=expr MULT right=expr	{ $result = $left.result * $right.result; }
    | left=expr DIV right=expr	{ $result = $left.result / $right.result; }
    | left=expr ADD right=expr	{ $result = $left.result + $right.result; }
    | left=expr SUBT right=expr	{ $result = $left.result - $right.result; }
    | SUBT expr                 { $result = -1 * $expr.result; }
	| num				        { $result = Double.parseDouble($num.text); }
    | var=VAR					{ $result = (varDefs.containsKey($var.text) ? varDefs.get($var.text) : 0); }
    | read LPAR RPAR            { $result = 0.0; readMode = true; varDefs.put("read()", 0.0); }
	| LPAR expr RPAR            { $result = $expr.result; }
    ;

