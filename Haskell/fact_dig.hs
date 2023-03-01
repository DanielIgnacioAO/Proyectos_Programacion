{-------------------------
    Programa: fact_dig.hs
    Funcion: Cuenta el numero de digitos de 0,1,2,...,9 de N!
    
    Cual es el menor valor de N para el que N! tenga todos los digitos? R=23

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118 
-------------------------}
import System.Environment
main = do
    args <- getArgs
    let num = read (head args) :: Integer
    let fac = factorial num
    let lis = numLista fac
    putStrLn ("N: " ++ (show num))
    putStrLn ("El factorial es: " ++ (show fac))
    putStrLn ("(0) " ++ (show (contar 0 lis)))
    putStrLn ("(1) " ++ (show (contar 1 lis)))
    putStrLn ("(2) " ++ (show (contar 2 lis))) 
    putStrLn ("(3) " ++ (show (contar 3 lis)))
    putStrLn ("(4) " ++ (show (contar 4 lis)))
    putStrLn ("(5) " ++ (show (contar 5 lis)))
    putStrLn ("(6) " ++ (show (contar 6 lis)))
    putStrLn ("(7) " ++ (show (contar 7 lis)))
    putStrLn ("(8) " ++ (show (contar 8 lis)))
    putStrLn ("(9) " ++ (show (contar 9 lis)))

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * (factorial (n - 1))

numLista :: Integer -> [Integer]
numLista 0 = []
numLista n = numLista (n `div` 10) ++ [mod n 10]

contar :: Integer -> [Integer] -> Integer
contar _ [] = 0
contar n (x : resto)
    | x == n = 1 + contar n resto
    | otherwise = contar n resto
