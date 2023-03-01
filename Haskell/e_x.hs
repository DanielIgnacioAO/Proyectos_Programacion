{-------------------------
    Programa: e_x.hs
    Funcion: Calcular e a la x con serie de Taylor

    e^x = 1 + x + x^2/2! + x^3/3! + ...

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
-------------------------}

main = do      
    putStrLn "x: "
    entradaX <- getLine
    putStrLn "n: "
    entradaN <- getLine
    let x = read entradaX :: Double
    let n = read entradaN :: Double
    let e = exponencial x n
    putStr $ "El resultado de e^" ++ (show x)
    putStrLn $ " es " ++ (show e)


factorial 0 = 1
factorial n = n * (factorial (n - 1))

exponencial x 0 = 1
exponencial x n = (exponencial x (n-1)) + ((x**n)/(factorial n))