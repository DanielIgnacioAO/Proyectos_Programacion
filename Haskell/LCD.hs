{-------------------------
    Programa: LCD.hs
    Funcion: Programa que al definir tamano y numero, imprime el numero en formato LCD
                del tamano proporcionado 

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
-------------------------}
import Text.Printf
main = do
    printf "Numero: \n"
    lectura <- getLine
    let num = read lectura :: Int
    printf "Tamano: \n"
    lectura2 <- getLine
    let tam = read lectura2 :: Int
    putStrLn (show num)
    pantalla tam num

pantalla :: Int -> Int -> IO()
pantalla tam num = do
    let 
        lista = listarNumero num
        numL = reverse lista
    superior tam numL
    medio_superior tam tam numL
    medio tam numL
    medio_inferior tam tam numL
    base tam numL


listarNumero :: Int -> [Int]
listarNumero num
    | num > 0 = [(mod num 10)] ++ listarNumero (num `div` 10)
    | otherwise = []

superior :: Int -> [Int] -> IO()
superior _ [] = do
    printf "\n"
superior ancho (x : resto)
    | (x == 0 || x == 2 || x == 3 || x == 5 || x == 6 || x == 7 || x == 8 || x == 9) = do 
        printf "  "
        impGuion ancho
        printf "  "
        superior ancho resto
    | otherwise = do --4 1
        printf "  "
        impEspacio ancho
        printf "  "
        superior ancho resto

medio_superior :: Int -> Int -> [Int] -> IO()
medio_superior ancho alto numL
    | alto > 0 = do
        medio_superior2 ancho numL
        medio_superior ancho (alto - 1) numL
    | otherwise = do
        printf ""

medio_superior2 :: Int -> [Int] -> IO()
medio_superior2 _ [] = do
    printf "\n"
medio_superior2 ancho (x : resto)
    | (x == 0 || x == 4 || x == 8 || x == 9) = do 
        printf " |"
        impEspacio ancho
        printf "| "
        medio_superior2 ancho resto
    | (x == 1 || x == 2 || x == 3 || x == 7) = do 
        printf "  "
        impEspacio ancho
        printf "| "
        medio_superior2 ancho resto
    | otherwise = do -- 5 6
        printf " |"
        impEspacio ancho
        printf "  "
        medio_superior2 ancho resto

medio :: Int -> [Int] -> IO()
medio _ [] = do
    printf "\n"
medio ancho (x : resto)
    | (x == 2 || x == 3 || x == 4 || x == 5 || x == 6 || x == 8 || x == 9) = do 
        printf "  "
        impGuion ancho
        printf "  "
        medio ancho resto
    | otherwise = do --0 1 7
        printf "  "
        impEspacio ancho
        printf "  "
        medio ancho resto

medio_inferior :: Int -> Int -> [Int] -> IO()
medio_inferior ancho alto numL
    | alto > 0 = do
        medio_inferior2 ancho numL
        medio_inferior ancho (alto - 1) numL
    | otherwise = do
        printf ""

medio_inferior2 :: Int -> [Int] -> IO()
medio_inferior2 _ [] = do
    printf "\n"
medio_inferior2 ancho (x : resto)
    | (x == 0 || x == 6 || x == 8) = do 
        printf " |"
        impEspacio ancho
        printf "| "
        medio_inferior2 ancho resto
    | (x == 1 || x == 3 || x == 4 || x == 5 || x == 7 || x == 9) = do 
        printf "  "
        impEspacio ancho
        printf "| "
        medio_inferior2 ancho resto
    | otherwise = do -- 2
        printf " |"
        impEspacio ancho
        printf "  "
        medio_inferior2 ancho resto

base :: Int -> [Int] -> IO()
base _ [] = do
    printf "\n"
base ancho (x : resto)
    | (x == 0 || x == 2 || x == 3 || x == 5 || x == 6 || x == 8 || x == 9) = do 
        printf "  "
        impGuion ancho
        printf "  "
        base ancho resto
    | otherwise = do --1 4 7
        printf "  "
        impEspacio ancho
        printf "  "
        base ancho resto

impGuion :: Int -> IO()
impGuion tam
    | tam > 0 = do
        printf "-"
        impGuion (tam - 1)
    | otherwise = do
        printf ""

impEspacio :: Int -> IO()
impEspacio tam
    | tam > 0 = do
        printf " "
        impEspacio (tam - 1)
    | otherwise = do
        printf ""