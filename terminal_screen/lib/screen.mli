type colour_mode = Monochrome | SixteenColours | TwoHundredAndFiftySixColours

type screen_state = {
  width : int;
  height : int;
  colour_mode : colour_mode;
  is_initialized : bool;
}

val setup_screen : int array -> unit
val is_ready : unit -> bool
val get_screen_state : unit -> screen_state
