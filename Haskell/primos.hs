-- primos.hs: Determinar si n es primo

main = do
    putStrLn  "n: "
    entrada <- getLine
    let
        n = read entrada :: Int
        r = esPrimo n
    putStrLn $ "Es primo? " ++ (show r)

esPrimo n = (length [x | x <- [1..n], mod n x == 0]) == 2

