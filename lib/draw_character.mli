val draw_character : int array -> unit
(** [draw_character data] draws a character on the terminal screen.
    @param data an array of bytes where:
    - [data.(0)] is the x-coordinate.
    - [data.(1)] is the y-coordinate.
    - [data.(2)] is the colour index (currently unused).
    - [data.(3)] is the ASCII value of the character to draw.

    @raise Failure if:
    - The screen is not initialized.
    - [data] has an invalid length.
    - The coordinates are out of bounds.
*)
