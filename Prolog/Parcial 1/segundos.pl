/*****************************************************
    Programa: Segundos.pl
    Funcion: Leer segundos desde 1970.01.01
             En GreenWich
    Tarea: A partir del numero de segundos realiza 
    las operaciones para recuperar fecha y hora

    stamp_date_time(X, FechaHora,21600),
    write(FechaHora), nl,
*****************************************************/
main:- 
    get_time(X),
    Z is truncate(X),
    Z2 is Z-21600,

    minutes(Z2,M,Seg_Res),
    hours(M,H,Min_Res),
    days(H,D,Ho_Res),

    years(D,1970,Y,R_Year),
    meses(R_Year,Y,1,Month,R_Month),

    write('Fecha: '), write(Y), write('.'), write(Month), write('.'), write(R_Month), nl,
    write('Hora: '), write(Ho_Res), write(':'), write(Min_Res), write(':'), write(Seg_Res), nl.

minutes(X,M,R) :-
    A is X/60,
    M is truncate(A),
    R is X mod 60.

hours(X,H,R) :-
    A is X/60,
    H is truncate(A),
    R is X mod 60.

days(X,D,R) :-
    A is X/24,
    D is truncate(A),
    R is X mod 24.
    
years(X,I,Y,R):-
    A is I mod 4, A = 0, !, 
    B is X, B >=366, !,
    X2 is X-366,
    I2 is I+1,
    years(X2,I2,Y2,R2),
    Y is Y2+1,
    R is R2.

years(X,I,Y,R):-
    B is X, B >=365, !,
    X2 is X-365,
    I2 is I+1,
    years(X2,I2,Y2,R2),
    Y is Y2+1,
    R is R2.


years(X,I,Y,R):- 
    C is X, C < 365, !,
    D is I, D > 1969, !,
    Y is 1970,
    R is C+1.

meses(Dias_Res,Y_Actual,Con,Month,Res_Mes):- 
    ((Con = 1; Con = 3; Con = 5; Con = 7; Con = 8; Con = 10; Con = 12) , (Dias_Res >= 31)) ->
        Dias_Res2 is Dias_Res-31,
        Con2 is Con+1,
        meses(Dias_Res2,Y_Actual,Con2,Month2,Res_Mes2),
        Res_Mes is Res_Mes2,
        Month is Month2+1
    ;((Con = 4; Con = 6; Con = 9; Con = 11) , (Dias_Res >= 31)) ->
        Dias_Res2 is Dias_Res-30,
        Con2 is Con+1,
        meses(Dias_Res2,Y_Actual,Con2,Month2,Res_Mes2),
        Res_Mes is Res_Mes2,
        Month is Month2+1
    ;((Con = 2 , A is Y_Actual mod 4, A = 0) , (Dias_Res >= 29)) ->
        Dias_Res2 is Dias_Res-29,
        Con2 is Con+1,
        meses(Dias_Res2,Y_Actual,Con2,Month2,Res_Mes2),
        Res_Mes is Res_Mes2,
        Month is Month2+1
    ;((Con = 2 , A is Y_Actual mod 4, A \= 0) , (Dias_Res >= 28)) ->
        Dias_Res2 is Dias_Res-28,
        Con2 is Con+1,
        meses(Dias_Res2,Y_Actual,Con2,Month2,Res_Mes2),
        Res_Mes is Res_Mes2,
        Month is Month2+1
    ;Month is 1,Res_Mes is Dias_Res.


    
    
    
