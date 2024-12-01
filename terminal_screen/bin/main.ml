open Terminal_screen.Screen

let () =
  let example_setup_data = [| 80; 25; 0x02 |] in
  try
    setup_screen example_setup_data;
    if is_ready () then
      let state = get_screen_state () in
      Printf.printf "Screen is ready with dimensions %dx%d and colour mode %s\n"
        state.width state.height
        (match state.colour_mode with
        | Monochrome -> "Monochrome"
        | SixteenColours -> "16 Colours"
        | TwoHundredAndFiftySixColours -> "256 Colours")
    else Printf.printf "Screen is not initialized.\n"
  with Failure msg -> Printf.printf "Error: %s\n" msg
