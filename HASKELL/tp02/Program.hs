module Program(T, parse, fromString, toString, exec) where
import Parser hiding (T)
import qualified Statement
import qualified Dictionary
import Prelude hiding (return, fail)
newtype T = Program [Statement.T]


program = iter Statement.parse >-> makeProgram
makeProgram l = Program l

shw :: T -> String
shw (Program ls) = rshw ls

rshw :: [Statement.T] -> String
rshw [] = ""
rshw (s:r) = Statement.toString s ++ rshw r

instance Parse T where
  parse = program
  toString = shw
             
exec :: T -> [Integer] -> [Integer]
exec (Program ls) input = Statement.exec ls Dictionary.empty input