grammar Grammar;

@header {
	import java.util.HashMap;
	import java.util.Map;
}

@members {
    Map<String, Double> varDefs = new HashMap<String, Double>();

	public double toDouble(String num) {
		return Double.parseDouble(num);
	}

	public void assign(String var, String exp) {
		System.out.println(exp);
		double value = toDouble(exp);
		varDefs.put(var, value);
		System.out.println(value);
	}

	public void printVar(String var) {
		if(varDefs.containsKey(var)) {
			System.out.println(varDefs.get(var));
		}
	}

	public void printExpr(String exp) {
		System.out.println(exp);
	}

  	public void power(String exp1, String exp2) {
		double left = toDouble(exp1);
		double right = toDouble(exp2);
		System.out.println(Math.pow(left, right));
	}

	public void sin(String exp) {
		double value = toDouble(exp);
		System.out.println(Math.sin(value));
	}

	public void cos(String exp) {
		double value = toDouble(exp);
		System.out.println(Math.cos(value));
	}

	public void log(String exp) {
		double value = toDouble(exp);
		System.out.println(Math.log10(value));
	}

	public void exp(String exp) {
		double value = toDouble(exp);
		System.out.println(Math.exp(value));
	}

	public void sqrt(String exp) {
		double value = toDouble(exp);
		System.out.println(Math.pow(value, 0.5));
	}

	public void and(String exp1, String exp2) {
		double left = toDouble(exp1);
		double right = toDouble(exp2);
		System.out.println(left != 0.0 && right != 0 ? 1.0 : 0.0);
	}

	public void or(String exp1, String exp2) {
		double left = toDouble(exp1);
		double right = toDouble(exp2);
		System.out.println(left != 0.0 || right != 0 ? 1.0 : 0.0);
	}

	public void not(String exp) {
		double value = toDouble(exp);
		System.out.println(value != 0.0 ? 1.0 : 0.0);
	}

	public void mult(String exp1, String exp2) {
		double left = toDouble(exp1);
		double right = toDouble(exp2);
		System.out.println(left * right);
	}

	public void div(String exp1, String exp2) {
		double left = toDouble(exp1);
		double right = toDouble(exp2);
		System.out.println(left / right);
	}

	public void add(String exp1, String exp2) {
		double left = toDouble(exp1);
		double right = toDouble(exp2);
		System.out.println(left + right);
	}

	public void subt(String exp1, String exp2) {
		double left = toDouble(exp1);
		double right = toDouble(exp2);
		System.out.println(left - right);
	}
}

NUM     : '-'?([0-9]+)|([0-9]*'.'[0-9]+) ;  // -?((INT) | (FLOAT))
VAR     : [_a-zA-Z]+[_a-zA-Z0-9]* ;     // (_alphabet)+(_alphanumeric)*

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

prog: stat* ;

stat: exp=expr NL?		{ this.printExpr($expr.text); }
    | varDef NL?
    | comment NL?   //# Comm
    | NL            //# NewLine
    ;

varDef  : var=VAR EQ exp=expr 			{ this.assign($var.text, $exp.text); } ;

comment : '/*' (.)*? '*/' ;

sinFunc : 's' LPAR exp=expr RPAR 		{ this.sin($exp.text); } ;
cosFunc : 'c' LPAR exp=expr RPAR 		{ this.cos($exp.text); } ;
logFunc : 'l' LPAR exp=expr RPAR 		{ this.log($exp.text); } ;
expFunc : 'e' LPAR exp=expr RPAR 		{ this.exp($exp.text); } ;
sqrtFunc: 'sqrt' LPAR exp=expr RPAR 	{ this.sqrt($exp.text); } ;

function: expFunc
        | logFunc
        | sqrtFunc
        | sinFunc
        | cosFunc
        ;

expr
    : exp1=expr POW exp2=expr			{ this.power($exp1.text, $exp2.text); }
    | function                  
    | exp1=expr AND exp2=expr			{ this.and($exp1.text, $exp2.text); }
    | exp1=expr OR exp2=expr			{ this.or($exp1.text, $exp2.text); }
    | NOT exp=expr              		{ this.not($exp.text); }
    | exp1=expr MULT exp2=expr  		{ this.mult($exp1.text, $exp2.text); }
    | exp1=expr DIV exp2=expr  			{ this.div($exp1.text, $exp2.text); }
    | exp1=expr ADD exp2=expr  			{ this.add($exp1.text, $exp2.text); }
    | exp1=expr SUBT exp2=expr 			{ this.subt($exp1.text, $exp2.text); }
    | LPAR exp=expr RPAR            
	| NUM                     	  
    | var=VAR                     	  	{ this.printVar($var.text); }
    ;