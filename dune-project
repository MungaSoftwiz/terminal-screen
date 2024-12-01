(lang dune 3.17)

(name terminal_screen)

(generate_opam_files true)

(source
 (github MungaSoftwiz/terminal-screen))

(authors "Boniface Munga <mwachilumobm@gmail.com>")

(maintainers "Boniface Munga <mwachilumobm@gmail.com>")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name terminal_screen)
 (synopsis "Terminal Screen")
 (description
  "Program reads bytes supplied to a stream and generated a graphical representation of the bytes.")
 (depends
  (ocaml
   (and
    (>= 5.2.0)
    (< 5.3.0)))
  fmt
  (ocamlformat
   (and
    :with-dev-setup
    (= 0.26.2))))
 (tags
  ("cli program" "OCaml")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
