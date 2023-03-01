{-----------------
    Programa: listaEnteros.hs
    Funcion: Parametros de una lista no vacia de enteros
---------------}

main = do
    putStrLn "Da una lista no vacia de enteros"
    entrada <- getLine
    let
        lista = read entrada :: [Int]
        n = longitud lista
        max = mayor lista
        min = menor lista
        acum = suma lista
        prom = (fromIntegral acum) / (fromIntegral n)
    putStrLn $ "Numero de elementos: " ++ (show n)
    putStrLn $ "Mayor valor: " ++ (show max)
    putStrLn $ "Menor valor: " ++ (show min)
    putStrLn $ "Acumulado: " ++ (show acum)
    putStrLn $ "Promedio: " ++ (show prom)

longitud [] = 0
longitud (_ : resto) = 1 + (longitud resto)

mayor [x] = x
mayor (x : resto)
    | x >= (mayor resto) = x
    | otherwise = mayor resto

menor [x] = x
menor (x : resto)
    | x <= (menor resto) = x
    | otherwise = menor resto

suma [] = 0
suma (x : resto) = x + (suma resto)