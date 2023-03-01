{---------------------
    Programa: factorial.hs
    Funcion: Calcular factoriales
---------------------}

main = do
    putStrLn "n: "
    entrada <- getLine
    let n = read entrada :: Integer
    let f = factorial n
    putStr $ "El factorial de " ++ (show n)
    putStrLn $ " es " ++ (show f)

factorial 0 = 1
factorial n = n * (factorial (n - 1))
