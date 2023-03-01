{-------------------------
    Programa: palindromo.hs
    Funcion: Verifica cuales lineas de un archivo de texto
            son palindromos y cuales no
            Tomar como base los ejemplos de la pagina de 
            wikipedia. 

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
-------------------------}
import System.Environment
import Data.Char
import Data.Char (ord)

main = do
    args <- getArgs
    arch <- readFile (args !! 0)
    let lineas = lines arch
    analizar lineas

analizar [] = putStrLn ""
analizar (linea : resto) 
    | ajustar linea == reverse (ajustar linea) = do
        putStrLn ((ajustar linea) ++ "-> Es un palindromo " ++ reverse (ajustar linea))
        analizar resto
    | otherwise = do
        putStrLn ((ajustar linea) ++ "-> No es un palindromo " ++ reverse (ajustar linea))
        analizar resto

ajustar :: String -> String
ajustar [] = ""
ajustar (x : resto)
    | ord x == 237 || ord x == 252 = "a" ++ ajustar resto
    | x == chr 174 || x == chr 235 = "e" ++ ajustar resto
    | x == chr 161 || x == chr 236 = "i" ++ ajustar resto
    | x == chr 9474 || x == chr 244 = "o" ++ ajustar resto
    | x == chr 9553 || x == chr 220 = "u" ++ ajustar resto
    | isAlphaNum x = [toLower x] ++ ajustar resto
    | or[x == ' ',x == '.', x == ',', x == '?', x == chr 168] = ajustar resto
    | otherwise = ajustar resto