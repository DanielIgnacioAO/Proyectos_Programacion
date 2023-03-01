{-------------------------
    Programa: FBF.hs
    Funcion: Determina si una expresion es una Formula Bien Formada
            para despues pasarla a postFija

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
-------------------------}
main = do
    putStrLn "Formula: "
    entrada <- getLine
    let a = esBienFormada entrada
    if(a)
        then do 
            putStrLn $ "Bien Formada? " ++ (show a)
            let b = posFija [entrada, ""]
            putStrLn $ "Expresion posFija: " ++ b
        else do
            putStrLn $ "Bien Formada? " ++ (show a)


esBienFormada cad = validar cad 0 0

validar [] 6 0 = True
validar [] 8 0 = True
validar [] _ _ = False
validar (x:resto) est conP 
    | and[x == '(', est == 0] = validar resto 1 (conP + 1)
    | and[esLetra x, est == 0] = validar resto 8 conP
    | and[x == '(', est == 1] = validar resto 1 (conP + 1)
    | and[esLetra x, est == 1] = validar resto 2 conP
    | and[x == '-', est == 1] = validar resto 4 conP
    | and[esOperador x, est == 2] = validar resto 3 conP
    | and[x == '(', est == 3] = validar resto 1 (conP + 1)
    | and[esLetra x, est == 3] = validar resto 5 conP
    | and[esLetra x, est == 4] = validar resto 5 conP
    | and[x == ')', est == 5] = validar resto 6 (conP - 1)
    | and[esOperador x, est == 6] = validar resto 7 conP
    | and[x == ')', est == 6] = validar resto 6 (conP - 1)
    | and[esLetra x, est == 7] = validar resto 9 conP
    | and[x == '(', est == 7] = validar resto 1 (conP + 1)
    | and[x == ')', est == 9] = validar resto 6 (conP - 1)
    | otherwise = False

esLetra x = and[x >= 'a', x <= 'z']

esOperador x = or[x == '+', x == '-', x == '*', x == '/', x == '%']
 ---------------------------------------------------------------------------------
posFija :: [String] -> String
posFija [[],[]] = ""
posFija [[], (y : restoP)] = [y] ++ posFija [[], restoP]
posFija [(x : restoE), pila]
    | esLetra x = [x] ++ (posFija [restoE, pila])
    | x == ')' = posFija2 [restoE, pila] ""
    | otherwise = posFija3 [(x : restoE), pila]

posFija2 :: [String] -> String -> String
posFija2 [expresion,[]] aux = aux ++ posFija [expresion, []] 
posFija2 [expresion, (y : restoP)] aux
    | y == '(' = aux ++ posFija [expresion, restoP]
    | otherwise = posFija2 [expresion, restoP] (aux ++ [y]) 

posFija3 :: [String] -> String
posFija3 [(x : restoE), []] = posFija [restoE, [x]]
posFija3 [(x : restoE), (y : restoP)]
    | prioridades x y == True = posFija [restoE, ([x] ++ [y] ++ restoP)]
    | otherwise = [y] ++ posFija3 [(x : restoE), restoP]

prioridades :: Char -> Char -> Bool
prioridades entra enPila = 
    prioridades2 (detPriEnt entra) (detPriSal enPila)

prioridades2 :: Int -> Int -> Bool
prioridades2 ent pil
    | ent > pil = True
    | otherwise = False

--priEnt = [2, 1, 3]
--         */% +- (
--priSal = [2, 1, 0]
--         */% +- (
detPriEnt :: Char -> Int
detPriEnt x 
    | or[x == '*', x == '/', x == '%'] = 2
    | or[x == '+', x == '-'] = 1
    | x == '(' = 3

detPriSal :: Char -> Int
detPriSal x 
    | or[x == '*', x == '/', x == '%'] = 2
    | or[x == '+', x == '-'] = 1
    | x == '(' = 0
