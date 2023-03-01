{-------------------------
    Programa: lineaCMD.hs
    Funcion: Obtener argumentos en linea de comando

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
-------------------------}
import System.Environment
main = do
    args <- getArgs
    imprimeArgs args 0 (length args)

imprimeArgs args i n
    | i < n = do
        putStrLn $ (show i) ++ ": " ++ (args !! i)
        imprimeArgs args (i + 1) n
    | otherwise = do 
        putStr ""