{-------------------------
    Programa: triPascal.hs
    Funcion: Construye el triangulo de Pascal: 
            conformado por numeros, creado a partir de la serie C(n,r) = n!/r!/(n-r)!
            
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
            putStrLn "Triangulo de Pascal"
            pascalCombi 0 15
        else do
            let num = read (Prelude.head args) :: Double
            putStrLn "Triangulo de Pascal"
            pascalCombi 0 num
----------------------------------- 
pascalCombi :: Double -> Double -> IO()
pascalCombi n m 
    | n > m = putStrLn ""
    | otherwise = do 
        putStrLn ""
        pasCombRen n 0
        pascalCombi (n + 1) m

pasCombRen :: Double -> Double -> IO()
pasCombRen n r 
    | r > n = putStr ""
    | otherwise = do
        let c = (factorial n) / (factorial r) / (factorial (n - r))
        printf "%4.0f " c
        pasCombRen n (r + 1)

factorial 0 = 1
factorial n = n * (factorial (n - 1))
