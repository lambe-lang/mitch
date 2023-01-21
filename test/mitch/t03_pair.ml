open Mitch.Lang.Expr
open Mitch.Vm.Objcode
open Mitch.System

open Preface.Result.Monad (struct
  type t = string
end)

let compile s =
  return s
  >>= Transpiler.run
  <&> Expander.run
  >>= Optimiser.run
  <&> Simplifier.run
  <&> Normaliser.run

let compile_01 () =
  let result = compile (Pair (Int 1, Int 2))
  and expected = [ PUSH (INT 2); PUSH (INT 1); PAIR ] in
  Alcotest.(check (result string string))
    "compile (1,2)"
    (return expected <&> to_string)
    (result <&> to_string)

let compile_02 () =
  let result = compile (Fst (Pair (Int 1, Int 2)))
  and expected = [ PUSH (INT 1) ] in
  Alcotest.(check (result string string))
    "compile fst (1,2)"
    (return expected <&> to_string)
    (result <&> to_string)

let compile_03 () =
  let result = compile (Snd (Pair (Int 1, Int 2)))
  and expected = [ PUSH (INT 2) ] in
  Alcotest.(check (result string string))
    "compile snd (1,2)"
    (return expected <&> to_string)
    (result <&> to_string)

let compile_04 () =
  let result = compile (Abs ("p", Fst (Var "p")))
  and expected = [ LAMBDA ("p", [ CAR ]) ] in
  Alcotest.(check (result string string))
    "compile (fun p -> fst p)"
    (return expected <&> to_string)
    (result <&> to_string)

let compile_05 () =
  let result = compile (Abs ("p", App (Fst (Var "p"), Snd (Var "p"))))
  and expected = [ LAMBDA ("p", [ DUP (0, "p"); CAR; SWAP; CDR; EXEC ]) ] in
  Alcotest.(check (result string string))
    "compile (fun p -> (fst p) (snd p))"
    (return expected <&> to_string)
    (result <&> to_string)

let cases =
  let open Alcotest in
  ( "Pair Compilation"
  , [
      test_case "compile O1" `Quick compile_01
    ; test_case "compile 02" `Quick compile_02
    ; test_case "compile 03" `Quick compile_03
    ; test_case "compile 04" `Quick compile_04
    ; test_case "compile 05" `Quick compile_05
    ] )