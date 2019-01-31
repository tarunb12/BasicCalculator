import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import org.antlr.v4.runtime.CharStreams.*;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;

public class Calculate {
    public static void main(String[] args) throws Exception {
        String inputFile = null; // file name to read from
        if ( args.length > 0 ) inputFile = args[0]; // reads filename arg from command line
        InputStream is = System.in;
        if ( inputFile != null ) is = new FileInputStream(inputFile); // new input stream if valid filename

        // create a CharStream that reads from standard input
        CharStream input = CharStreams.fromStream(is);
        // create a lexer that feeds off of input CharStream
        GrammarLexer lexer = new GrammarLexer(input);
        // create a buffer of tokens pulled from the lexer
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        // create a parser that feeds off the tokens buffer
        GrammarParser parser = new GrammarParser(tokens);
        ParseTree tree = parser.prog(); // begin parsing at prog rule


        CalculateEvalVisitor eval = new CalculateEvalVisitor();
        eval.visit(tree);

        // System.out.println("Parse Tree:\n" + tree.toStringTree(parser));
        // System.out.println("File Text:\n" + tree.getText());
    }
}

/*
double prevResult = 0;

	public double toDouble(String num) {
		return Double.parseDouble(num);
	}

	public void assign(String var, String exp) {
		double value = prevResult;
		varDefs.put(var, value);
		System.out.println(value);
	}

	public void printVar(String var) {
		if(varDefs.containsKey(var)) {
			System.out.println(varDefs.get(var));
		}
	}

	public void printNum(String num) {
		double value = toDouble(num);
		System.out.println(value);
	}

	public void printExpr(String exp) {
		try {
			double expr = toDouble(exp);
			System.out.println(expr);
		}
		catch(NumberFormatException e) {
			System.out.print("");
		}
	}

  	public void power(String exp1, String exp2) {
		double left = toDouble(exp1);
		double right = toDouble(exp2);
		double result = Math.pow(left, right);
		System.out.println(result);
		prevResult = result;
	}

	public void sin(String exp) {
		double value = toDouble(exp);
		double result = Math.sin(value);
		System.out.println(result);
		prevResult = result;
	}

	public void cos(String exp) {
		double value = toDouble(exp);
		double result = Math.cos(value);
		System.out.println(result);
		prevResult = result;		
	}

	public void log(String exp) {
		double value = toDouble(exp);
		double result = Math.log10(value);
		System.out.println(result);
		prevResult = result;
	}

	public void exp(String exp) {
		double value = toDouble(exp);
		double result = Math.exp(value);
		System.out.println(result);
		prevResult = result;
	}

	public void sqrt(String exp) {
		double value = toDouble(exp);
		double result = Math.pow(value, 0.5);
		System.out.println(result);
		prevResult = result;
	}

	public void and(String exp1, String exp2) {
		double left = toDouble(exp1);
		double right = toDouble(exp2);
		double result = left != 0.0 && right != 0 ? 1.0 : 0.0;
		System.out.println(result);
		prevResult = result;
	}

	public void or(String exp1, String exp2) {
		double left = toDouble(exp1);
		double right = toDouble(exp2);
		double result = left != 0.0 || right != 0 ? 1.0 : 0.0;
		System.out.println(result);
		prevResult = result;
	}

	public void not(String exp) {
		double value = toDouble(exp);
		double result = value != 0.0 ? 1.0 : 0.0;
		System.out.println(result);
		prevResult = result;
	}

	public void mult(String exp1, String exp2) {
		double left = toDouble(exp1);
		double right = toDouble(exp2);
		double result = left * right;
		System.out.println(result);
		prevResult = result;
	}

	public void div(String exp1, String exp2) {
		double left = toDouble(exp1);
		double right = toDouble(exp2);
		double result = left / right;
		System.out.println(result);
		prevResult = result;
	}

	public void add(String exp1, String exp2) {
		double left = toDouble(exp1);
		double right = toDouble(exp2);
		double result = left + right;
		System.out.println(result);
		prevResult = result;
	}

	public void subt(String exp1, String exp2) {
		double left = toDouble(exp1);
		double right = toDouble(exp2);
		double result = left - right;
		System.out.println(result);
		prevResult = result;
	}
*/