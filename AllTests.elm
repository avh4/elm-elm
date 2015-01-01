module AllTests where

import ElmTest.Assertion (..)
import ElmTest.Test (..)

import IntegrationTest.Main

all = Suite "elm-elm"
  [ IntegrationTest.Main.suite
  ]
