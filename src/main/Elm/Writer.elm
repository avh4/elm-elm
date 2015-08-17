module Elm.Writer where

import Elm.AST as AST

import String

expression : AST.Expression -> String
expression expression =
    case expression of
        AST.LiteralInt n -> Basics.toString n


declaration : AST.Definition -> String
declaration (AST.Definition name value) =
    name ++ " = " ++ (expression value)


module' : AST.Module -> String
module' (AST.Module name declarations) =
    "module " ++ name ++ " where\n\n"
    ++ (declarations |> List.map declaration |> String.join "")
    ++ "\n"
