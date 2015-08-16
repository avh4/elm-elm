module Tests where

import ElmTest.Assertion exposing (..)
import ElmTest.Test exposing (..)

import Elm

roundTrip : String -> Bool
roundTrip program =
    let
        parsed = program |> Elm.parse
        reparsed = parsed |> Elm.toString |> Elm.parse
    in
        parsed == reparsed

all : Test
all =
    suite "all" [
        suite "round trip" [
            test "simplest program" <| assert (roundTrip "import Html\n\nmain = Html.text \"Hello\""),
            test "simplest module" <| assert (roundTrip "module Foo where\n\nfoo = 42")
        ],
        suite "toString" [
            test "simplest module" <|
                assertEqual
                    ( Elm.module'
                        { name="Foo"
                        , imports=[]
                        , declarations=
                            [ Elm.definition
                                { name="foo"
                                , value=Elm.literalNumber 42
                                }
                            ]
                        }
                    |> Elm.toString
                    )
                    "module Foo where\n\nfoo = 42\n"
        ]
    ]
