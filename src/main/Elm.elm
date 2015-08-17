module Elm where

import Elm.AST as AST
import Elm.Parser as Parser
import Elm.Writer as Writer

import String
import Result

parse : String -> Result String AST.Module
parse = Parser.parse


toString : AST.Module -> String
toString = Writer.module'
