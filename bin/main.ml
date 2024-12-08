open Terminal_screen.Screen
open Terminal_screen.Draw_character
open Terminal_screen.Draw_line
open Terminal_screen.Render_text
open Terminal_screen.Move_cursor

(* Function to print command instructions *)
let print_instructions command =
  match command with
  | 0x1 ->
      Printf.printf
        "Screen Setup (Command 0x1):\n\
         - Enter 3 integers for screen width, height, and colour mode:\n\
         - Example: 80 25 0x02 (for 80x25 screen with 256 colors)\n"
  | 0x2 ->
      Printf.printf
        "Draw Character (Command 0x2):\n\
         - Enter 4 integers: x coordinate, y coordinate, colour index, and \
         ASCII character code:\n\
         - Example: 10 5 1 65 (to draw character 'A' at coordinates (10,5) \
         with colour index 1)\n"
  | 0x3 ->
      Printf.printf
        "Draw Line (Command 0x3):\n\
         - Enter 6 integers: x1, y1 (starting coordinates), x2, y2 (ending \
         coordinates), color index, and ASCII character code:\n\
         - Example: 5 10 15 20 9 42 (to draw a line from (0,0) to (20,10) with \
         colour index 9 using '*' character)\n"
  | 0x4 ->
      Printf.printf
        "Render Text (Command 0x4):\n\
         - Enter integers for x coordinate, y coordinate, colour index, \
         followed by ASCII character codes:\n\
         - Example 45 10 6 72 101 108 108 111 (to render 'Hello' at \
         coordinates (45,10) with colour index 6)\n"
  | 0x5 ->
      Printf.printf
        "Move Cursor (Command 0x5):\n\
         - Enter 2 integers for x and y coordinates:\n\
         - Example: 20 15 (to move cursor to position (20,15))\n"
  | _ -> Printf.printf "Unknown command. Please try again.\n"

(* Function to parse and execute commands *)
let execute_command command data =
  match command with
  | 0x1 ->
      if Array.length data <> 3 then
        failwith "Invalid data length for screen setup"
      else setup_screen data
  | 0x2 ->
      if Array.length data <> 4 then
        failwith "Invalid data length for draw character"
      else draw_character data
  | 0x3 ->
      if Array.length data <> 6 then
        failwith "Invalid data length for draw line"
      else draw_line data
  | 0x4 ->
      if Array.length data < 4 then
        failwith "Invalid data length for render text"
      else render_text data
  | 0x5 ->
      if Array.length data <> 2 then
        failwith "Invalid data length for move cursor"
      else move_cursor data
  | _ -> failwith "Unknown command"

(* Function to display the screen *)
let display_screen () =
  try
    let screen_buffer = get_screen_buffer () in
    let state = get_screen_state () in
    for y = 0 to state.height - 1 do
      for x = 0 to state.width - 1 do
        let character, colour_index = screen_buffer.(y).(x) in
        if x = state.cursor_x && y = state.cursor_y then
          Printf.printf "\x1b[7m%c\x1b[0m" character;
        display_character character colour_index
      done;
      Printf.printf "\n"
    done
  with Failure msg -> Printf.printf "Error during screen setup: %s\n" msg

(* Main function to process input *)
let rec main () =
  Printf.printf
    "Enter command:\n\
    \    (0x1 for setup,        0x2 for draw character,   0x3 for draw line, \n\
    \    0x4 for render_text,   0x5 for move cursor\n\
    \    q to quit):\n";
  let input = read_line () in
  if input = "q" then (
    Printf.printf "Exiting program.\n";
    exit 0)
  else
    try
      let command = int_of_string input in
      print_instructions command;
      Printf.printf "Enter data as space-separated integers:\n";
      Printf.printf "(@) ";
      let data =
        read_line () |> String.split_on_char ' ' |> Array.of_list
        |> Array.map int_of_string
      in
      execute_command command data;

      if command <> 0x1 then display_screen ();
      Printf.printf "Command executed successfully.\n";
      main ()
    with
    | Failure msg ->
        Printf.printf "Error: %s\n" msg;
        main ()
    | _ ->
        Printf.printf "Invalid input. Please try again.\n";
        main ()

(* Start the program *)
let () = main ()
