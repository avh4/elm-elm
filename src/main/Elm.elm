module Elm where

import Elm.Expression as Expression exposing (Expression)

import String

type ElmModule = ElmModule String (List Definition)
type Definition = Definition String Expression

parse : String -> ElmModule
parse _ = module' {name="", imports=[], declarations=[]}


-- TO STRING

declarationToString : Definition -> String
declarationToString (Definition name value) =
    name ++ " = " ++ (Expression.toString value)


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
literalNumber = Expression.literalNumber
