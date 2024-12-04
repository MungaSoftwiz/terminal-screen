open Screen

let draw_line data =
  if Array.length data <> 6 then failwith "Invalid data length for draw line"
  else if not (is_ready ()) then failwith "Screen is not initialized"
  else
    let x1 = data.(0) in
    let y1 = data.(1) in
    let x2 = data.(2) in
    let y2 = data.(3) in
    let colour_index = data.(4) in
    let character = Char.chr data.(5) in

    let state = get_screen_state () in
    if
      x1 < 0 || x1 >= state.width || y1 < 0 || y1 >= state.height || x2 < 0
      || x2 >= state.width || y2 < 0 || y2 >= state.height
    then failwith "Coordinates oare out of bounds"
    else if colour_index < 0 || colour_index >= Array.length state.palette then
      failwith "Invalid colour index supplied"
    else
      let screen_buffer = get_screen_buffer () in
      (* Bresenham's algorithm *)
      let dx = abs (x2 - x1) in
      let dy = abs (y2 - y1) in
      let sx = if x1 < x2 then 1 else -1 in
      let sy = if y1 < y2 then 1 else -1 in
      let rec draw x y err =
        if x = x2 && y = y2 then
          screen_buffer.(y).(x) <- (character, colour_index)
        else
          let () = screen_buffer.(y).(x) <- (character, colour_index) in
          let e2 = 2 * err in
          let next_x, next_y, next_err =
            if e2 > -dy then (x + sx, y, err - dy) else (x, y, err)
          in
          let next_x, next_y, next_err =
            if e2 < dx then (next_x, next_y + sy, next_err + dx)
            else (next_x, next_y, next_err)
          in
          draw next_x next_y next_err
      in
      draw x1 y1 (dx - dy);
      let { r; g; b } = state.palette.(colour_index) in
      Printf.printf
        "Drawing line from (%d, %d) to (%d, %d) with colour %d (RGB: %d, %d, \
         %d)and character '%c'\n"
        x1 y1 x2 y2 colour_index r g b character
