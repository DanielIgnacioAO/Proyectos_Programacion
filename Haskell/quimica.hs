{--------------------------------------------
    Programa: quimica.hs
    Funcion: Dado el simbolo quimico o nombre del elemento, sera imprimido 
            su respectiva configuracion electronica
    
    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
---------------------------------------------}
import System.Environment
import Data.Char

nombre = ["hidrogeno","helio","litio","berilio","boro","carbono","nitrogeno","oxigeno","fluor","neon","sodio","magnesio","aluminio","silicio","fosforo","azufre","cloro","argon","potasio","calcio","escandio","titanio","vanadio","cromo","manganeso","hierro","cobalto","niquel","cobre","zinc","galio","germanio","arsenico","selenio","bromo","kripton","rubidio","estroncio","itrio","zirconio","niobio","molibdeno","tecnecio","rutencio","rodio","paladio","plata","cadmio","indio","estanyo","antimonio","telurio","yodo","xenon","cesio","bario","lantano","cerio","prasesodimio","neodimio","prometio","samario","europio","gadolinio","terbio","disprosio","hoimio","erbio","tulio","iterbio","lutecio","hafnio","tantalio","wolframio","renio","osmio","iridio","platino","oro","mercurio","talio","plomo","bismuto","polonio","astato","radion","francio","radio","actinio","torio","proactinio","uranio","plutonio","americio","curio","berkelio","californio","einstenio","fermio","nobelio","laurencio","rutherfordio","dubnio","seaborgio","bohrio","hassio","meitnerio","damstatio","roentgenio","copernicio","nihonio","flerovio","moscovio","livermorio","teneso","oganeson"] ::[String]
simbolo = ["H","He","Li","Be","B","C","N","O","F","Ne","Na","Mg","Al","Si","P","S","Cl","Ar","K","Ca","Sc","Ti","V","Cr","Mn","Fe","Co","Ni","Cu","Za","Ga","Ge","As","Se","Br","Kr","Rb","Sr","Y","Zr","Nb","Mo","Tc","Ru","Rh","Pd","Ag","Cd","In","Sn","Sb","Te","I","Xe","Cs","Ba","La","Ce","Pr","Nd","Pm","Sm","Eu","Gd","Tb","Dy","Ho","Er","Tm","Yb","Lu","Hf","Ta","W","Re","Os","Ir","Pt","Au","Hg","Tl","Pb","Bi","Po","At","Rn","Fr","Ra","Ac","Th","Pa","U","Np","Pu","Am","Cm","Bk","Cf","Es","Fm","Md","No","Lr","Rf","Db","Sg","Bh","Hs","Mt","Ds","Rg","Cn","Nh","Fl","Mc","Lv","Ts","Og"] :: [String]
electrones = [2, 2, 6, 2, 6, 2, 10, 6, 2, 10, 6, 2, 14, 10, 6, 2, 14, 10, 6]
elecConfig = ["1s^","2s^","2p^","3s^","3p^","4s^","3d^","4p^","5s^","4d^","5p^","6s^","4f^","5d^","6p^","7s^","5f^","6d^","7p^"]
main = do
    putStrLn $ "Elemento: "
    e <- getLine
    let
        limite = length nombre :: Int
        elem   = ajusta e 
    buscarE elem e nombre simbolo 0

ajusta [] = []
ajusta (x:resto)
    | isAlphaNum x = [toLower x] ++ ajusta resto
    | otherwise = ajusta resto

bucarE _ _ [] [] _ = do
    putStrLn ""
buscarE e s (x:resto1) (y:resto2) cont = do
    if(e == x || s == y)
        then do
            putStrLn $ "Su elemento es: " ++ x ++ " = " ++ y
            putStrLn $ "Su numero atomico es: " ++ (show (cont+1))
            putStr "Configuracion electronica: "
            configElec ( cont + 1 ) electrones elecConfig
        else do
            buscarE e s resto1 resto2 (cont+1)

configElec 0 _ _ = do
    putStrLn ""
configElec n (x:resto1) (y:resto2) = do
    if( n >= x )
        then do
            putStr $ y ++ (show x) ++ " "
            configElec (n-x) resto1 resto2
        else if(n < x )
            then do
                putStr $ y ++ (show n) ++ " "
                configElec 0 resto1 resto2
        else do
            putStrLn "" 