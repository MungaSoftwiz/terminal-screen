type colour_mode = Monochrome | SixteenColours | TwoHundredAndFiftySixColours

type screen_state = {
  width : int;
  height : int;
  colour_mode : colour_mode;
  is_initialized : bool;
}

let screen =
  ref
    { width = 0; height = 0; colour_mode = Monochrome; is_initialized = false }

let screen_buffer = ref [||]
let get_screen_buffer () = !screen_buffer

let initialize_buffer width height =
  screen_buffer := Array.make_matrix height width ' '

let parse_colour_mode byte =
  match byte with
  | 0x00 -> Monochrome
  | 0x01 -> SixteenColours
  | 0x02 -> TwoHundredAndFiftySixColours
  | _ -> failwith "Invalid colour mode supplied"

let get_screen_state () = !screen

let initialize_screen_buffer () =
  let state = get_screen_state () in
  initialize_buffer state.width state.height

let setup_screen data =
  if Array.length data <> 3 then failwith "Invalid data length for setup screen"
  else
    let width = data.(0) in
    let height = data.(1) in
    let colour_mode = parse_colour_mode data.(2) in
    if width <= 0 || height <= 0 then
      failwith "Invalid screen dimensions supplied"
    else screen := { width; height; colour_mode; is_initialized = true };
    initialize_screen_buffer ()

let is_ready () = !screen.is_initialized
