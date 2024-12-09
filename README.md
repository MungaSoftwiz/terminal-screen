# terminal-screen (A Terminal Screen Renderer)

This project implements a terminal screen renderer using OCaml. It parses a stream of binary-encoded commands and renders graphical instructions in a terminal. This is achieved by interpreting the commands to setup a virtual screen, draw characters, lines, and text, manipulate the cursor, and clear the screen.

---
### Below are the links to the proposal  and corresponding UML Diagrams:

## Project's proposal

Below is the project's proposal in PDF format.

[Project Proposal (PDF)](./docs/Terminal-Screen-Initial-Proposal.pdf)

## Use Case Diagram

Below is the use case diagram in PDF format:

[Use Case Diagram (PDF)](./docs/Terminal-Screen-Use-Case-Diagram.pdf)

## Sequence Diagram

Below is the sequence diagram in PDF format:

[Sequence Diagram (PDF)](./docs/Terminal-Screen-Sequence-Diagram.pdf)

## Flowchart Diagram

Below is a flowchart diagram in PDF format:

[Flowchart Diagram (PDF)](./docs/Terminal-Screen-Flowchart-Diagram.pdf)

## MVP: Making Progress

This section outlines the progress of the project as of 9/12/2024. Below is the document in PDF format:

[MVP: Making Progress (PDF)](./docs/Terminal-Screen-MVP-Progress.pdf)

---

## Features
- **Screen Setup**: Initialise a virtual terminal screen with customisable dimensions and colour modes.
- **Draw Characters**: Place individual characters at specific coordinates.
- **Draw Lines**: Render straight lines between two points with specified characters and colours.
- **Render Text**: Display strings of text starting at a given position.
- **Cursor Movement**: Move the cursor without rendering.
- **Screen Clearing**: Reset the screen content.
- **EOF Handling**: Terminate rendering upon receiving an end-of-file command.

---

## Binary Command Format
The program processes a binary input with the following structure:

| **Command Byte** | **Length Byte** | **Data Bytes**            |
|-------------------|-----------------|---------------------------|
| 1 byte            | 1 byte         | Depends on the command    |

### Command Specifications
| **Command** | **Code** | **Description**                                     | **Data Format**                                              |
|-------------|----------|-----------------------------------------------------|--------------------------------------------------------------|
| Setup Screen | `0x1`   | Initialise screen dimensions and colour mode.        | `Byte 0`: Width, `Byte 1`: Height, `Byte 2`: Colour Mode      |
| Draw Character | `0x2` | Draw a character at specific coordinates.           | `Byte 0`: x, `Byte 1`: y, `Byte 2`: Colour, `Byte 3`: ASCII   |
| Draw Line    | `0x3`   | Draw a line between two coordinates.                | `Byte 0-4`: Coordinates, `Byte 5`: Color, `Byte 6`: ASCII    |
| Render Text  | `0x4`   | Display text starting at a given position.          | `Byte 0-2`: Position & Colour, `Byte 3-n`: ASCII text         |
| Cursor Move  | `0x5`   | Move cursor to a specific position.                 | `Byte 0`: x, `Byte 1`: y                                     |
| Draw at Cursor | `0x6` | Draw at the current cursor position.                | `Byte 0`: ASCII, `Byte 1`: Colour                             |
| Clear Screen | `0x7`   | Reset the screen.                                   | No data                                                      |
| End of File  | `0xFF`  | End of the binary stream.                           | No data                                                      |

---

## Project Structure

```
terminal-screen/
├── README.md
├── bin/
|   ├── main.ml
├── lib/
│   ├── *.ml
│   ├── *.mli
├── test/
│   ├── test_module.ml
├── .gitignore
├── .ocamlformat
├── dune-project
├── library.opam
├── AUTHORS
└── Makefile
```

---

## Getting Started

### Prerequisites

### Installation
1. Clone the repository:
```bash
git clone https://github.com/yourusername/terminal_screen.git
cd terminal_screen
```

2. Install dependencies:
```bash
sudo apt get opam
opam install . --deps-only -y
```

3. Activate the environment:
```bash
eval $(opam env)
```

### Build the Program
- To build the program in an executable:

```bash
opam exec -- dune build
```
### Running the Program
- To execute the program:

```bash
dune exec terminal_screen_app
```

### Running Tests
Execute all unit tests:

```bash
opam exec -- dune runtest
```

## Authors
Boniface Munga - [Github](https://github.com/MungaSoftwiz) / [X](https://X.com/MungaSoftwiz)