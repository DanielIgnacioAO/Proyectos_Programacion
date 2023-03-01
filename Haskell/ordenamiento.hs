------------------------------------------------------
-------------------Ordena una lista-------------------
quickSort::Ord a=>[a]->[a]
quickSort [] = []
quickSort (x:xs) = quickSort(menores) ++ [x] ++ quickSort(mayores)
    where
        menores = [y | y <-xs, y < x]
        mayores = [z | z <-xs, z >= x]
------------------------------------------------------
-------------------Ordena dos listas------------------
merge::Ord a =>[a] ->[a] ->[a]
merge [] l2 = l2
merge l1 [] = l1
merge (x:xs) (y:ys)
    | x<=y = x : merge xs (y:ys)
    | True = y : merge (x:xs) ys
------------------------------------------------------
main = do
    let lista = quickSort ['p','d','g','r','h','s','x','w','l','i','t','y','a','z','e']
    putStrLn (show lista)
    let lista2 = merge [1,3,5,7,9] [2,4,6,8]
    putStrLn (show lista2)
    