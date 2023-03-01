{-------------------------
    Programa: distancia2D.hs
    Funcion: Acepta 2 puntos 2D, validandolos y 
            calculando la distancia entre ellos

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118 
-------------------------}
import Data.Char
main= do
    putStrLn "Da el punto A (Int, Int): "
    entradaA <- getLine
    putStrLn "Da el punto B (Int, Int): "
    entradaB <- getLine
    if(esPunto2D entradaA && esPunto2D entradaB)
        then do
            putStrLn "Ambos puntos estan bien escritos"
            let 
                pA = coordenadas entradaA
                pB = coordenadas entradaB
                dis = distanciaAB pA pB
            putStrLn $ "pA: " ++ (show pA)
            putStrLn $ "pB: " ++ (show pB)
            putStrLn $ "Distancia entre pA y pB: " ++ (show dis)
        else putStrLn "Hay un error de escritura"
 
esPunto2D cad = verifica cad 0

verifica [] 7 = True
verifica [] _ = False
verifica (x : resto) est
    | and [x == '(', est == 0] = verifica resto 1
    | and [esSigno x, est == 1] = verifica resto 2
    | and [esDigito x, est == 1] = verifica resto 3
    | and [esDigito x, est == 2] = verifica resto 3
    | and [esDigito x, est == 3] = verifica resto 3
    | and [x == ',', est == 3] = verifica resto 4
    | and [esSigno x, est == 4] = verifica resto 5
    | and [esDigito x, est == 4] = verifica resto 6
    | and [esDigito x, est == 5] = verifica resto 6
    | and [esDigito x, est == 6] = verifica resto 6
    | and [x == ')', est == 6] = verifica resto 7
    | otherwise = False

esSigno x = or[x == '+', x == '-']

esDigito x = and[x >= '0', x <= '9']

coordenadas :: String -> [Int]
coordenadas (x : resto)
    | esDigito x = definirNum resto '+' (charToInt x)
    | x == '+' = definirNum resto '+' 0
    | x == '-' = definirNum resto '-' 0
    | otherwise = coordenadas resto

definirNum :: String -> Char -> Int -> [Int]
definirNum (x:resto) sig num
    | esDigito x = definirNum resto sig ((num*10) + (charToInt x))
    | and [x == ',', sig == '+'] = [num] ++ coordenadas resto
    | and [x == ')', sig == '+']= [num]
    | and [x == ',', sig == '-'] = [-1*num] ++ coordenadas resto
    | and [x == ')', sig == '-']= [-1*num]
    | otherwise = []

charToInt :: Char -> Int
charToInt c 
    | c == '0' = 0
    | c == '1' = 1
    | c == '2' = 2
    | c == '3' = 3
    | c == '4' = 4
    | c == '5' = 5
    | c == '6' = 6
    | c == '7' = 7
    | c == '8' = 8
    | c == '9' = 9

distanciaAB :: [Int] -> [Int] -> Double
distanciaAB [x1,y1] [x2,y2] = sqrt ((fromIntegral x2 - fromIntegral x1)^2 + (fromIntegral y2 - fromIntegral y1)^2)