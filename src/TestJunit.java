import org.junit.Test;
import org.junit.Assert;
import static org.junit.Assert.assertEquals;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import org.antlr.v4.runtime.CharStreams.*;

public class TestJunit {

   private static final String NL = "\n";
   private static final String TAB = "    ";
   private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
   private final PrintStream originalOut = System.out;

   public void setOutStream() {
      System.setOut(new PrintStream(outContent));
   }

   public void resetOutStream() {
      System.setOut(originalOut);
   }

   public void antlrTest(String exp) throws Exception {
      // create a CharStream that reads from test input
      CharStream input = CharStreams.fromString(exp);
      // create a lexer that feeds off of given input
      GrammarLexer lexer = new GrammarLexer(input);
      // create a buffer of tokens pulled from the lexer
      CommonTokenStream tokens = new CommonTokenStream(lexer);
      GrammarParser parser = new GrammarParser(tokens);
      setOutStream();
      ParseTree tree = parser.prog(); // begin parsing at prog rule
   }

   @Test
   public void testAddSubMultDiv() {
      System.out.println(NL + "Addition, Subtraction, Multiplicationm and Division Tests:");
      String exp1 = "2+3*8-7/7";
      String exp1Result = "25.0";
      try {
         antlrTest(exp1);
         String testExp1 = outContent.toString();
         resetOutStream();
         Assert.assertEquals(exp1Result + NL, testExp1);
         System.out.println(TAB + exp1.trim() + "=" + exp1Result + " - passed \u2713");
      }
      catch (Exception e) {
         Assert.fail(TAB + exp1.trim() + "=" + exp1Result + " - failed \u2717");
      }
      System.out.print(NL);
   }
}