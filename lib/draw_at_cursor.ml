open Screen

let draw_at_cursor data =
  if Array.length data <> 2 then
    failwith "Invalid data length for draw at cursor"
  else if not (is_ready ()) then failwith "Screen not set up"
  else
    let char_code = data.(0) in
    let colour_index = data.(1) in

    if char_code < 32 || char_code > 126 then failwith "Invalid character code"
    else if
      colour_index < 0
      || colour_index >= Array.length (get_screen_state ()).palette
    then failwith "Invalid colour index"
    else
      let character = Char.chr char_code in
      let state = get_screen_state () in
      let x = state.cursor_x in
      let y = state.cursor_y in
      let screen_buffer = get_screen_buffer () in

      screen_buffer.(y).(x) <- (character, colour_index);
      let { r; g; b } = state.palette.(colour_index) in
      Printf.printf
        "Drawing character '%c' at cursor position (%d, %d) with colour %d \
         (RGB: %d, %d, %d)\n"
        character x y colour_index r g b
