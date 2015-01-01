module Output where

import Dict (..)
import App
import Elm.Render as Render

type alias Output = Dict String String

file = singleton

toOutput : App.State -> Output
toOutput s = case Render.toFile s of
  (filename, content) -> file filename content
