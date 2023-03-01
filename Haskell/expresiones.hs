{--
    Programa: expresion.hs
    Funcion: Procesamiento de expresiones tipo C y 
            generador de codigo ensamblador (lo crea tanto en archivo como en consola)

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
    ---------------------------------------------
    Gramatica de expresion (BNF)
    <exp> ::= <exp> + <term> | <exp> - <term> | <term>
    <term> ::= <term> * <factor> | <term> / <factor> | <term> % <factor> | <factor>
    <factor> ::= ~<fact> | <fact>
    <fact> ::= <variable> | (<exp>)
    <variable> ::= a | b | c | d | ... | z
--}
import System.IO
import Data.List
main = do
    putStrLn "Da una expresion tipo C"
    expre <- getLine
    if esExpre expre 0 0
        then do
            putStrLn "Expresion Correcta"
            let exprePos = posFija [expre,""]
            putStrLn $ "Expresion posFija: " ++ exprePos
            let variables = contarVar exprePos
            putStrLn $ "Variables: " ++ (show variables)
            ensam expre exprePos variables
        else do
            putStrLn "Error de sintaxis"
{-------------------------------------------
    Codigo para validar la expresion
-------------------------------------------}
esVariable x = and[x >= 'a', x <= 'z']
esBinario x = or[x == '+', x == '-', x == '*', x == '/', x == '%']

esExpre [] 1 0 = True
esExpre (x : resto) estado cParen
    | and[estado == 0, x == '('] = esExpre resto 0 (cParen + 1)
    | and[estado == 0, esVariable x] = esExpre resto 1 cParen
    | and[estado == 0, x == '~'] = esExpre resto 0 cParen
    | and[estado == 1, x == ')', cParen == 0] = False
    | and[estado == 1, x == ')'] = esExpre resto 1 (cParen - 1)
    | and[estado == 1, esBinario x] = esExpre resto 0 cParen
    | otherwise = False
{-------------------------------------------
    Codigo para pasar a postfija
-------------------------------------------}
posFija :: [String] -> String
posFija [[],[]] = ""
posFija [[], (y : restoP)] = [y] ++ posFija [[], restoP]
posFija [(x : restoE), pila]
    | esVariable x = [x] ++ (posFija [restoE, pila])
    | x == ')' = posFija2 [restoE, pila] ""
    | otherwise = posFija3 [(x : restoE), pila]

posFija2 :: [String] -> String -> String
posFija2 [expresion,[]] aux = aux ++ posFija [expresion, []] 
posFija2 [expresion, (y : restoP)] aux
    | y == '(' = aux ++ posFija [expresion, restoP]
    | otherwise = posFija2 [expresion, restoP] (aux ++ [y]) 

posFija3 :: [String] -> String
posFija3 [(x : restoE), []] = posFija [restoE, [x]]
posFija3 [(x : restoE), (y : restoP)]
    | prioridades x y == True = posFija [restoE, ([x] ++ [y] ++ restoP)]
    | otherwise = [y] ++ posFija3 [(x : restoE), restoP]

prioridades :: Char -> Char -> Bool
prioridades entra enPila 
    | (priEnt entra) > (priSal enPila) =True
    | otherwise = False

priEnt :: Char -> Int
priEnt x 
    | or[x == '+', x == '-'] = 1
    | or[x == '*', x == '/', x == '%'] = 2
    | x == '~' = 4
    | x == '(' = 5

priSal :: Char -> Int
priSal x 
    | or[x == '+', x == '-'] = 1
    | or[x == '*', x == '/', x == '%'] = 2
    | x == '~' = 3
    | x == '(' = 0
{-------------------------------------------
    Codigo para contar las variables
-------------------------------------------}
contarVar :: String-> [Char]
contarVar exp = nub (limpiarVar exp)

limpiarVar :: String -> String 
limpiarVar [] = ""
limpiarVar (x : resto)
    | esVariable x = [x] ++ (limpiarVar resto)
    | otherwise = limpiarVar resto
{-------------------------------------------
    Codigo para crear ensamblador
-------------------------------------------}
ensam :: String -> String -> [Char] -> IO()
ensam exp expPos variables = do
    let file = "expresion.asm"
    let encabezado = ("; Programa: expresion.asm \n; Infija: " ++ exp ++  "\n; Posfija: " ++ expPos 
            ++ "\ntext\t\tsegment \n\t\t\tassume cs:text, ds:text, ss:text \n\t\t\torg 100h")
    let main_e = "\nmain:" ++ codigo_main expPos variables
    let dec_e = "\n\nbuffer\t\tdb 6,0,6 dup(?) \nmsg1\t\tdb \'Da el valor de \'"
            ++ "\nnomvar\t\tdb 0 \n\t\t\tdb \': $\'"
            ++ "\nmsg2\t\tdb \'El resultado es $\' \nres\t\t\tdw 0" ++ codigo_var variables
                
    let codigo = encabezado ++ main_e ++ dec_e ++ rutinas
    writeFile file codigo
    contenido <- readFile file
    putStrLn "expresion.asm : "
    putStrLn contenido

codigo_main :: String -> [Char] -> String
codigo_main exp variables = (captura_Var variables) ++ "\n" ++ (oper_ens exp)

captura_Var :: [Char] -> String
captura_Var [] = ""
captura_Var (x : resto) =  "\n\t\t\tmov nomvar, \'" ++ [x] ++ "\' \n\t\t\tmov dx, offset msg1"
        ++ "\n\t\t\tmov ah,9 \n\t\t\tint 21h \n\t\t\tcall lecdec \n\t\t\tmov " ++ [x] ++ ",ax"
        ++ "\n\t\t\tcall saltaren" ++ captura_Var resto
            
oper_ens :: String -> String
oper_ens [] = "\n\t\t\tPOP ax \n\n\t\t\tmov res,ax \n\t\t\tmov dx, offset msg2 \n\t\t\tmov ah,9"
        ++ "\n\t\t\tint 21h \n\t\t\tmov ax,res \n\t\t\tcall impdec \n\t\t\tcall saltaren \n\t\t\tint 20h"
oper_ens (x : resto) 
    | esVariable x = "\n\t\t\tPUSH " ++ [x] ++ oper_ens resto
    | x == '+' = "\n\t\t\tPOP bx \n\t\t\tPOP ax \n\t\t\tADD ax,bx \n\t\t\tPUSH ax" ++ oper_ens resto
    | x == '-' = "\n\t\t\tPOP bx \n\t\t\tPOP ax \n\t\t\tSUB ax,bx \n\t\t\tPUSH ax" ++ oper_ens resto
    | x == '*' = "\n\t\t\tPOP bx \n\t\t\tPOP ax \n\t\t\tMUL bx \n\t\t\tPUSH ax" ++ oper_ens resto
    | x == '/' = "\n\t\t\tPOP bx \n\t\t\tPOP ax \n\t\t\tXOR dx,dx \n\t\t\tDIV bx \n\t\t\tPUSH ax" ++ oper_ens resto
    | x == '%' = "\n\t\t\tPOP bx \n\t\t\tPOP ax \n\t\t\tXOR dx,dx \n\t\t\tDIV bx \n\t\t\tPUSH dx" ++ oper_ens resto
    | x == '~' = "\n\t\t\tPOP ax \n\t\t\tNEG ax \n\t\t\tPUSH ax" ++ oper_ens resto

codigo_var :: [Char] -> String
codigo_var [] = ""
codigo_var (x : resto) = "\n" ++ [x] ++ "\t\t\tdw 0" ++ codigo_var resto

rutinas = 
        "\n\nimpdec\t\tproc near \n\t\t\tpush ax \n\t\t\tpush bx \n\t\t\tpush cx \n\t\t\tpush dx \n\t\t\tmov bx,10 \n\t\t\txor cx,cx"
        ++ "\nimpdec0:\txor dx,dx \n\t\t\tdiv bx \n\t\t\tadd dl,'0' \n\t\t\tpush dx \n\t\t\tinc cx \n\t\t\tcmp ax,0 \n\t\t\tjne impdec0"
        ++ "\nimpdec1:\tpop dx \n\t\t\tmov ah,2 \n\t\t\tint 21h \n\t\t\tloop impdec1 \n\t\t\tpop dx \n\t\t\tpop cx \n\t\t\tpop bx \n\t\t\tpop ax \n\t\t\tret"
        ++ "\nimpdec\t\tendp"

        ++ "\n\nlecdec\t\tproc near \n\t\t\tpush bx \n\t\t\tpush cx \n\t\t\tpush dx \n\t\t\tpush si \n\t\t\tmov dx, offset buffer \n\t\t\tmov ah,0ah \n\t\t\tint 21h \n\t\t\txor ax,ax \n\t\t\tmov bx,10 \n\t\t\tmov si, offset buffer \n\t\t\tinc si \n\t\t\tmov cl,[si] \n\t\t\txor ch,ch"
        ++ "\nlecdec0:\tmul bx \n\t\t\tinc si \n\t\t\tmov dl,[si] \n\t\t\tsub dl,'0' \n\t\t\txor dh,dh \n\t\t\tadd ax,dx \n\t\t\tloop lecdec0 \n\t\t\tpop si \n\t\t\tpop dx \n\t\t\tpop cx \n\t\t\tpop bx \n\t\t\tret"
        ++ "\nlecdec\t\tendp"

        ++ "\n\nsaltaren\tproc \n\t\t\tpush ax \n\t\t\tpush dx \n\t\t\tmov dl,0dh \n\t\t\tmov ah,2 \n\t\t\tint 21h \n\t\t\tmov dl,0ah \n\t\t\tmov ah,2 \n\t\t\tint 21h \n\t\t\tpop dx \n\t\t\tpop ax \n\t\t\tret "
        ++ "\nsaltaren\tendp"

        ++ "\n\ntext\t\tends \n\t\t\tend main"