/*
    Programa: trigonometria.pl
        sen x = x - x^3/3! + x^5/5! - x^7/7! + ...
        cos x = 1 - x^2/2! + x^4/4! - x^6/6! + ...
        Predicados para calcular seno y coseno con series
        Imprimir tabla para comprobar sen^2(x) + cos^2(x) = 1
        para valores de x de 0 a 90 grados con incremento de 5 grados
        Los angulos son en radianes
        number_string(NumFor,String),
        
        Nombre: Arellano Ochoa Daniel Ignacio
        No. de control: 19141118
*/
main :-
    % tabla(0,90,5).
     tablaEncabezado(0,90,5).
    % number_string((-23.3),String),string_length(String,X),write(X),write((-23.3)).
    % format(Hol,'~5f',0), write(Hol).
tablaEncabezado(X,N,Inc):-
    write('         X          |'), write('         X          |'),write('       sen(X)       |'), 
    write('       cos(X)       |'), write(' sen^2(X) + cos^2(X)'),nl,
    write('      (grados)      |'), write('     (radianes)     |'),write('     (radianes)     |'), 
    write('     (radianes)     |'), write('     (radianes)     '),nl,
    write('-------------------------------------------------------------------------------------------------------------'),nl,
    tabla(X,N,Inc).
tabla(X,N,_):- X > N, !.
tabla(X,N,Inc):-
    ValorPi is pi,
    Radianes is X*(ValorPi/180),
    imprimirNum(X,20,'~0f'), write('|'), imprimirNum(Radianes,20,'~5f'), write('|'),
    sen(Radianes, Y, 0, 50, Radianes, 1),
    cos(Radianes, Y2, 0, 50, 1, 1),
    imprimirNum(Y,20,'~5f'), write('|'),imprimirNum(Y2,20,'~5f'), write('|'), 
    identidad(Y,Y2,R),
    imprimirNum(R,20,'~5f'),nl,
    write('-------------------------------------------------------------------------------------------------------------'),nl,    
    X2 is X+Inc,
    tabla(X2,N,Inc).   

imprimirNum(Num,Tam, Formato):-
    format(string(String),Formato,Num),
    string_length(String,X),
    TamE is Tam-X,
    centrar(TamE, String).
imprimirEsp(0):- !.
imprimirEsp(Espa):-
    write(' '),
    Espa2 is Espa-1,
    imprimirEsp(Espa2).
centrar(Espa,String):-
    A is Espa mod 2, A = 0, !,
    B is Espa/2,
    imprimirEsp(B),write(String),imprimirEsp(B).
centrar(Espa,String):-
    E is Espa-1,
    A is E/2,
    B is A+1,
    imprimirEsp(A),write(String),imprimirEsp(B).

identidad(Sen, Cos, R):-
    Sen2 is Sen*Sen,
    Cos2 is Cos*Cos,
    R is Sen2 + Cos2.

sen(_, 0, I, N, _, _) :- I > N, !.
sen(X, Y, I, N, Num, Den) :- 
    I1 is I+1, 
    Aux2 is I1*2,
    Aux1 is Aux2+1,
    Num1 is Num*X*X*(-1),
    Den1 is Den*Aux2*Aux1,
    sen(X,Y1,I1,N,Num1,Den1),
    Y is Num/Den + Y1.

cos(_, 0, I, N, _, _) :- I > N, !.
cos(X, Y, I, N, Num, Den) :- 
    I1 is I+1, 
    Aux2 is I1*2,
    Aux1 is Aux2-1,
    Num1 is Num*X*X*(-1),
    Den1 is Den*Aux2*Aux1,
    cos(X,Y1,I1,N,Num1,Den1),
    Y is Num/Den + Y1.