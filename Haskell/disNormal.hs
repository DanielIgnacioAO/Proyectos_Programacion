{-------------------------
    Programa: disNormal.hs
    Funcion: Muestra la tabla de distribuicion Normal, ocupando printf

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
-------------------------}
import Data.Text
import Text.Printf
main = do
    printf "Tabla de distribuicion normal estandar:\n"
    printf " z  |  0.00    0.01    0.02    0.03    0.04    0.05    0.06    0.07    0.08    0.09 "
    printf "\n------------------------------------------------------------------------------------"
    tabla 0 10

tabla :: Float -> Float -> IO()
tabla zf zc = 
    if(zf == 400 && zc == 10)
        then do
            printf ""
        else if(zc == 10)
            then do 
                let
                    zf2 = zf + 10 :: Float
                    zc2 = 0 :: Float
                    aux = zf2 / 100 :: Float
                --printf "\n-------------------------------------------------------------------------------------------------"
                printf "\n%.1f |" aux
                tabla zf2 zc2
        else do
            let
                z = (zf + zc) / 100 :: Float
                base = z / 1000 :: Float
                area = suma 0 base 0 1000
                zc2 = zc + 1 :: Float
            --printf " | "
            printf " %.4f " area 
            tabla zf zc2

suma :: Float -> Float -> Float -> Float -> Float
suma a base i n 
    | i==n = 0.0
    | otherwise = do
        let
            area1 = suma a base (i + 1) n 
            x1 = a + i*base 
            x2 = x1 + base 
            y1 = funx x1
            y2 = funx x2 
            y = (y1 + y2) / 2 
        base*y + area1 

funx :: Float -> Float
funx x  = (exp (-x*x/2)) / (sqrt (2*pi)) 



