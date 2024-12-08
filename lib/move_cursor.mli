val move_cursor : int array -> unit
(** [move_cursor positions] moves the cursor to the specified position.
    @param positions An array of integers representing the cursor's new position.
                      The array should contain two elements: the row and column
                      positions respectively.
    @raise Invalid_argument if the array does not contain exactly two elements. *)
