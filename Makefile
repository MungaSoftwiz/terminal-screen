# Makefile for Terminal Screen App

PROGRAM = terminal_screen_app

# Dune build and Execution Command
DUNE = dune
EXEC_CMD = exec $(PROGRAM)

# Targets
.PHONY: all build test run format lint install clean

# Default target: build, test, and run the program
all: build test run

# Build the project
build:
	$(DUNE) build

# Run the program
run:
	$(DUNE) $(EXEC_CMD)

# Run tests
test:
	$(DUNE) runtest

# Format check
format:
	$(DUNE) build @fmt --auto-promote

# Lint the code
lint:
	ocamlformat --check --enable-outside-detected-project **/*.ml **/*.mli

# Clean the build files
clean:
	$(DUNE) clean
