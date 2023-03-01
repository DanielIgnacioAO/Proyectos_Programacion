{-------------------------
    Programa: rangoPrimos.hs
    Funcion: Determian la cantidad de numeros primos en un rango de dos numeros,
            ademas de calcular el tiempo que tarda en hacerlo.
    
    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118 
-------------------------}
import Data.Time.Clock.POSIX
main = do
    putStrLn("Limite inferior:")
    inf <- getLine
    let limInf = read inf :: Integer
    putStrLn("Limite superior:")
    sup <- getLine
    let limSup = read sup :: Integer

    inicio <- getPOSIXTime
    let totalPri = num_primos limInf limSup
    fin <- getPOSIXTime

    putStrLn("Numero de primos: " ++ (show totalPri))
    let tiempo = fin - inicio
    putStrLn("Segundos empleados: " ++ (show tiempo))

num_primos inf sup = length [x | x <- [inf..sup], esPrimo x == True]

esPrimo n | n < 4 = n /= 1 
esPrimo n = all ((/=0) . mod n) $ takeWhile (<= m) candidates 
        where candidates = (2:3:[x + i | x <- [6,12..], i <- [-1,1]])
              m = floor . sqrt $ fromIntegral n