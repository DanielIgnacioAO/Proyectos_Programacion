/*************************************
    Programa: Mapa.pl
    Descripcion: Programa que muestra todas las rutas de un grafo
                el main ejecutara codigo para verificar que los nodos dados existan en el grado 1
                el cual corresponde al Mapa de Romania

        Grafo 1: Mapa de Romania
        Grafo 2: Grafo pequenio para hacer pruebas
    
    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
***************************************/
main:-
    write('Mapa de Romania'),nl,
    write('Escribir tanto el origen como destino entre comillas'),nl,
    write('Origen: '),read(I),verificar(I),
    write('Destino: '),read(F),verificar(F),
    ruta(I,F).

/* Codigo que verifica que el nodo este bie escrito */
verificar(N):-
    (N=='Oradea';N=='Zerind';N=='Sibiu';N=='Arad';N=='Timisoara';N=='Lugoj';N=='Mehadia';N=='Drobeta';N=='Craiova';N=='Rimnicu Vilcea';N=='Pitesti';N=='Fagaras';N=='Bucharest';N=='Giurgiu';N=='Urziceni';N=='Hirsova';N=='Eforie';N=='Vaslui';N=='Iasi';N=='Neamt')->
        true
    ; false.
/*
    Definicion de los nodos con sus aristas del grafo
    arista(Origen, Destino, Distancia)
*/
/* Grafo 1: Romania*/
arista('Oradea','Zerind',71).
arista('Oradea','Sibiu',151).
arista('Zerind','Oradea',71).
arista('Zerind','Arad',75).
arista('Sibiu','Oradea',71).
arista('Sibiu','Arad',140).
arista('Sibiu','Fagaras',99).
arista('Sibiu','Rimnicu Vilcea',80).
arista('Arad','Zerind',75).
arista('Arad','Sibiu',140).
arista('Arad','Timisoara',118).
arista('Timisoara','Arad',118).
arista('Timisoara','Lugoj',111).
arista('Lugoj','Timisoara',111).         
arista('Lugoj','Mehadia',70).
arista('Mehadia','Lugoj',70).
arista('Mehadia','Drobeta',75).
arista('Drobeta','Mehadia',75).
arista('Drobeta','Craiova',120).
arista('Craiova','Drobeta',120).
arista('Craiova','Rimnicu Vilcea',146).
arista('Craiova','Pitesti',138).
arista('Rimnicu Vilcea','Craiova',146).
arista('Rimnicu Vilcea','Pitesti',97).
arista('Rimnicu Vilcea','Sibiu',80).
arista('Pitesti','Craiova',138).
arista('Pitesti','Rimnicu Vilcea',97).
arista('Pitesti','Bucharest',101).
arista('Fagaras','Sibiu',99).              
arista('Fagaras','Bucharest',211).
arista('Bucharest','Fagaras',211).
arista('Bucharest','Giurgiu',90).   
arista('Bucharest','Pitesti',101).
arista('Bucharest','Urziceni',85).
arista('Giurgiu','Bucharest',90).
arista('Urziceni','Bucharest',85).
arista('Urziceni','Hirsova',98).
arista('Urziceni','Vaslui',142).
arista('Hirsova','Urziceni',98).
arista('Hirsova','Eforie',86).
arista('Eforie','Hirsova',86).
arista('Vaslui','Urziceni',142).
arista('Vaslui','Iasi',92).
arista('Iasi','Vaslui',92).
arista('Iasi','Neamt',87).
arista('Neamt','Iasi',87).

/* Grafo 2 */
arista('A','B',1).
arista('A','E',2).
arista('B','A',1).
arista('B','E',3).
arista('B','D',2).
arista('B','C',4).
arista('C','B',4).
arista('C','D',1).
arista('D','C',1).
arista('D','B',2).
arista('D','E',1).
arista('E','A',2).
arista('E','B',3).
arista('E','D',1).

/* Codigo que imprime todas las rutas */
ruta(I,F):-
    ruta2(I,F,[],0,0).
ruta2(F,F,C,DisT,DisProx):-
    append(C,[F],C2),
    DisT2 is DisT + DisProx,
    write('Ruta: '),write(C2),nl,write('Distancia: '),write(DisT2),nl,nl.
ruta2(NodoA,F,C,DisT,DisProx):-!,
    (not(member(NodoA,C)))-> 
        append(C,[NodoA],C2),
        DisT2 is DisT + DisProx,
        findall(Dis,arista(NodoA,_,Dis),L),
        ruta3(NodoA,F,C2,L,DisT2)
    ;true.

ruta3(_,_,_,[],_):-!.
ruta3(NodoA,F,C,[Xdis | Resto],DisT):-
    arista(NodoA,Y,Xdis),
    ruta2(Y,F,C,DisT,Xdis),
    ruta3(NodoA,F,C,Resto,DisT).
