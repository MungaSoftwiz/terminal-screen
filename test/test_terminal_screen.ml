open Terminal_screen.Screen
open Terminal_screen.Draw_character
open Terminal_screen.Draw_line
open Terminal_screen.Render_text
open Terminal_screen.Move_cursor
open Terminal_screen.Draw_at_cursor
open Terminal_screen.Clear_screen

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

let test_render_text () =
  let test_data = [| 100; 30; 0x02 |] in
  setup_screen test_data;

  render_text
    [|
      5;
      10;
      0x01;
      Char.code 'H';
      Char.code 'e';
      Char.code 'l';
      Char.code 'l';
      Char.code 'o';
    |];

  let screen_buffer = get_screen_buffer () in
  let expected_text = [ 'H'; 'e'; 'l'; 'l'; 'o' ] in
  List.iteri
    (fun i char ->
      let screen_x = 5 + i in
      let char_at_x_y, colour_mode = screen_buffer.(10).(screen_x) in
      assert (char_at_x_y = char);
      assert (colour_mode = 0x01))
    expected_text

let test_move_cursor () =
  let test_data = [| 100; 30; 0x01 |] in
  setup_screen test_data;

  let move_data = [| 10; 5 |] in
  move_cursor move_data;

  let state = get_screen_state () in
  assert (state.cursor_x = 10);
  assert (state.cursor_y = 5);

  let move_data_2 = [| 15; 20 |] in
  move_cursor move_data_2;

  let state_2 = get_screen_state () in
  assert (state_2.cursor_x = 15);
  assert (state_2.cursor_y = 20);

  try
    move_cursor [| 150; 35 |];
    assert false
  with
  | Failure _ -> ()
  | _ -> assert false

let test_draw_at_cursor () =
  let test_data = [| 100; 30; 0x02 |] in
  setup_screen test_data;

  let move_data = [| 15; 10 |] in
  move_cursor move_data;

  draw_at_cursor [| Char.code 'C'; 12 |];

  let state = get_screen_state () in
  let screen_buffer = get_screen_buffer () in

  let character, colour_index =
    screen_buffer.(state.cursor_y).(state.cursor_x)
  in
  assert (character = 'C');
  assert (colour_index = 12);

  let char_at_other, colour_at_other = screen_buffer.(0).(0) in
  assert (char_at_other = ' ');
  assert (colour_at_other = 0x00)

let test_clear_screen () =
  let test_data = [| 100; 30; 0x01 |] in
  setup_screen test_data;

  draw_character [| 10; 5; 0x01; Char.code 'A' |];

  clear_screen ();

  let screen_buffer = get_screen_buffer () in
  let state = get_screen_state () in

  for y = 0 to state.height - 1 do
    for x = 0 to state.width - 1 do
      let char, colour = screen_buffer.(y).(x) in
      assert (char = ' ');
      assert (colour = 0x00)
    done
  done

let test_cases =
  [
    ("Test Setup Screen", `Quick, test_setup_screen);
    ("Test Draw Character", `Quick, test_draw_character);
    ("Test Draw Line", `Quick, test_draw_line);
    ("Test Render Text", `Quick, test_render_text);
    ("Test Move Cursor", `Quick, test_move_cursor);
    ("Test Draw at Cursor", `Quick, test_draw_at_cursor);
    ("Test Clear Screen", `Quick, test_clear_screen);
  ]

let () =
  Printf.printf "Running tests...\n";
  Alcotest.run "Terminal Screen" [ ("Screen Setup", test_cases) ]
