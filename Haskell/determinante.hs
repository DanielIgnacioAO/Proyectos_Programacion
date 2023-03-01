{-------------------------------------------------------------
    Programa: determinante.hs 
    Funcion:  Calculo de determinantes usando permutaciones
--------------------------------------------------------------
    El determinante de una matriz A de NxN es la suma:
    det A = suma ((-1)^nInv(perm) * a1p1 * a2p2 * ... aNpN)
    Los indices deben ajustarse a iniciar en 0
    
    El nInv(perm) es el numero de pares deordenados en la
    permutacion: en 3 1 2 0 los pares (3,1), (3,2), (3,0),
    (1,0) y (2,0) estan desordenados, por lo que nInv = 5
    
    Los productos con su signo para N = 3:
    a00a11a22 permutacion 012 nInv = 0 se suma
    a00a12a21 permutacion 021 nInv = 1 se resta
    a01a10a22 permutacion 102 nInv = 1 se resta
    a01a12a20 permutacion 120 nInv = 2 se suma
    a02a10a21 permutacion 201 nInv = 2 se suma
    a02a11a20 permutacion 210 nInv = 3 se resta
    [[1,2,3],[4,5,6],[7,8,9]]
    [[1,3,3],[4,5,6],[19,18,9]]
    [[1,2,0],[1,-1,3],[-4,-2,4]]
-------------------------------------------------------------}

import Text.Printf
import Data.List

main = do
    putStrLn "Da una matriz cuadrada de enteros: "
    linea <- getLine
    let
        a = read linea :: [[Int]]
        n = length a
        p = permutations [0..(n - 1)]
    putStrLn $ "Dimension de matriz cuadrada: " ++ (show n)
    imprimeRen a 0 n
    putStr $ "Permutaciones de 0 a " ++ (show (n - 1)) ++ ": "
    putStrLn (show p)
    let det = defDeterminante p a
    putStrLn ("Determinante: " ++ (show det))

imprimeRen a rAct limRen
    | rAct == limRen = do
        putStr ""
    | otherwise = do
        imprimeCol a rAct 0 (length (a !! rAct))
        imprimeRen a (rAct + 1) limRen

imprimeCol a rAct cAct limCol
    | cAct == limCol = do
        putStrLn ""
    | otherwise = do
        printf "%6d" ((a !! rAct) !! cAct)
        imprimeCol a rAct (cAct + 1) limCol

defDeterminante :: [[Int]] -> [[Int]] -> Int
defDeterminante [] _ = 0
defDeterminante (xPer : restoPer) mat = do
    (((-1)^(def_nInv xPer)) * (multi 0 xPer mat)) + (defDeterminante restoPer mat)
     

def_nInv :: [Int] -> Int
def_nInv [] = 0
def_nInv (x : resto) = (def_nInv2 x resto) + (def_nInv resto)

def_nInv2 :: Int -> [Int] -> Int
def_nInv2 _ [] = 0
def_nInv2 x (y:resto) 
    | x <= y = 0 + def_nInv2 x resto
    | otherwise = 1 + def_nInv2 x resto

multi :: Int -> [Int] -> [[Int]] -> Int
multi _ [] _ = 1
multi fila (col : resto) mat = ((mat !! fila) !! col) * (multi (fila + 1) resto mat)
