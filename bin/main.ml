open Terminal_screen.Screen
open Terminal_screen.Draw_character
open Terminal_screen.Draw_line

let () =
  (* Setup the screen *)
  let example_setup_data = [| 80; 25; 0x01 |] in
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
    else Printf.printf "Screen is not initialized.\n";

    (* Draw characters on the screen *)
    let draw_data_list =
      [
        [| 10; 15; 44; Char.code 'A' |];
        [| 15; 10; 46; Char.code 'B' |];
        [| 30; 15; 12; Char.code 'C' |];
      ]
    in
    List.iter
      (fun draw_data ->
        try draw_character draw_data
        with Failure msg -> Printf.printf "Error: %s\n" msg)
      draw_data_list;

    (* Draw lines on the screen *)
    let line_data_list =
      [
        [| 5; 5; 20; 5; 14; Char.code '-' |];
        [| 20; 10; 10; 20; 22; Char.code '|' |];
        [| 30; 5; 50; 15; 23; Char.code '/' |];
      ]
    in
    List.iter
      (fun line_data ->
        try draw_line line_data
        with Failure msg -> Printf.printf "Error: %s\n" msg)
      line_data_list;

    (* Display the screen buffer with colours *)
    Printf.printf "Screen buffer:\n";
    let screen_buffer = get_screen_buffer () in
    let state = get_screen_state () in
    for y = 0 to state.height - 1 do
      for x = 0 to state.width - 1 do
        let character, colour_index = screen_buffer.(y).(x) in
        display_character character colour_index
      done;
      Printf.printf "\n"
    done
  with Failure msg -> Printf.printf "Error during screen setup: %s\n" msg
