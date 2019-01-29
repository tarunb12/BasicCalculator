import java.util.HashMap;
import java.util.Map;

public class CalculateEvalVisitor extends GrammarBaseVisitor<Double> {
    // "memory" for the calculator, variable/value pairs go here
    Map<String, Double> varDefs = new HashMap<String, Double>();

    // VAR EQ expr NL? [VAR = expr \n?]
    @Override
    public Double visitAssign(GrammarParser.AssignContext ctx) {
        String var = ctx.varDef().VAR().getText();
        double value = visit(ctx.varDef().expr());
        varDefs.put(var, value);
        System.out.println(value);
        return value;
    }

    // expr NL
    @Override
    public Double visitPrintExpr(GrammarParser.PrintExprContext ctx) {
        Double value = visit(ctx.expr());   // evaluate the expr child
        System.out.println(value);          // print the result
        return 0.0;                         // return dummy value
    }

    // VAR
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

    // expr POW expr [expr ^ expr]
    @Override
    public Double visitPower(GrammarParser.PowerContext ctx) {
        double left = visit(ctx.expr(0));
        double right = visit(ctx.expr(1));
        return Math.pow(left, right);
    }

    // e(expr)
    @Override
    public Double visitExpFunc(GrammarParser.ExpFuncContext ctx) {
        double value = visit(ctx.expr());
        return Math.exp(value);
    }

    // l(expr)
    @Override
    public Double visitLogFunc(GrammarParser.LogFuncContext ctx) {
        double value = visit(ctx.expr());
        return Math.log10(value);
    }

    // sqrt(expr)
    @Override
    public Double visitSqrtFunc(GrammarParser.SqrtFuncContext ctx) {
        double value = visit(ctx.expr());
        return Math.pow(value, 0.5);
    }

    // s(expr)
    @Override
    public Double visitSinFunc(GrammarParser.SinFuncContext ctx) {
        double value = visit(ctx.expr());
        return Math.sin(value);
    }

    // c(expr)
    @Override
    public Double visitCosFunc(GrammarParser.CosFuncContext ctx) {
        double value = visit(ctx.expr());
        return Math.cos(value);
    }

    // (expr && expr)
    @Override
    public Double visitAnd(GrammarParser.AndContext ctx) {
        double left = visit(ctx.expr(0));
        double right = visit(ctx.expr(1));
        if (left != 0.0 && right != 0) return 1.0;
        return 0.0;
    }

    // (expr || expr)
    @Override
    public Double visitOr(GrammarParser.OrContext ctx) {
        double left = visit(ctx.expr(0));
        double right = visit(ctx.expr(1));
        if (left != 0.0 || right != 0) return 1.0;
        return 0.0;
    }


    // !expr
    @Override
    public Double visitNot(GrammarParser.NotContext ctx) {
        double value = visit(ctx.expr());
        if (value != 0.0) return 1.0;
        return 0.0;
    }

    // expr MULT expr [expr * expr]
    @Override
    public Double visitMultiply(GrammarParser.MultiplyContext ctx) {
        double left = visit(ctx.expr(0));
        double right = visit(ctx.expr(1));
        return left * right;
    }

    // expr DIV expr [expr / expr]
    @Override
    public Double visitDivide(GrammarParser.DivideContext ctx) {
        double left = visit(ctx.expr(0));
        double right = visit(ctx.expr(1));
        return left / right;
    }

    // expr ADD expr [expr + expr]
    @Override
    public Double visitAdd(GrammarParser.AddContext ctx) {
        double left = visit(ctx.expr(0));
        double right = visit(ctx.expr(1));
        return left + right;
    }

    // expr SUBT expr [expr - expr]
    @Override
    public Double visitSubtract(GrammarParser.SubtractContext ctx) {
        double left = visit(ctx.expr(0));
        double right = visit(ctx.expr(1));
        return left - right;
    }

    // LPAR expr RPAR [(expr)]
    @Override
    public Double visitParenthesis(GrammarParser.ParenthesisContext ctx) {
        return visit(ctx.expr());
    }
}