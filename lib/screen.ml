type colour_mode = Monochrome | SixteenColours | TwoHundredAndFiftySixColours
type colour = { r : int; g : int; b : int }

let monochrome_palette =
  [| { r = 0; g = 0; b = 0 }; { r = 255; g = 255; b = 255 } |]

let sixteen_palette =
  [|
    { r = 0; g = 0; b = 0 };
    { r = 0; g = 0; b = 170 };
    { r = 0; g = 170; b = 0 };
    { r = 0; g = 170; b = 170 };
    { r = 170; g = 0; b = 0 };
    { r = 170; g = 0; b = 170 };
    { r = 170; g = 85; b = 0 };
    { r = 170; g = 170; b = 170 };
    { r = 85; g = 85; b = 85 };
    { r = 85; g = 85; b = 255 };
    { r = 85; g = 255; b = 85 };
    { r = 85; g = 255; b = 255 };
    { r = 255; g = 85; b = 85 };
    { r = 255; g = 85; b = 255 };
    { r = 255; g = 255; b = 85 };
    { r = 255; g = 255; b = 255 };
  |]

let two_fifty_six_palette = Array.init 256 (fun i -> { r = i; g = i; b = i })

type screen_state = {
  width : int;
  height : int;
  colour_mode : colour_mode;
  is_initialized : bool;
  palette : colour array;
}

let screen =
  ref
    {
      width = 0;
      height = 0;
      colour_mode = Monochrome;
      is_initialized = false;
      palette = monochrome_palette;
    }

let screen_buffer = ref [||]
let get_screen_buffer () = !screen_buffer

let initialize_buffer width height =
  (* screen_buffer := Array.make_matrix height width 0 *)
  screen_buffer := Array.make_matrix height width (' ', 0)

let parse_colour_mode byte =
  match byte with
  | 0x00 -> (Monochrome, monochrome_palette)
  | 0x01 -> (SixteenColours, sixteen_palette)
  | 0x02 -> (TwoHundredAndFiftySixColours, two_fifty_six_palette)
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

    let colour_mode, palette = parse_colour_mode data.(2) in
    if width <= 0 || height <= 0 then
      failwith "Invalid screen dimensions supplied"
    else
      screen := { width; height; colour_mode; is_initialized = true; palette };
    initialize_screen_buffer ()

let display_character character colour_index =
  let state = get_screen_state () in
  match state.colour_mode with
  | Monochrome ->
      if colour_index < Array.length state.palette then
        let { r; g; b } = monochrome_palette.(colour_index) in
        Printf.printf "\x1b[38;2;%d;%d;%dm%c\x1b[0m" r g b character
      else Printf.printf "\x1b[38;2;255;255;255m%c\x1b[0m" character
  | SixteenColours ->
      if colour_index < Array.length sixteen_palette then
        let { r; g; b } = sixteen_palette.(colour_index) in
        Printf.printf "\x1b[38;2;%d;%d;%dm%c\x1b[0m" r g b character
      else Printf.printf "\x1b[38;2;255;255;255m%c\x1b[0m" character
  | TwoHundredAndFiftySixColours ->
      Printf.printf "\x1b[38;5;%dm%c\x1b[0m" colour_index character

let is_ready () = !screen.is_initialized
