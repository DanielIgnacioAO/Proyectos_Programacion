/***************
    Programa: Triangulos.pl
    Descripcion: Programa que construye 4 triangulos:
        Ejercicio 1: Triagulo de Pascal con listas.

        Ejercicio 2: Triangulo de Pascal con combinaciones 
                    C(n,r) = n!/r!/(n-r)!.
        
        Ejercicio 3: Imprimir el triangulo de Pascal de la forma
                    siguiente: Valor impar = *, Valor par = Espacio.
        
        Ejercicio 4: Imprimir el Triangulo de Sierpinski usando automatas celulares
                    00  01  10  11
                     0   1   1   0
    
    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
***************/

main:-
    write('Hasta que nivel desea los triangulos, considere que se empieza de cero:'),
    read(N),
    nl, write('Ejercicio 1 -> Triangulo de Pascal contruido con listas:'),nl,
    pascal_List([1], 0, N), nl, nl,
    nl, write('Ejercicio 2 -> Triangulo de Pascal contruido con Combinaciones'),nl,
    pascal_Combinaciones(0,N), nl, nl, 
    nl, write('Ejercicio 3 -> Triangulo de Pascal contruido con listas, sustituyendo los pares por espacios y los impares por *:'),nl,
    pascal_Astediscos([1], 0, N), nl, nl,
    nl, write('Ejercicio 4 -> Triangulo de Sierpinski, contruido con automatas celulares:'),nl,
    sierpinski([1], 0, N).

/*******
Codigo para el triangulo de pascal con listas
*******/
pascal_List(_, I, N):- I > N, !.
pascal_List(Lista, I, N):-
    nl, imprimirLista(Lista),
    I2 is I + 1,
    pasLisNivel(0,Lista,Lista2),
    pascal_List(Lista2, I2, N).
    
pasLisNivel(1,[],ListaR):- ListaR = [1].
pasLisNivel(X1, [X2 | Resto], ListaR):-
    Y is X1 + X2,
    Lista1 = [Y],
    pasLisNivel(X2, Resto, Lista2),
    append(Lista1,Lista2,ListaR).

imprimirLista([]):- !.
imprimirLista([X | Resto]):-
    write(X), write(' '), imprimirLista(Resto).  

/*******
Codigo para el triangulo de pascal con combinaciones C(n,r) = n!/r!/(n-r)!
*******/
pascal_Combinaciones(N,M):- N > M, !.
pascal_Combinaciones(N,M):- 
    nl, pasComR(N,0),
    N2 is N + 1,
    pascal_Combinaciones(N2,M).

pasComR(N,R):- R > N, !.
pasComR(N,R):-
    n_factorial(N,Nfactor),
    n_factorial(R,Rfactor),
    Dif is N - R, n_factorial(Dif,Diffactor),
    C is Nfactor / Rfactor / Diffactor,
    write(C), write(' '), 
    R2 is R + 1,
    pasComR(N,R2).

n_factorial(0, 1).
n_factorial(N, F) :-
        N > 0,
        N1 is N - 1,
        n_factorial(N1, F1),
        F is N * F1.

/*******
Codigo para el triangulo de pascal con astediscos y espacios
Nota: reutiliza codigo del triangulo de pascal con listas
*******/
pascal_Astediscos(_, I, N):- I > N, !.
pascal_Astediscos(Lista, I, N):- 
    nl, imprimirLista_Astediscos(Lista),
    I2 is I + 1,
    pasLisNivel(0,Lista, Lista2),
    pascal_Astediscos(Lista2, I2, N).

imprimirLista_Astediscos([]):- !.
imprimirLista_Astediscos([X | Resto]):-
    A is X mod 2,
    (A = 0)-> 
        write('  '), imprimirLista_Astediscos(Resto)
    ;
        write('*'), write(' '),imprimirLista_Astediscos(Resto).

/*******
Codigo para el triangulo de Sierpinski con automata celular
Notas: 
00  01  10  11
 0   1   1   0
*******/
sierpinski(_, I, N):- I > N, !.
sierpinski(Lista, I, N):-
    nl, imprimirLista(Lista),
    I2 is I + 1,
    sierNivel(Lista, Lista2), 
    append([1],Lista2,Lista3), 
    sierpinski(Lista3, I2, N).

sierNivel([1], ListaR):- ListaR = [1].
sierNivel([X, Y | Resto], ListaR):- 
    (X = Y)->
        Z is 0,
        Lista1 = [Z],
        sierNivel([Y | Resto], Lista2),
        append(Lista1,Lista2,ListaR)
    ;
        Z is 1,
        Lista1 = [Z],
        sierNivel([Y | Resto], Lista2),
        append(Lista1,Lista2,ListaR).