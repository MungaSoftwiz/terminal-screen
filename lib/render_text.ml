open Screen

let render_text data =
  if Array.length data < 4 then failwith "Invalid data for render text"
  else
    let x = data.(0) in
    let y = data.(1) in
    let colour_index = data.(2) in
    let text = Array.sub data 3 (Array.length data - 3) in
    let screen_state = get_screen_state () in
    let screen_buffer = get_screen_buffer () in
    let text_string =
      Array.map (fun c -> String.make 1 (Char.chr c)) text
      |> Array.to_list |> String.concat ""
    in
    let text_length = String.length text_string in

    if x < 0 || y < 0 || x >= screen_state.width || y >= screen_state.height
    then failwith "Text starting position is out of bounds"
    else
      for i = 0 to text_length - 1 do
        let screen_x = x + i in
        if screen_x < screen_state.width then
          screen_buffer.(y).(screen_x) <- (text_string.[i], colour_index)
        else ()
      done
