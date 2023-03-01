import Data.List
main = do
    let a = [1,2,3] :: [Int]
    let b = take 10 (repeat 1)
    --let c = a + 4 :: [Int]
    putStrLn (show b)
    --putStrLn (show c)