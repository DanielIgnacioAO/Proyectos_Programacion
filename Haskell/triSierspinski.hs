{-------------------------
    Programa: triSierspinski.hs
    Funcion: Construye el triangulo de Sierspinski: 
            conformado por * y espacios creado a partir de automatas celulares

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
-------------------------}
import System.Environment
import Data.Text
import Text.Printf
main = do
    args <- getArgs
    if(Prelude.null args)
        then do
            putStrLn "\nTriangulo de Sierspinski"
            sierpinski [1] 0 15
        else do
            let num = read (Prelude.head args) :: Int
            putStrLn "\nTriangulo de Sierspinski"
            sierpinski [1] 0 num
----------------------------------- 
sierpinski :: [Int] -> Int -> Int ->IO()
sierpinski lista i n 
    | i > n = putStrLn ""
    | otherwise = do
        putStrLn ""
        impLista lista
        let lista2 = [1] ++ (sierNivel lista)
        sierpinski lista2 (i + 1) n

sierNivel :: [Int] -> [Int]
sierNivel [1] = [1]
sierNivel (x : y: resto) 
    | x == y = [0] ++ (sierNivel (y : resto))  
    | otherwise = [1] ++ (sierNivel (y : resto))

impLista [] = putStr ""
impLista (x : resto) 
    | x == 1 = do
        putStr "* "
        impLista resto
    | otherwise = do
        putStr "  "
        impLista resto