val draw_line : int array -> unit
(** [draw_line data] draws a line on the terminal screen.
    [data] is an array of bytes where:
    - [data.(0)] is the x-coordinate of the starting point.
    - [data.(1)] is the y-coordinate of the starting point.
    - [data.(2)] is the x-coordinate of the ending point.
    - [data.(3)] is the y-coordinate of the ending point.
    - [data.(4)] is the colour index (currently unused).
    - [data.(5)] is the ASCII value of the character to draw the line with.

    Raises [Failure] if:
    - The screen is not initialized.
    - [data] has an invalid length.
    - The coordinates are out of bounds.
*)
