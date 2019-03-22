
## 6. Modules

A module is a file containing Python definitions and statements.
Python has a way to put definitions in a file and use them in a script or in an interactive instance of the interpreter.
Such a file is called a module; definitions from a module can be imported into other modules or into the main module .

## 6.1. More on Modules

A module can contain executable statements as well as function definitions. 
These statements are intended to initialize the module. 
They are executed only the first time the module name is encountered in an import statement

### 6.1.1. Executing modules as scripts

~~~
if __name__ == "__main__":
    import sys
    fib(int(sys.argv[1]))
~~~

### 6.1.2. The Module Search Path

- the directory containing the input script (or the current directory).
- PYTHONPATH (a list of directory names, with the same syntax as the shell variable PATH).
- the installation-dependent default.
