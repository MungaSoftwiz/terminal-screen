open Screen

let draw_character data =
  if Array.length data <> 4 then
    failwith "Invalid data length for draw character"
  else if not (is_ready ()) then failwith "Screen is not initialized"
  else
    let x = data.(0) in
    let y = data.(1) in
    let colour_index = data.(2) in
    let character = Char.chr data.(3) in

    let state = get_screen_state () in
    if x < 0 || x >= state.width || y < 0 || y >= state.height then
      failwith "Coordinates are out of bounds"
    else if colour_index < 0 || colour_index >= Array.length state.palette then
      failwith "Invalid colour index supplied"
    else
      let screen_buffer = get_screen_buffer () in
      screen_buffer.(y).(x) <- (character, colour_index);
      let { r; g; b } = state.palette.(colour_index) in
      Printf.printf
        "Drawing character '%c' at (%d, %d) with colour %d (RGB: %d, %d, %d)\n"
        character x y colour_index r g b
