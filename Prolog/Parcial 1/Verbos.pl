/*************************************
    Programa: Verbos.pl
    Descripcion: Programa que aprende y almacena conjugaciones verbos regulares e irregulares.
    
    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
***************************************/
main:-
    crear,
    write('Verbo: '), read(Verbo),
    buscar(Verbo).
crear:-
    open('regulares.txt',append,Str),close(Str),
    open('irregulares.txt',append,Str2),close(Str2).
buscar(VerBus) :-
    open('regulares.txt',read,Str),
    bus_verbo(Str,VerBus,Conjugaciones),
    close(Str),
    length(Conjugaciones,A), A > 0, !,
    imprimir(Conjugaciones).
buscar(VerBus):-
    open('irregulares.txt',read,Str),
    bus_verbo(Str,VerBus,Conjugaciones),
    close(Str),
    length(Conjugaciones,A), A > 0, !,
    imprimir(Conjugaciones).
buscar(VerBus):-
    write('No conozco el verbo...'),nl,
    conjugar(VerBus).

bus_verbo(Str,VerBus,Conjugaciones):-
    read(Str,X), X \= end_of_file, !,
    bus_verbo2(Str,X,VerBus,Conjugaciones).
bus_verbo2(Str,[Verbo,Yo,Tu,El,Nos,Ust,Ell],VerBus,Conjugaciones):-
    (VerBus == Verbo)->
        Conjugaciones = [Verbo,Yo,Tu,El,Nos,Ust,Ell]
    ;bus_verbo(Str,VerBus,Conjugaciones).


conjugar(Verbo):-
    string_chars(Verbo,Lista), 
    append(Raiz,[a,r],Lista), !,
    write('Verbo:    '), write(Verbo),nl,
    conjugar2(Raiz,'a').
conjugar(Verbo):-
    string_chars(Verbo,Lista), 
    append(Raiz,[e,r],Lista), !,
    write('Verbo:    '), write(Verbo),nl,
    conjugar2(Raiz,'e').
conjugar(Verbo):-
    string_chars(Verbo,Lista),
    append(Raiz,[i,r],Lista), !,
    write('Verbo:    '), write(Verbo),nl,
    conjugar2(Raiz,'i').
conjugar(_):- write('El verbo no se encuentra en infinitivo').

conjugar2(R,Term):-
    atom_chars(Raiz,R), 
    write('Yo:       '), write(Raiz), write('o'), nl,
    write('Tu:       '), write(Raiz), write(Term), write('s'), nl,
    write('El/Ella:  '), write(Raiz), write(Term), nl,
    write('Nosotros: '), write(Raiz), write(Term), write('mos'), nl,
    write('Ustedes:  '), write(Raiz), write(Term), write('n'), nl,
    write('Ellos:    '), write(Raiz), write(Term), write('n'), nl,
    write('Se conjuga de esta manera?(si/no)'),read(X),
    aprender(R,Term,X).
/* [Verbo,Yo,Tu,El,Nos,Ust,Ell] */
aprender(Raiz,Term,si):-
    append(Raiz,[Term],Aux),
    append(Aux,[r],V), atom_chars(Verbo,V), 
    append(Raiz,[o],Y), atom_chars(Yo,Y),
    append(Aux,[s],T), atom_chars(Tu,T), 
    atom_chars(El_Ella,Aux), 
    append(Aux,[m,o,s],N), atom_chars(Nos,N), 
    append(Aux,[n],U), atom_chars(Ust,U), 
    Conjugacion = [Verbo,Yo,Tu,El_Ella,Nos,Ust,Ust],
    open('regulares.txt',append,Str),
    write(Str,Conjugacion), write(Str,'.'), nl(Str),
    close(Str).
aprender(Raiz,Term,no):-
    write('Por favor muestrame como se conjuga:'),nl,
    write('Yo: '), read(Yo),
    write('Tu: '), read(Tu),
    write('El/Ella: '), read(El_Ella),
    write('Nosotros: '), read(Nos),
    write('Ustedes: '), read(Ust),
    write('Ellos: '), read(Ell),
    append(Raiz,[Term,r],V),atom_chars(Verbo,V), 
    Conjugacion = [Verbo,Yo,Tu, El_Ella, Nos, Ust, Ell],
    open('irregulares.txt',append,Str),
    write(Str,Conjugacion), write(Str,'.'), nl(Str),
    close(Str).

imprimir([Verbo,Yo,Tu, El_Ella, Nos, Ust, Ell]):-
    write('Verbo:    '), write(Verbo), nl,
    write('Yo:       '), write(Yo), nl,
    write('Tu:       '), write(Tu), nl,
    write('El/Ella:  '), write(El_Ella), nl,
    write('Nosotros: '), write(Nos), nl,
    write('Ustedes:  '), write(Ust), nl,
    write('Ellos:    '), write(Ell), nl.