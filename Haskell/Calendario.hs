{-------------------------
    Programa: Calendario.hs
    Funcion: Imprime el calendario de x anio

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
-------------------------}
import Text.Printf
main = do
    printf "Bienvenido, que calendario desea? \n"
    lectura <- getLine
    let 
        a = read lectura :: Int
        d = diaInicial a
    impMes 1 d a

diaInicial :: Int -> Int
diaInicial a = primerDia a 2022 6

primerDia :: Int -> Int -> Int -> Int
primerDia a aActual dActual 
    | (a == aActual) = dActual
    | ((a > aActual) && ((esBisiesto aActual) == True)) = primerDia a (aActual + 1) (mod (dActual + 2) 7)
    | ((a > aActual) && ((esBisiesto aActual) == False)) = primerDia a (aActual + 1) (mod (dActual + 1) 7)
    | ((a < aActual) && ((esBisiesto (aActual - 1)) == True)) = primerDia a (aActual - 1) (mod (dActual - 2) 7)
    | ((a < aActual) && ((esBisiesto (aActual - 1)) == False)) = primerDia a (aActual - 1) (mod (dActual - 1) 7)
    | otherwise = 0
  
esBisiesto :: Int -> Bool
esBisiesto a 
    | ((mod a 4 == 0) && (mod a 100 == 0) && (mod a 400 == 0)) = True
    | ((mod a 4 == 0) && (mod a 100 /= 0)) = True
    | otherwise = False

impMes :: Int -> Int -> Int -> IO()
impMes mes d a 
    | (mes == 12) = do 
        impEncabezado a mes d
        impSemana d 1 31
    | (mes == 1 || mes == 3 || mes == 5 || mes == 7 || mes == 8 || mes == 10) = do
        impEncabezado a mes d
        impSemana d 1 31
        impMes (mes + 1) (mod (d + 31) 7) a
    | (mes == 4 || mes == 6 || mes == 9 || mes == 11) = do
        impEncabezado a mes d
        impSemana d 1 30
        impMes (mes + 1) (mod (d + 30) 7) a
    | otherwise = do
        impEncabezado a mes d
        if(esBisiesto a)
            then do
                impSemana d 1 29
                impMes (mes + 1) (mod (d + 29) 7) a
            else do
                impSemana d 1 28
                impMes (mes + 1) (mod (d + 28) 7) a
    
impEncabezado :: Int -> Int ->  Int -> IO()
impEncabezado a mes dInicio = do
    let mesLetra = nombreMes mes
    printf "%s de %d \n D  L Ma Mi  J  V  S \n" mesLetra a
    impEspacios dInicio

impEspacios :: Int -> IO()
impEspacios dInicio
    | dInicio > 0 = do
        printf "   "
        impEspacios (dInicio - 1)
    | otherwise = printf ""

impSemana :: Int -> Int -> Int -> IO()
impSemana dActual fechaCon lim 
    | (lim > 0 && dActual == 6) = do
        impDia fechaCon 
        printf "\n"
        impSemana 0 (fechaCon + 1) (lim - 1)
    | (lim > 0 && dActual /= 6) = do 
        impDia fechaCon 
        printf " "
        impSemana (dActual + 1) (fechaCon + 1) (lim - 1)
    | otherwise = printf "\n \n"

impDia :: Int -> IO()
impDia fechaCon
    | fechaCon > 9 = printf "%d" fechaCon
    | otherwise = printf " %d" fechaCon

nombreMes :: Int -> String
nombreMes mes = nombreMes2 mes ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]

nombreMes2 :: Int -> [String] -> String
nombreMes2 mes (x : resto) 
    | mes == 1 = x
    | otherwise = nombreMes2 (mes - 1) resto