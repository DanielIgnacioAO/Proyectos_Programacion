{--------------------------------------------
    Programa: factPrimos.hs
    Funcion: Dado n entero mayor a 1, determinar sus factores primos.
    
    Teorema fundamental de la Aritmetica: Todo entero
        mayor a 1 puede expresarse como producto de numeros primos

        100 = 2x2x5x5
        128 = 2^7
        29 = 29

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
---------------------------------------------}
main = do
    putStrLn "Numero: "
    lectura <- getLine
    let 
        n = read lectura :: Int
        lista = factores n 2
    putStrLn $ "Factores primos: " ++ (show lista)

factores 1 _ = []
factores n p 
    | (esPrimo p == True && mod n p == 0) = [p] ++ factores (n `div` p) p 
    | otherwise = factores n (p+1)

esPrimo n = (length [x | x <- [1..n], mod n x == 0]) == 2