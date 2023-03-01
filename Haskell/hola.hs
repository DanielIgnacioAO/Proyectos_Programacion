-- hola.hs: Imprimir saludo

{- 
    Programa: hola.hs
    Funcion: Imprimir saludo

-}

main = do
    putStr "Hola, "
    putStrLn "mundo!"
    putStrLn "I T Q"
    iteraHola 1 10

iteraHola i n
    | i <= n = do
        putStrLn $ "Hola " ++ (show i)
        iteraHola (i + 1) n
    | otherwise = do
        putStr ""