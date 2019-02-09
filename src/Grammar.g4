grammar Grammar ;

@header {
	import java.util.HashMap;
	import java.util.Map;

    import java.io.ByteArrayOutputStream;
    import java.io.PrintStream;

    import org.antlr.v4.runtime.tree.*;
    import org.antlr.v4.runtime.CharStreams.*;
}

@members {
    Map<String, Double> varDefs = new HashMap<String, Double>();

    public final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    public final PrintStream originalOut = System.out;

    public void evaluate(String exp) {
        CharStream input = CharStreams.fromString(exp);
        // create a lexer that feeds off of given input
        GrammarLexer lexer = new GrammarLexer(input);
        // create a buffer of tokens pulled from the lexer
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        GrammarParser parser = new GrammarParser(tokens);
        ParseTree tree = parser.prog(); // begin parsing at prog rule
    }
    public void setOutStream() {
        System.setOut(new PrintStream(outContent));
    }

    public void resetOutStream() {
        outContent.reset();
        System.setOut(originalOut);
    }

    public double readInExpr(String readExpr, String expr) {
        setOutStream();
        evaluate(readExpr.replace("read()", expr));
        double result = Double.parseDouble(outContent.toString().replace("\n", "").replace("\r", ""));
        resetOutStream(); 
        return result;
    }
}

prog: NL*? stat ( NL stat )* NL*? ;

stat
    : expression
    | varDef
    | comment
    | printStatement
    ;

expression
    : expr                                  { System.out.println($expr.result); }
    | readExpr NL expr                      { if ($readExpr.text.contains("read()")) { System.out.println(readInExpr($readExpr.text, $expr.text)); } else { System.out.println($readExpr.result); System.out.println($expr.result); } }
    | readExpr                              { System.out.println($readExpr.result); }
    ;

varDef
    : VAR EQ expr                           { varDefs.put($VAR.text, $expr.result); }
    | VAR EQ readExpr NL expr               { if ($readExpr.text.contains("read()")) { varDefs.put($VAR.text, readInExpr($readExpr.text, $expr.text)); } }
    | VAR EQ readExpr                       { varDefs.put($VAR.text, $readExpr.result); }
	;

comment
    : LCOM txt RCOM
    ;

printStatement
    : print statement[true]
    ;

statement[boolean first] returns [String output]
    : quote txt { $output = $txt.text; if ($first) System.out.print($txt.text); else System.out.print(", " + $txt.text); } quote (',' stm=statement[false])* 
    | expr { $output = Double.toString($expr.result); if ($first) System.out.print(Double.toString($expr.result)); else System.out.print(", " + Double.toString($expr.result)); } (',' stm=statement[false])*
    | readExpr { $output = Double.toString($readExpr.result); if ($first) System.out.print(Double.toString($readExpr.result)); else System.out.print(", " + Double.toString($readExpr.result)); } (',' stm=statement[false])*
    ;

num 
    : INT
    | DOUBLE
    ;

expr returns [double result]
    : SUBT expr                             { $result = -1 * $expr.result; }
    | exp LPAR expr RPAR                    { $result = Math.exp($expr.result); }
    | log LPAR expr RPAR                    { $result = Math.log10($expr.result); }
    | sin LPAR expr RPAR                    { $result = Math.sin($expr.result); }
    | cos LPAR expr RPAR                    { $result = Math.cos($expr.result); }
    | left=expr POW right=expr	            { $result = Math.pow($left.result, $right.result); }
    | sqrt LPAR expr RPAR                   { $result = Math.sqrt($expr.result); }
    | NOT expr					            { $result = $expr.result == 0.0 ? 1.0 : 0.0; }
    | left=expr AND right=expr	            { $result = $left.result != 0.0 && $right.result != 0 ? 1.0 : 0.0; }
    | left=expr OR right=expr	            { $result = $left.result != 0.0 || $right.result != 0 ? 1.0 : 0.0; }
    | left=expr MULT right=expr	            { $result = $left.result * $right.result; }
    | left=expr DIV right=expr	            { $result = $left.result / $right.result; }
    | left=expr SUBT right=expr	            { $result = $left.result - $right.result; }
    | left=expr ADD right=expr	            { $result = $left.result + $right.result; }
	| num				                    { $result = Double.parseDouble($num.text); }
    | VAR					                { $result = varDefs.containsKey($VAR.text) ? varDefs.get($VAR.text) : 0.0; }
    | LPAR expr RPAR                        { $result = $expr.result; }
    ;

readExpr returns [double result]
    : SUBT readExpr                         { $result = -1 * $readExpr.result; }
    | exp LPAR readExpr RPAR                { $result = Math.exp($readExpr.result); }
    | log LPAR readExpr RPAR                { $result = Math.log10($readExpr.result); }
    | sin LPAR readExpr RPAR                { $result = Math.sin($readExpr.result); }
    | cos LPAR readExpr RPAR                { $result = Math.cos($readExpr.result); }
    | left=readExpr POW right=readExpr	    { $result = Math.pow($left.result, $right.result); }
    | sqrt LPAR readExpr RPAR               { $result = Math.sqrt($readExpr.result); }
    | NOT readExpr					        { $result = $readExpr.result == 0.0 ? 1.0 : 0.0; }
    | left=readExpr AND right=readExpr	    { $result = $left.result != 0.0 && $right.result != 0 ? 1.0 : 0.0; }
    | left=readExpr OR right=readExpr	    { $result = $left.result != 0.0 || $right.result != 0 ? 1.0 : 0.0; }
    | left=readExpr MULT right=readExpr	    { $result = $left.result * $right.result; }
    | left=readExpr DIV right=readExpr	    { $result = $left.result / $right.result; }
    | left=readExpr SUBT right=readExpr	    { $result = $left.result - $right.result; }
    | left=readExpr ADD right=readExpr	    { $result = $left.result + $right.result; }
	| num				                    { $result = Double.parseDouble($num.text); }
    | VAR					                { $result = varDefs.containsKey($VAR.text) ? varDefs.get($VAR.text) : 0.0; }
    | read LPAR RPAR                        { $result = 0.0; }
    | LPAR readExpr RPAR                    { $result = $readExpr.result; }
    ;

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
read: 'read' ;
exp : 'e' ;
log : 'l' ;
sqrt: 'sqrt' ;
sin : 's' ;
cos : 'c' ;

print: 'print' ;
quote: '"' ;
txt  : (.)*? ;

NOT : '!' ;
AND : '&&' ;
OR  : '||' ;

LCOM: '/*' ;
RCOM: '*/' ;
NL  : '\r'? '\n' ;
BS  : [\\]      { setText("\\"); } ;
BSNL: [\\]'n'   { setText("\n"); } ;
BSTB: [\\]'t'   { setText("\t"); } ;
WS  : [ \t]+ -> skip ;