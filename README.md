# COP4020 Basic Calculator Antlr4 Implementaion #
## File Input ##
~~~~
$ cd ./src/main/
$ antlr4 Grammar.g4
$ javac Grammar*.java
$ grun Grammar prog <filename> -<options>
~~~~

## Terminal Input ##
~~~~
$ cd ./src/main
$ antlr4 Grammar.g4
$ javac Grammar*.java
$ grun Grammar prog -<options>
~~~~

## Unit Testing ##
Before testing, the following commands should be run:
~~~~
$ cd ./src/main
$ antlr4 Grammar.g4
~~~~
After the lexer/parser files are generated, then tests can be run by:
~~~~
$ cd ./src/test
$ javac Grammar*.java Test*.java
$ java TestRunner
~~~~