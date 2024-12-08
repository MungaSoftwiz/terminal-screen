open Screen

let move_cursor data =
  if Array.length data <> 2 then
    failwith "Invalid data length for cursor movement";
  let x = data.(0) in
  let y = data.(1) in
  let state = get_screen_state () in

  if x < 0 || x >= state.width || y < 0 || y >= state.height then
    failwith "Cursor position out of bounds";

  let new_state = { state with cursor_x = x; cursor_y = y } in
  set_screen_state new_state;

  (* Printf.printf "Cursor moved to (%d, %d)\n" x y *)
  Printf.printf "Cursor moved to (%d, %d)\n" x y
