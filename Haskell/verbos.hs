{-------------------------
    Programa: verbos.hs
    Funcion: Programa que aprende y almacena conjugaciones verbos regulares e irregulares.

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118 
-------------------------}
import System.Directory
main = do
    putStrLn "Verbo: "
    verbo <- getLine
    buscar verbo

buscar :: String -> IO()
buscar ver = do
    crearFile "regulares.txt"
    archReg <- readFile "regulares.txt"
    let regulares = words archReg
    crearFile "irregulares.txt"
    archIrreg <- readFile "irregulares.txt"
    let irregulares = words archIrreg
    if (ver `elem` regulares)
        then conjuReg ver
        else if (ver `elem` irregulares)
            then conjuIrreg ver (buscarLis ver (lines archIrreg))
        else aprender ver

buscarLis :: String -> [String] -> [String]
buscarLis _ [] = []
buscarLis ver (x : resto)
    | head (words x) == ver = words x
    | otherwise = buscarLis ver resto

conjuReg :: String -> IO()
conjuReg ver = do  
    putStrLn ("Verbo: " ++ ver)
    let raiz = init (init ver)
    let vocal = last (init ver)
    putStrLn ("Yo:          " ++ raiz ++ "o")
    putStrLn ("Tu:          " ++ raiz ++ [vocal] ++ "s")
    putStrLn ("El/Ella:     " ++ raiz ++ [vocal])
    putStrLn ("Nosotros:    " ++ raiz ++ [vocal] ++ "mos")
    putStrLn ("Ustedes:     " ++ raiz ++ [vocal] ++ "n")
    putStrLn ("Ellos:       " ++ raiz ++ [vocal] ++ "n")

conjuIrreg :: String -> [String] -> IO()
conjuIrreg ver (verbo : yo : tu : el_ella : nos : ust : ell : x) = do
    putStrLn ("Verbo: " ++ verbo)
    putStrLn ("Yo:          " ++ yo)
    putStrLn ("Tu:          " ++ tu)
    putStrLn ("El/Ella:     " ++ el_ella)
    putStrLn ("Nosotros:    " ++ nos)
    putStrLn ("Ustedes:     " ++ ust)
    putStrLn ("Ellos:       " ++ ell)

aprender :: String -> IO()
aprender ver = do
    conjuReg ver
    putStrLn ("Se conjuga de esta manera?(si/no) ")
    res <- getLine
    if (res == "si")
        then aprenReg ver
        else aprenIrreg ver

aprenReg :: String -> IO()
aprenReg ver = do
    let file = "regulares.txt"
    appendFile file (ver ++ "\n")
    putStrLn ("Verbo regular aprendido")

aprenIrreg :: String -> IO()
aprenIrreg ver = do
    putStrLn ("Por favor muestrame como se conjuga:")
    putStrLn ("Yo: ")
    yo <- getLine
    putStrLn ("Tu: ")
    tu <- getLine
    putStrLn ("El/Ella: ")
    el_ella <- getLine
    putStrLn ("Nosotros: ")
    nos <- getLine
    putStrLn ("Ustedes: ")
    ust <- getLine
    putStrLn ("Ellos: ")
    ell <- getLine
    let conjugacion = ver ++ " " ++ yo ++ " " ++ tu ++ " " ++ el_ella ++ " " ++ nos ++ " " ++ ust ++ " " ++ ell ++ "\n"
    let file = "irregulares.txt"
    appendFile file conjugacion
    putStrLn ("Verbo irregular aprendido")

crearFile :: String -> IO()
crearFile dir = do
    a <- doesFileExist dir
    if(a)
        then putStr ("")
        else do 
            let file = dir
            writeFile file ""