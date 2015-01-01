module App where

import Elm

type Command
  = Type String

type alias State = Elm.Module

initialState : State
initialState = ""

step : Command -> State -> State
step c s = case c of
  Type s' -> s' ++ "\n"
