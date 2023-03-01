{-------------------------
    Programa: particionesNum.hs
    Funcion: Imprime las particiones de N numero 
            (diferentes maneras de sumar numero enteros positivos para obtener N)

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118 
-------------------------}
main = do
    putStrLn "N= "
    lectura <- getLine
    let num = read lectura :: Int
    let p = particiones [] num num 0
    impLista p

particiones :: [Int] -> Int -> Int -> Int-> [[Int]]
particiones raiz _ 0 0 = [raiz ++ []]
particiones raiz _ 1 0 = [raiz ++ [1]]
particiones raiz _ 1 1 = [raiz ++ [1,1]]
particiones [] n 1 _ = [take n (repeat 1) ]
particiones raiz n 1 _ = [raiz ++ take (n - (sum raiz)) (repeat 1)]
particiones [] n p q 
    | and[p >= q, p + q == n, p == 2, q == 1] = (particiones [p] n q 0) ++ (particiones [1] n 1 1)
    | and[p >= q, p + q == n] = (particiones [p] n q 0) ++ (particiones [] n (p - 1) (q + 1))
    | and[p >= q, p + q < n] = (particiones [p] n q (n - p - q)) ++ (particiones [] n (p - 1) (q + 1))
    | and[p < q] = particiones [] n p p
particiones raiz n p q
    | and[p >= q, (sum raiz) + p + q == n, p == 2, q == 1] = (particiones (raiz ++ [p]) n q 0) ++ (particiones (raiz ++ [1]) n 1 1)
    | and[p >= q, (sum raiz) + p + q == n] = (particiones (raiz ++ [p]) n q 0) ++ (particiones raiz n (p - 1) (q + 1))
    | and[p >= q, (sum raiz) + p + q < n] = (particiones (raiz ++ [p]) n q (n - p - q - (sum raiz))) ++ (particiones raiz n (p - 1) (q + 1))
    | and[p < q] = particiones raiz n p p

impLista :: [[Int]] -> IO()
impLista [] = putStrLn ""
impLista (x : resto) = do
    putStrLn (show x)
    impLista resto