{-------------------------
    Programa: bitsElementos.hs
    Funcion: Imprime la lista de subconjuntos 
            del conjunto A = {1..N}, utilizando codigo binario

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
-------------------------}
main = do
    putStrLn "Cuantos bits/elementos?"
    lectura <- getLine
    let num = read lectura :: Int
    let num2 = (2 ^ num) - 1 :: Int
    let lis = listarBinario num2
    impLista 0 lis

listarBinario :: Int -> [[Int]]
listarBinario num = listarBinario3 (listarBinario2 num) (length (binario num))

listarBinario2 :: Int -> [[Int]]
listarBinario2 0 = [binario 0]
listarBinario2 num = (listarBinario2 (num - 1)) ++ [binario num] 

binario :: Int -> [Int]
binario 0 = []
binario num = (binario (div num 2)) ++ [mod num 2]

listarBinario3 :: [[Int]] -> Int -> [[Int]]
listarBinario3 [] _ = []
listarBinario3 (x : resto) max 
    | length x == max = [x] ++ (listarBinario3 resto max)
    | otherwise = [(rellenar x max)] ++ (listarBinario3 resto max)

rellenar :: [Int] -> Int -> [Int]
rellenar bin max
    | length bin == max = bin
    | otherwise = rellenar ([0] ++ bin) max

impLista :: Int -> [[Int]] -> IO()
impLista _ [] = putStrLn ""
impLista con (x : resto) = do
    let conj = subconjuntos x 1
    putStrLn ((show con) ++ " : " ++ (show x) ++ " : { " ++ conj ++ " }")
    impLista (con + 1) resto

subconjuntos :: [Int] -> Int -> String
subconjuntos [] _ = ""
subconjuntos (x : resto) con
    | x == 1 = (show con) ++ subconjuntos resto (con + 1)
    | otherwise = "" ++ subconjuntos resto (con + 1)
