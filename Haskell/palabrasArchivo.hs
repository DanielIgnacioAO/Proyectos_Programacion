{-------------------------
    Programa: palabrasArchivo.hs
    Funcion: Indica las palabras que aparecen en un archivo de
            texto y el numero de veces que aparecen.

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
-------------------------}
import System.Environment
import Data.Char
import Data.List

main = do
    args <- getArgs
    arch <- readFile (args !! 0)
    let palabras = words arch
    analizar palabras

analizar :: [String] -> IO()
analizar palabras = do
    let lista = quickSort (nub palabras) --nub elimina elementos repetidos 
    let numeros = contar lista palabras
    imprimir lista numeros

imprimir :: [String] -> [Int] -> IO()
imprimir [] [] = putStrLn ""
imprimir (pal : restoP) (num : restoN) = do
    putStrLn ((pal) ++ ": " ++ (show num))
    imprimir restoP restoN

contar :: [String] -> [String] -> [Int]
contar [] _ = []
contar (x : resto) texto = [(contar2 x texto)] ++ contar resto texto

contar2 :: String -> [String] -> Int
contar2 _ [] = 0
contar2 palabra (y : resto) 
    | palabra == y = 1 + (contar2 palabra resto)
    | otherwise = (contar2 palabra resto)

-------------------Ordena una lista-------------------
quickSort::Ord a=>[a]->[a]
quickSort [] = []
quickSort (x:xs) = quickSort(menores) ++ [x] ++ quickSort(mayores)
    where
        menores = [y | y <-xs, y < x]
        mayores = [z | z <-xs, z >= x]