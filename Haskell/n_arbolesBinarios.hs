{-------------------------
    Programa: n_arbolesBinarios.hs
    Funcion: Cuenta el numero de formas que puede tener un arbol binario
            con N nodos

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118 
-------------------------}
main = do
    putStrLn "Cuantos nodos? "
    nodos <- getLine
    let n = read nodos :: Int
    let m = contar n
    putStrLn ("Arboles con " ++ (show n) ++ " nodos: " ++ (show m))

contar :: Int -> Int
contar n 
    | (n - 1) >= 2 = contar2 (n - 1) 0
    | (n - 1) == 1 = 2
    | (n - 1) == 0 = 1
    | n == 0 = 0

contar2 :: Int -> Int -> Int
contar2 n m 
    | n == 0 = (contar m)
    | m == 0 = (contar n) + contar2 (n - 1) (m + 1)
    | otherwise =  (contar n) * (contar m) + contar2 (n - 1) (m + 1)