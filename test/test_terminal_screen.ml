open Terminal_screen.Screen
open Terminal_screen.Draw_character
open Terminal_screen.Draw_line

let test_setup_screen () =
  let test_data = [| 100; 30; 0x01 |] in
  setup_screen test_data;
  assert (is_ready ());
  let state = get_screen_state () in
  assert (state.width = 100);
  assert (state.height = 30);
  match state.colour_mode with SixteenColours -> () | _ -> assert false

let test_draw_character () =
  let test_data = [| 100; 30; 0x01 |] in
  setup_screen test_data;
  draw_character [| 10; 5; 0x01; Char.code 'A' |];

  let screen_buffer = get_screen_buffer () in
  let character, colour = screen_buffer.(5).(10) in
  assert (character = 'A');
  assert (colour = 0x01)

let test_draw_line () =
  let test_data = [| 100; 30; 0x02 |] in
  setup_screen test_data;

  draw_line [| 10; 5; 20; 15; 42; Char.code '-' |];

  let screen_buffer = get_screen_buffer () in
  let state = get_screen_state () in

  assert (state.width = 100);
  assert (state.height = 30);

  let char_at_5_10, colour_at_5_10 = screen_buffer.(5).(10) in
  let char_at_15_20, colour_at_15_20 = screen_buffer.(15).(20) in

  assert (char_at_5_10 = '-');
  assert (colour_at_5_10 = 42);

  assert (char_at_15_20 = '-');
  assert (colour_at_15_20 = 42)

let test_cases =
  [
    ("Test Setup Screen", `Quick, test_setup_screen);
    ("Test Draw Character", `Quick, test_draw_character);
    ("Test Draw Line", `Quick, test_draw_line);
  ]

let () =
  Printf.printf "Running tests...\n";
  Alcotest.run "Terminal Screen" [ ("Screen Setup", test_cases) ]
