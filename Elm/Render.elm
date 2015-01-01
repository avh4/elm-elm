module Elm.Render where

import Elm (..)

toFile : Module -> (String, String)
toFile s = ("Main.elm", s)
