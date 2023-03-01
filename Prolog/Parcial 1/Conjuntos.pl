/***********************************************
    Programa: Conjuntos.pl
    Descripcion: Programa que realiza operaciones de conjuntos
    
    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
**********************************************************
    Lenguaje: Conjunto de letras minusculas.
    Ejemplo: {c,a,b,c,b,a} -> {a,b,c}
    <conjunto> ::= {<listaLetras>}
    <listaLetras> ::= nula | <listaNoVacia>
    <listaNoVacia> ::= <letra> |
                       <letra>,<listaNoVacia>
    <letra> ::= a | b | c | ... | z

    Ejercicio: Ingresa dos conjuntos validos, 
    simplificalos, y calcula union, interseccion, 
    diferencia, complementos.
***************************************/
main:-
    write('Conjunto A: '), read(StringA),
    string_chars(StringA,ListaA), 
    verificar(ListaA), 
    write('Conjunto B: '), read(StringB),
    string_chars(StringB,ListaB), 
    verificar(ListaB),

    ordenarLista(ListaA, A), 
    ordenarLista(ListaB, B),

    write('Conjunto A simplificado: '), write(A), nl,
    write('Conjunto B simplificado: '), write(B), nl,
    union(A,B,AUB), write('Union: '), write(AUB), nl, 
    interseccion(A,B,AIC), write('Interseccion: '), write(AIC), nl, 
    diferencia(A,B,AMB), write('A-B: '), write(AMB), nl,
    diferencia(B,A,BMA), write('B-A: '), write(BMA), nl,
    complemento(A,AC), write('Complemento A: '), write(AC), nl, 
    complemento(B,BC), write('Complemento B: '), write(BC).
    

/**********
Codigo que verifica que la expresion este bien escrita (automata)
**********/
verificar([X | Resto]):-
    char_code(X,Y), Y = 123,
    verificar1(Resto).

verificar1([X | Resto]):-
    char_code(X,Y), Y = 125, !,
    verificar2(Resto).

verificar1([X | Resto]):-
    char_code(X,Y), Y >=97, Y=<122,
    verificar3(Resto).

verificar3([X | Resto]):-
    char_code(X,Y), Y=44, !,
    verificar4(Resto).

verificar3([X | Resto]):-
    char_code(X,Y), Y=125, !,
    verificar2(Resto).

verificar4([X | Resto]):-
    char_code(X,Y), Y>=97, Y=<122,
    verificar3(Resto).

verificar2([]):- !.

/**********
Codigo que ordena una lista de caracteres, eliminando comas y { } 
Simplifica la lista de caracteres
**********/
ordenarLista(Lista,Lista6):-
    delete(Lista,'{',Lista2),
    delete(Lista2,'}',Lista3),
    delete(Lista3,',',Lista4),
    list_to_set(Lista4,Lista5),
    ordena(Lista5,Lista6).

ordena([],[]).
ordena([H|T],S):-
    ordena(T,R),
    inserta(H,R,S).

inserta(X,[],[X]).
inserta(X,[H|T],[X,H|T]):-
    char_code(X,X1),
    char_code(H,H1),
    X1<H1,!.
inserta(X,[H|T],[H|S]):-
    inserta(X,T,S).

/**********
Codigo que realiza operaciones de Conjuntos
**********/
union(A,B,C):-
    append(A,B,C1),
    list_to_set(C1,C2), 
    ordena(C2,C).

interseccion(A,B,C):-
    intersection(A,B,C).

diferencia(A,B,C):-
    intersection(A,B,C1),
    dif(A,C1,C).
    
dif(A,[],A):-!.
dif(A,[X | Resto],C):-
    delete(A,X,C1),
    dif(C1,Resto,C).

complemento(A,C):-
    B = [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z],
    diferencia(B,A,C).


