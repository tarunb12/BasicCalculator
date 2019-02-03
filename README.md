# COP4020 Basic Calculator Antlr4 Implementaion #
Note: Only tested with JDK8, antlr 4.7.2, and JUNIT 4.12.
## File Input ##
```console
$ cd ./src/main/
$ antlr4 Grammar.g4
$ javac Grammar*.java
$ grun Grammar prog <filename> -<options>
```

## Terminal Input ##
```console
$ cd ./src/main
$ antlr4 Grammar.g4
$ javac Grammar*.java
$ grun Grammar prog -<options>
```

## Unit Testing ##
Before testing, the following commands should be run:
```console
$ cd ./src/main
$ antlr4 Grammar.g4
```
After the lexer/parser files are generated, then tests can be run by:
```console
$ cd ./src/test
$ javac Grammar*.java Test*.java
$ java TestRunner
```