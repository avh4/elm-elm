module Elm.Parser where

import Parser exposing (Parser)
import Parser.Char as Parser
import Parser.Number as Parser
import Elm.AST as AST

import String


-- HELPERS

object2 : (a -> b -> z) -> Parser a -> Parser b -> Parser z
object2 fn a b =
    fn `Parser.map` a `Parser.and` b

object3 : (a -> b -> c -> z) -> Parser a -> Parser b -> Parser c -> Parser z
object3 fn a b c =
    fn `Parser.map` a `Parser.and` b `Parser.and` c

object4 : (a -> b -> c -> d -> z) -> Parser a -> Parser b -> Parser c -> Parser d -> Parser z
object4 fn a b c d =
    fn `Parser.map` a `Parser.and` b `Parser.and` c `Parser.and` d


-- PARSE

parse : String -> Result String AST.Module
parse = Parser.parse module'


-- BASIC SYNTAX

whitespace : Parser ()
whitespace =
    Parser.symbol ' '
    |> Parser.some
    |> Parser.map (always ())


moduleName : Parser String
moduleName =
    object2 (\a b -> List.foldr String.cons "" (a::b))
        Parser.upper
        (Parser.some Parser.lower)


variableName : Parser String
variableName =
    object2 (\a b -> List.foldr String.cons "" (a::b))
        Parser.lower
        (Parser.some Parser.lower)


-- AST

expression : Parser AST.Expression
expression =
    Parser.choice
        [ Parser.integer |> Parser.map AST.literalNumber
        ]


definition : Parser AST.Definition
definition =
    (\name _ value -> AST.definition {name=name, value=value})
    `Parser.map` variableName
    `Parser.and` (Parser.token " = ")
    `Parser.and` expression


module' : Parser AST.Module
module' =
    (\_ _ name _ declarations -> AST.module' {name=name, imports=[], declarations=declarations})
    `Parser.map` (Parser.token "module")
    `Parser.and` whitespace
    `Parser.and` (moduleName)
    `Parser.and` (Parser.token " where\n\n")
    `Parser.and` (Parser.many definition)
