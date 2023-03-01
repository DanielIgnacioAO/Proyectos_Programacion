/*************************************
    Programa: PantallaLCD.pl
    Descripcion: Programa que al definir tamano y numero, imprime el numero en formato LCD
                del tamano proporcionado  
    
    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
***************************************/

:- use_module(library(lists)).
main:-
    write('Numero: '),read(Num),write('Tamano: '),read(Tam),
    pantalla(Tam,Num).
    

/**************************************************************
Codigo para la pantalla
**************************************************************/
pantalla(Tam, Num):-
    listarNumero(Num, ListaDig),
    superior(Tam, ListaDig),
    medio_Superior(Tam,Tam,ListaDig),
    medio(Tam, ListaDig),
    medio_Inferior(Tam, Tam,ListaDig),
    base(Tam, ListaDig).

/* Imprime la parte superior de un numero */
superior(_,[]):- nl, !.
superior(Ancho, [X | Resto]):-
    (X = 0; X = 2; X = 3; X = 5; X = 6; X = 7; X = 8; X = 9)->
        write('  '), impGuionH(Ancho), write('  '),
        superior(Ancho,Resto)
    ;
        write('  '), impEspacio(Ancho), write('  '), 
        superior(Ancho,Resto).
    /*4 1*/

/* Imprime la parte medio superior de un numero*/
medio_Superior(_,0,_):- !.
medio_Superior(Ancho,Alto, ListaDig):-
    medio_Superior_2(Ancho,ListaDig),
    Alto2 is Alto-1,
    medio_Superior(Ancho,Alto2,ListaDig).    

medio_Superior_2(_,[]):- nl, !.
medio_Superior_2(Ancho, [X | Resto]):-
    (X = 0; X = 4; X = 8; X = 9)->
        write(' '), write('|'), impEspacio(Ancho), write('|'), write(' '),
        medio_Superior_2(Ancho, Resto)
    ;(X = 1; X = 2; X = 3; X = 7)->
        write(' '), write(' '), impEspacio(Ancho), write('|'), write(' '),
        medio_Superior_2(Ancho, Resto)
    ;
        write(' '), write('|'), impEspacio(Ancho), write(' '), write(' '),
        medio_Superior_2(Ancho, Resto).
    /*5 6 */

/* Imprime la parte media de un numero */
medio(_,[]):- nl, !.
medio(Ancho,[X | Resto]):-
    (X = 2; X = 3; X = 4; X = 5; X = 6; X = 8; X = 9)->
        write('  '), impGuionH(Ancho), write('  '),
        medio(Ancho,Resto) 
    ;
        write('  '), impEspacio(Ancho), write('  '), 
        medio(Ancho, Resto).
    /*0 1 7*/

/* Imprime la parte medio superior de un numero*/
medio_Inferior(_,0,_):-!.
medio_Inferior(Ancho, Alto, ListaDig):-
    medio_Inferior_2(Ancho,ListaDig),
    Alto2 is Alto-1,
    medio_Inferior(Ancho,Alto2, ListaDig).

medio_Inferior_2(_, []):- nl, !.
medio_Inferior_2(Ancho, [X | Resto]):-
    (X = 0; X = 6; X = 8)->
        write(' '), write('|'), impEspacio(Ancho), write('|'), write(' '),
        medio_Inferior_2(Ancho, Resto)
    ;(X = 1; X = 3; X = 4; X = 5; X = 7; X = 9)->
        write(' '), write(' '), impEspacio(Ancho), write('|'), write(' '),
        medio_Inferior_2(Ancho, Resto)
    ;
        write(' '), write('|'), impEspacio(Ancho), write(' '), write(' '),
        medio_Inferior_2(Ancho, Resto).
    /* 2 */

/* Imprime la parte base de un numero*/
base(_,[]):- nl, !.
base(Ancho, [X | Resto]):-
    (X = 0; X = 2; X = 3; X = 5; X = 6; X = 8; X = 9)->
        write('  '), impGuionH(Ancho), write('  '),
        base(Ancho,Resto)
    ;
        write('  '), impEspacio(Ancho), write('  '),
        base(Ancho,Resto).
    /* 1 4 7 */

impGuionH(0):-!.
impGuionH(N):-
    write('-'),N2 is N-1,impGuionH(N2).

impEspacio(0):-!.
impEspacio(N):-
    write(' '),N2 is N-1, impEspacio(N2).

/*****************
Codigo para cambiar un numero a una lista
*****************/
/* X es un numero, Lista es el mismo numero pero en forma de lista */
listarNumero(X, Lista):-
    listarNumero2(X, Lista2),
    reverse(Lista2,Lista).
listarNumero2(X,Lista):-
    (X > 0) ->
        Digito is X mod 10,
        X2 is X // 10,
        listarNumero2(X2, Lista2),
        agregar(Digito, Lista2, Lnueva),
        Lista = Lnueva
    ; Lista = [].
agregar(X, L, Lnueva):- 
    append([X], L, Lnueva).
