{-------------------------
    Programa: consulta.hs
    Funcion: Permite consultar datos a partir de un archivo con 
            3 palabras clave por oracion/linea

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
-------------------------}
import System.Environment

main = do
    args <- getArgs
    arch <- readFile (args !! 0)
    let lineas = lines arch
    putStrLn "Da tu consulta: "
    lectura <- getLine
    let con = lectura
    analizar con lineas
    
analizar :: String -> [String] -> IO()
analizar _ [] = putStr ""
analizar con (x : resto) = do
    let palaC = words x
    let conC = words con
    respuesta conC palaC
    analizar con resto

respuesta :: [String] -> [String] -> IO()
respuesta conC [x, y, z]
    | and [(respuesta2 conC x) == True, (respuesta2 conC y) == True] = putStrLn ("Respuesta: " ++ z)
    | and [respuesta2 conC x, respuesta2 conC z] = putStrLn ("Respuesta: " ++ y)
    | and [respuesta2 conC y, respuesta2 conC z] = putStrLn ("Respuesta: " ++ x)
    | otherwise = putStr ""
    
respuesta2 :: [String] -> String -> Bool
respuesta2 [] _ = False
respuesta2 (x: resto) palabra 
    | x == palabra = True
    | otherwise = respuesta2 resto palabra