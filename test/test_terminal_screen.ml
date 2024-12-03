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
  assert (screen_buffer.(5).(10) = 'A')

let test_draw_line () =
  let test_data = [| 100; 30; 0x01 |] in
  setup_screen test_data;

  draw_line [| 10; 5; 20; 15; 0x01; Char.code '-' |];

  let screen_buffer = get_screen_buffer () in
  assert (screen_buffer.(5).(10) = '-');
  assert (screen_buffer.(15).(20) = '-')

let test_cases =
  [
    ("Test Setup Screen", `Quick, test_setup_screen);
    ("Test Draw Character", `Quick, test_draw_character);
    ("Test Draw Line", `Quick, test_draw_line);
  ]

let () =
  Printf.printf "Running tests...\n";
  Alcotest.run "Terminal Screen" [ ("Screen Setup", test_cases) ]
