open Mitch_utils

module Term = struct
  open Term

  let rec render : type a. Format.formatter -> a t -> unit =
   fun ppf ->
    let open Format in
    function
    | Abs (n, c) -> fprintf ppf "fun %s -> %a" n render c
    | App (l, r) -> fprintf ppf "%a (%a)" render l render r
    | Var n -> fprintf ppf "%s" n
    | Unit -> fprintf ppf "unit"
    | Int i -> fprintf ppf "%d" i
    | Inl c -> fprintf ppf "(inl %a)" render c
    | Inr c -> fprintf ppf "(inr %a)" render c
    | Case (c, l, r) ->
      fprintf ppf "case %a (%a) (%a)" render c render l render r
    | Pair (l, r) -> fprintf ppf "(%a,%a)" render l render r
    | Fst e -> fprintf ppf "fst(%a)" render e
    | Snd e -> fprintf ppf "snd(%a)" render e
    | Let (n, e, f) -> fprintf ppf "let %s = %a in %a" n render e render f
    | Rec (n, c) -> fprintf ppf "rec(%s).(%a)" n render c

  let to_string : type a. a t -> string = fun o -> Render.to_string render o
end

module Type = struct
  open Type

  let rec render : Format.formatter -> t -> unit =
   fun ppf ->
    let open Format in
    function
    | Arrow (l, r) -> fprintf ppf "%a -> %a" render l render r
    | Product (l, r) -> fprintf ppf "(%a * %a)" render l render r
    | Sum (l, r) -> fprintf ppf "(%a + %a)" render l render r
    | Native s -> fprintf ppf "%s" s

  let to_string : t -> string = fun o -> Render.to_string render o
end
