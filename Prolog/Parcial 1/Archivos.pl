/***********************************************
    Programa: archivo.pl
    Funcion:  Manipulacion basica de archivos
            de texto
    --------------------------------------------
    Manejo dinamico de conocimiento:
    assert(animal(leon)).
    retract(animal(leon)).
    retractall(animal(_)).
    --------------------------------------------
    Programa para validar polinomios en X con
    coeficientes enteros.
    Polinomio: 20x7-13x12+x-71.
    Bien escrito.
***********************************************/

escritura :-
    open('archivo.txt',append,Str), 
    write('Escribe algo entre comillas (fin termina): '),
    read(X),
    not(X = fin), !,
    write(Str,X), write(Str,'.'), nl(Str),
    close(Str),
    escritura.
escritura.

lectura :-
    open('archivo.txt',read,Str),
    lec_renglon(Str,Lista),
    close(Str),
    write('Contenido: '), write(Lista), nl.

lec_renglon(Str,[X | Resto]) :-
    read(Str,X), X \= end_of_file, !,
    write(X), nl,
    lec_renglon(Str,Resto).
lec_renglon(_,[]).