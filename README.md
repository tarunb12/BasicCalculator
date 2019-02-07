# COP4020 Basic Calculator Antlr4 Implementaion #
*Note*: Only tested with JDK8, antlr 4.7.2, and JUNIT 4.12.
## To Compile Parser and Tests: ##
```console
$ cd src
$ antlr4 Grammar.g4
$ javac Grammar*.java Test*.java
```
## File Input ##
```console
$ grun Grammar prog <filename> -<options>
```
## Terminal Input ##
```console
$ grun Grammar prog -<options>
```

## Unit Testing ##
After the lexer/parser files are generated and java tests/grammar classes are compiled, then tests can be run by:
```console
$ java TestRunner
```
Note that these are my own tests that I have implemented in java. To test local files/input, use the grun Grammar command.