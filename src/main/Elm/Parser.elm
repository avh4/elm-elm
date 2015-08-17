module Elm.Parser where

import Parser exposing (Parser)
import Parser.Char as Parser
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
parse = Parser.parse parser


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


-- AST

parser : Parser AST.Module
parser =
    object4 (\_ _ name declarations -> AST.module' {name=name, imports=[], declarations=declarations})
        (Parser.token "module")
        whitespace
        (moduleName)
        (Parser.succeed [AST.definition {name="foo", value=AST.literalNumber 42}])
