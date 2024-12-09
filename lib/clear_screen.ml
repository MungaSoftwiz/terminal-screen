open Screen

let clear_screen () =
  if not (is_ready ()) then failwith "Screen not set up"
  else
    let state = get_screen_state () in
    let screen_buffer = get_screen_buffer () in

    for y = 0 to state.height - 1 do
      for x = 0 to state.width - 1 do
        screen_buffer.(y).(x) <- (' ', 0x00)
      done
    done;

    Printf.printf "Screen cleared\n"
