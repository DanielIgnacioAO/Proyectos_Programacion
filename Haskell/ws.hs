{-------------------------
    Programa: ws.hs
    Funcion: Contar lineas, palabras y caracteres en archivo de texto

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
-------------------------}
import System.Environment

main = do
    args <- getArgs
    arch <- readFile (args !! 0)
    let
        lineas = lines arch
        palabras = words arch
        nLineas = length lineas 
        nPalabras = length palabras
        nCaracteres = length arch
    putStrLn $ "Lineas:     " ++ (show nLineas)
    putStrLn $ "Palabras:     " ++ (show nPalabras)
    putStrLn $ "Caracteres:     " ++ (show nCaracteres)   