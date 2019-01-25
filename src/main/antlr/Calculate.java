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