# Snake Make 🐍 

## Description
A simple python build structure with accompanying makefiles. Allows users to build easily add and install packages.

## To use
To install all packages in the pkgs directory and compile top level into a binary run:

```
make all
```

To install the compiled binary run:
```
sudo make install
```

## Example Directory Structure

.
├── pkgs
│   ├── bar
│   │   ├── bar
│   │   │   ├── bar.py
│   │   │   └── __init__.py
│   │   ├── makefile
│   │   ├── README.md
│   │   └── setup.py
│   └── foo
│       ├── foo
│       │   ├── foo.py
│       │   └── __init__.py
│       ├── makefile
│       ├── README.md
│       └── setup.py
├── smake
│   ├── doxyfile
│   ├── LICENSE
│   ├── makefile
│   └── README.md
└── top
    └── main.py


## Doxygen Documentation
[documentation](https://samueldonovan.github.io/pithon/)
