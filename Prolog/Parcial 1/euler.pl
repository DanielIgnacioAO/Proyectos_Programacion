/*
    Programa: euler.pl
        e a la x = 1 + x + x^2/2! + x^3/3! + ...
        ------------------------------------------
        sen x = x - x^3/3! + x^5/5! - x^7/7! + ...
        cos x = 1 - x^2/2! + x^4/4! - x^6/6! + ...
        Predicados para calcular seno y coseno con series
        Imprimir tabla para comprobar sen^2(x) + cos^2(x) = 1
        para valores de x de 0 a 90 grados con incremento de 5 grados
*/
main :-
    write('x: '), read(X),
    euler(X,Y,0,50,1,1),
    write(' e a la '), write(X),
    write(' = '), write(Y), nl.

euler(_, 0, I, N,_ ,_ ) :- I > N, !.
euler(X,Y,I,N,Num,Den) :-
    I1 is I+1,
    Num1 is Num*X,
    Den1 is Den*I1,
    euler(X,Y1,I1,N,Num1,Den1),
    Y is Num/Den + Y1.