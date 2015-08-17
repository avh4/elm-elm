module Elm.Expression
    ( Expression
    , literalNumber
    , toString
    ) where

type Expression
    = LiteralInt Int


toString : Expression -> String
toString expression =
    case expression of
        LiteralInt n -> Basics.toString n


literalNumber : Int -> Expression
literalNumber = LiteralInt
