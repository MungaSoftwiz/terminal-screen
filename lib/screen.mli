(** Represents the colour mode of the screen. *)
type colour_mode =
  | Monochrome  (** Monochrome display mode. *)
  | SixteenColours  (** 16 colours display mode. *)
  | TwoHundredAndFiftySixColours  (** 256 colours display mode. *)

type colour = { r : int; g : int; b : int }
(** Represents an RGB colour. *)

type screen_state = {
  width : int;  (** The width of the screen in characters. *)
  height : int;  (** The height of the screen in characters. *)
  colour_mode : colour_mode;  (** The colour mode of the screen. *)
  is_initialized : bool;
      (** Indicates whether the screen has been initialized. *)
  palette : colour array;
}
(** Represents the state of the screen. *)

val setup_screen : int array -> unit
(** 
  Initializes the screen with the given dimensions.
  @param dimensions An array where the first element is the width and the second element is the height of the screen.
*)

val is_ready : unit -> bool
(** 
  Checks if the screen is ready for use.
  @return true if the screen is initialized and ready, false otherwise.
*)

val get_screen_state : unit -> screen_state
(** 
  Retrieves the current state of the screen.
  @return The current state of the screen as a [screen_state] record.
*)

val get_screen_buffer : unit -> (char * int) array array
(** 
  Retrieves the current screen buffer.
  @return A 2D array of characters representing the current screen buffer.
*)

val display_character : char -> int -> unit
(** 
  Displays a character on the screen at the current cursor position with the specified colour.
  @param character The character to display.
  @param colour_index The index of the colour in the palette to use for the character.
*)
