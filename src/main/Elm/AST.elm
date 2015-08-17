module Elm.AST
    ( Module(Module), Definition(Definition), Expression(..)
    , module', definition, literalNumber
    ) where

type Module
    = Module String (List Definition)

type Expression
    = LiteralInt Int

type Definition
    = Definition String Expression


module' : {name:String, imports:List (), declarations:List Definition} -> Module
module' {name, declarations} =
    Module name declarations


definition : { name:String, value:Expression} -> Definition
definition {name,value} =
    Definition name value


literalNumber : Int -> Expression
literalNumber = LiteralInt
