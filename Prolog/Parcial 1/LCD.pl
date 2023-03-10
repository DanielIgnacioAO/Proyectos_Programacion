/*

*/
main:-
  write("Numero: "),
  read(Num),
  lcd(Num,2).


lcd(Num, A):-
    segmento1(Num,A),nl,
    repetir1(1,A,Num),
    segmento2(Num,A),nl,
    repetir2(1,A,Num),
    segmento3(Num,A),!.

repetir1(C,A,_):-
    C>A,!.
repetir1(C,A,Num):-
    segFB(Num,A),nl,
    C1 is C+1,
    repetir1(C1,A,Num).

repetir2(C,A,_):-
    C>A,!.
repetir2(C,A,Num):-
    segEC(Num,A),nl,
    C1 is C+1,
    repetir2(C1,A,Num).

segmento1(Num,A):-
    S is Num mod 10,
    T is Num div 10,
    T \= 0,!,
    segmento1(T,A),
    horizon(S,[1,0,1,1,0,1,1,1,1,1],A).
segmento1(Num,A):-
    horizon(Num,[1,0,1,1,0,1,1,1,1,1],A).

segFB(Num,A):-
    S is Num mod 10,
    T is Num div 10,
    T \= 0,!,
    segFB(T,A),
    vertical(S,[1,0,0,0,1,1,1,0,1,1]),
    generaEspacio(1,A),
    vertical(S,[1,1,1,1,1,0,0,1,1,1]),
    write(" ").
segFB(Num,A):-
    vertical(Num,[1,0,0,0,1,1,1,0,1,1]),
    generaEspacio(1,A),
    vertical(Num,[1,1,1,1,1,0,0,1,1,1]),
    write(" ").

segmento2(Num,A):-
    R is Num mod 10,
    Q is Num div 10,
    Q \= 0,!,
    segmento2(Q,A),
    horizon(R,[0,0,1,1,1,1,1,0,1,1],A).
segmento2(Num,A):-
    horizon(Num,[0,0,1,1,1,1,1,0,1,1],A).

segEC(Num,A):-
    S is Num mod 10,
    T is Num div 10,
    T \= 0,!,
    segEC(T,A),
    vertical(S,[1,0,1,0,0,0,1,0,1,0]),
    generaEspacio(1,A),
    vertical(S,[1,1,0,1,1,1,1,1,1,1]),
    write(" ").
segEC(Num,A):-
    vertical(Num,[1,0,1,0,0,0,1,0,1,0]),
    generaEspacio(1,A),
    vertical(Num,[1,1,0,1,1,1,1,1,1,1]),
    write(" ").

segmento3(Num,A):-
    R is Num mod 10,
    Q is Num div 10,
    Q \= 0,!,
    segmento3(Q,A),
    horizon(R,[1,0,1,1,0,1,1,0,1,0],A).
segmento3(Num,A):-
    horizon(Num,[1,0,1,1,0,1,1,0,1,0],A).

horizon(0,[1|_],A):-
    write(" "),
    generaGuion(1,A),
    write("  ").
horizon(0,[0|_],A):-
    write(" "),
    generaEspacio(1,A),
    write("  ").
horizon(Num,[_|Resto],A):-
    N1 is Num-1,
    horizon(N1,Resto,A).

vertical(0,[1|_]):-
    write("/").
vertical(0,[0|_]):-
    write(" ").
vertical(Num,[_|Resto]):-
    N1 is Num-1,
    vertical(N1,Resto).

generaGuion(C,A):-
    C>A,!.
generaGuion(C,A):-
    C1 is C+1,
    write("-"),
    generaGuion(C1,A).

generaEspacio(C,A):-
    C>A,!.
generaEspacio(C,A):-
    C1 is C+1,
    write(" "),
    generaEspacio(C1,A).
