module Elm where

import String

type ElmModule = ElmModule String (List Definition)
type Definition = Definition String Expression
type Expression = LiteralInt Int

parse : String -> ElmModule
parse _ = module' {name="", imports=[], declarations=[]}


-- TO STRING

expressionToString : Expression -> String
expressionToString expression =
    case expression of
        LiteralInt n -> Basics.toString n


declarationToString : Definition -> String
declarationToString (Definition name value) =
    name ++ " = " ++ (expressionToString value)


toString : ElmModule -> String
toString (ElmModule name declarations) =
    "module " ++ name ++ " where\n\n"
    ++ (declarations |> List.map declarationToString |> String.join "")
    ++ "\n"


-- constructors


module' : {name:String, imports:List (), declarations:List Definition} -> ElmModule
module' {name, declarations} =
    ElmModule name declarations


definition : { name:String, value:Expression} -> Definition
definition {name,value} =
    Definition name value


literalNumber : Int -> Expression
literalNumber = LiteralInt
