module IntegrationTest.Main where

import ElmTest.Assertion (..)
import ElmTest.Test (..)
import App (..)
import List
import Output (..)

run : List Command -> State
run = List.foldl step initialState

assertOutput : List Command -> Output -> Assertion
assertOutput commands expected =
  toOutput (run commands)
  `assertEqual`
  expected

suite = Suite "IntegrationTest.Main"
  [ test "simplest program" <|
      [ Type "main = \"XYZZY\""]
      `assertOutput`
      file "Main.elm" "main = \"XYZZY\"\n"
  ]
