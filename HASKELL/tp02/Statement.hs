module Statement(T, parse, toString, fromString, exec) where
import Prelude hiding (return, fail)
import Parser hiding (T)
import qualified Dictionary
import qualified Expr
type T = Statement
data Statement =
    Assignment String Expr.T |
    Skip |
    Read String |
    Write Expr.T |
    Begin [Statement] |
    While Expr.T Statement |
    If Expr.T Statement Statement
    deriving Show

assignment, skip, read', write', begin, while, if', statement :: Parser Statement

assignment = word #- accept ":=" # Expr.parse #- require ";" >-> buildAss
buildAss (v, e) = Assignment v e

skip = accept "skip" #- require ";" >-> buildSkip
buildSkip _ = Skip

read' = (accept "read" -# word) #- require ";" >-> buildRead
buildRead string = Read string

write' = (accept "write" -# Expr.parse) #- require ";" >-> buildWrite
buildWrite expr = Write expr

begin = (accept "begin" -# iter statement) #- require "end" >-> buildBegin
buildBegin statement = Begin statement

while = (accept "while" -# Expr.parse) #- require "do" # statement >-> buildWhile
buildWhile (cond, statements) = While cond statements

if' = (((accept "if" -# Expr.parse) #- require "then") # statement) # (require "else" -# statement) >-> buildIf
buildIf ((cond, s1), s2) = If cond s1 s2 

statement = assignment ! skip ! read' ! write' ! begin ! while ! if'



exec :: [T] -> Dictionary.T String Integer -> [Integer] -> [Integer]
exec [] _ _ = []
exec (If cond thenStmts elseStmts: stmts) dict input = 
    if (Expr.value cond dict)>0 
    then exec (thenStmts: stmts) dict input
    else exec (elseStmts: stmts) dict input
exec (Assignment string expr : stmts) dict input = 
	exec stmts newDict input
		where newDict = Dictionary.insert (string, Expr.value expr dict) dict
exec (Skip : stmts) dict input = 
	exec stmts dict input
exec (Read string : stmts) dict (v:r) = 
	exec stmts newDict r
		where newDict = Dictionary.insert (string, v) dict
exec (Write expr : stmts) dict input = 
	Expr.value expr dict : exec stmts dict input
exec (Begin statements : stmts) dict input = 
	exec (statements++stmts) dict input
exec (While cond statement : stmts) dict input = 
	if (Expr.value cond dict) > 0
	then exec (statement : While cond statement: stmts) dict input
	else exec stmts dict input


shw :: Statement -> String
shw (Assignment s e) = s ++ " := " ++ Expr.toString e ++ ";" ++ "\n"
shw (Skip) = "skip;" ++ "\n"
shw (Read s) = "read " ++ s ++ ";" ++ "\n"
shw (Write e) = "write " ++ Expr.toString e ++ ";" ++ "\n"
shw (Begin l) = "Begin " ++ rshw l ++ "End" ++ "\n"
shw (While cond s) = "While " ++ Expr.toString cond ++ "\n" ++ shw s ++ "\n"
shw (If cond s1 s2) = "If " ++ Expr.toString cond ++ 
	"\nThen " ++ shw s1 ++
	"\nElse " ++ shw s2  ++ "\n"

rshw :: [Statement] -> String
rshw [] = ""
rshw (s:r) = shw s ++ rshw r

instance Parse Statement where
  parse = statement
  toString = shw
