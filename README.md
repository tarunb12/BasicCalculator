# COP4020 Basic Calculator Antlr4 Implementaion #
*Note*: Only tested with JDK8, antlr 4.7.2, and JUNIT 4.12.
## To Compile Calc Parser: ##
```console
$ cd src
$ antlr4 Grammar.g4
$ javac Grammar*.java
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
Note: Java testing works after antlr files compiled
```console
$ cd src
$ javac Test*.java
$ java TestRunner
```
Note that these are my own tests that I have implemented in java. To test local files/input, use the grun Grammar command.