{-------------------------
    Programa: LlavesPriv.hs
    Funcion: Programa que a partir de un numero (clave publica), genera una clave privada
            a partir del numero bipartita de la clave publica y genera a la vez la clave 
            compacta a partir de la clave privada en el formato M X N Y, donde:
            X: Primer digito diferente del numero bipartita
            M: Cantidad del digito X del numero bipartita 
            Y: Segundo digito diferente del numero bipartita
            N: Cantidad del digito Y del numero bipartita 

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
-------------------------}
main = do
    putStrLn "Escribe la clave publica: "
    lectura <- getLine
    let num = read lectura :: Int
    let claNum = clave num 2
    let claCom = compactar claNum
    putStrLn ("Clave Publica: " ++ (show num))
    putStr "     Clave Privada: "
    impList claNum
    putStr "     Clave Compacta: "
    impList claCom
    

clave :: Int -> Int -> [Int]
clave pub cont = do
    let multiplo = cont*pub :: Int
    let lista1 = listarNumero multiplo
    let lista = reverse lista1
    if( bipartita lista )
        then lista
        else clave pub (cont + 1)

         
listarNumero :: Int -> [Int]
listarNumero num
    | num > 0 = [(mod num 10)] ++ listarNumero (num `div` 10)
    | otherwise = []

bipartita :: [Int] -> Bool
bipartita lista = do
    let 
        x = head lista
        lista2 = bipartita2 lista x 
        y = head lista2
        lista3 = bipartita2 lista2 y
    if(null lista3)
        then True
        else False

bipartita2 :: [Int] -> Int -> [Int]
bipartita2 [] _ = []
bipartita2 (y : resto) x 
    | y == x = bipartita2 resto x
    | otherwise = (y : resto)

compactar :: [Int] -> [Int]
compactar lista = do
    let
        x = head lista
        y = last lista
        auxx = quitarElemento lista y
        auxy = quitarElemento lista x
        m = length auxx
        n = length auxy
    [m,x,n,y]

quitarElemento :: (Eq a) => [a] -> a -> [a]
quitarElemento l n = [ x | x <- l , x /= n]

impList :: [Int] -> IO()
impList [] = putStrLn ""
impList (x : resto)= do
    putStr (show x) 
    impList resto