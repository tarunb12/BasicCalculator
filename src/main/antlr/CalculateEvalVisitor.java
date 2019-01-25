import java.util.HashMap;
import java.util.Map;

public class CalculateEvalVisitor extends GrammarBaseVisitor<Double> {
    // "memory" for the calculator, variable/value pairs go here
    Map<String, Double> varDefs = new HashMap<String, Double>();

    // VAR EQ expr NL
    @Override
    public Double visitAssign(GrammarParser.AssignContext ctx) {
        String var = ctx.varDef().VAR().getText();
        double value = visit(ctx.varDef().expr());
        varDefs.put(var, value);
        return value;
    }

    @Override
    public Double visitVariable(GrammarParser.VariableContext ctx) {
        String var = ctx.VAR().getText();
        if (varDefs.containsKey(var)) {
            return varDefs.get(var);
        }
        return 0.0;
    }

    // NUM
    @Override
    public Double visitNumber(GrammarParser.NumberContext ctx) {
        return Double.valueOf(ctx.NUM().getText());
    }

    // expr NL
    @Override
    public Double visitPrintExpr(GrammarParser.PrintExprContext ctx) {
        Double value = visit(ctx.expr()); // evaluate the expr child
        System.out.println(value);         // print the result
        return 0.0;                          // return dummy value
    }

    // exp POW exp
    @Override
    public Double visitPower(GrammarParser.PowerContext ctx) {
        double left = visit(ctx.expr(0));
        double right = visit(ctx.expr(1));
        return Math.pow(left, right);
    }

    // expr MULT expr
    @Override
    public Double visitMultiply(GrammarParser.MultiplyContext ctx) {
        double left = visit(ctx.expr(0));
        double right = visit(ctx.expr(1));
        return left * right;
    }

    // expr DIV expr
    @Override
    public Double visitDivide(GrammarParser.DivideContext ctx) {
        double left = visit(ctx.expr(0));
        double right = visit(ctx.expr(1));
        return left / right;
    }

    // expr ADD expr
    @Override
    public Double visitAdd(GrammarParser.AddContext ctx) {
        double left = visit(ctx.expr(0));
        double right = visit(ctx.expr(1));
        return left + right;
    }

    // expr SUBT expr
    @Override
    public Double visitSubtract(GrammarParser.SubtractContext ctx) {
        double left = visit(ctx.expr(0));
        double right = visit(ctx.expr(1));
        return left - right;
    }

    // LPAR expr RPAR
    @Override
    public Double visitParenthesis(GrammarParser.ParenthesisContext ctx) {
        return visit(ctx.expr());
    }
}