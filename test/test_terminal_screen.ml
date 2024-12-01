open Terminal_screen.Screen

let test_setup_screen () =
  let test_data = [| 100; 30; 0x01 |] in
  setup_screen test_data;
  assert (is_ready ());
  let state = get_screen_state () in
  assert (state.width = 100);
  assert (state.height = 30);
  match state.colour_mode with SixteenColours -> () | _ -> assert false

let test_cases = [ ("Test Setup Screen", `Quick, test_setup_screen) ]

let () =
  Printf.printf "Running tests...\n";
  Alcotest.run "Terminal Screen" [ ("Screen Setup", test_cases) ]
(* test_setup_screen ();
   Printf.printf "All tests passed!\n" *)
