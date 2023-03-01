/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logicaJuego;

import enumeradores.tiposJugadores;

/**
 *  CRUZ = 'X'#3
    CIRCULO = 'O'#5
    VACIO = ' '#2
 * @author danny
 */
public class Bot {
    public tiposJugadores[] board;
    private final int tamano = 9; 
    public tiposJugadores jugador, computador;
    private final int[][] wins = {{0, 1, 2}, {3, 4, 5}, {6, 7, 8}, {0, 3, 6}, {1, 4, 7}, {2, 5, 8}, {0, 4, 8}, {2, 4, 6}};
    
    public Bot(tiposJugadores avatar){
        this.computador = avatar;
        this.jugador = (this.computador == tiposJugadores.CRUZES) ? tiposJugadores.CIRCULOS : tiposJugadores.CRUZES;
        this.board = new tiposJugadores[tamano];
        for (int i = 0; i < this.board.length; i++) {
            this.board[i]=tiposJugadores.VACIO;
        }
    }
    public void actualizarBoard(tiposJugadores[][] tablero, int tam){
        int k = 0;
        for (int i = 0; i < tam; i++) {
            for (int j = 0; j < tam; j++) {
                this.board[k] = tablero[i][j];
                k ++;
            }
            
        }
    }
    //regresa la posicion del 0-8 que debe tirar el bot
    // si regresa -1 significa que el tablero esta lleno
    public int algoritmoBot(){
        int turnoActual = 1;
        for (tiposJugadores i : board) {
            if(i == tiposJugadores.CIRCULOS || i == tiposJugadores.CRUZES)
                turnoActual++;
        }
        
        if(this.computador == tiposJugadores.CRUZES){
            switch(turnoActual){
                case 1:
                    return 0;
                case 3:
                    if(this.board[4] == tiposJugadores.VACIO)
                        return 4;
                    else
                        return 2;
                case 5:
                    if(posWin(this.computador) != -1)
                        return posWin(computador);
                    else if(posWin(this.jugador) != -1)
                        return posWin(jugador);
                    else if(this.board[6] == tiposJugadores.VACIO)
                        return 6;
                    else
                        return 2;
                case 7:
                    if(posWin(this.computador) != -1)
                        return posWin(computador);
                    else if(posWin(this.jugador) != -1)
                        return posWin(jugador);
                    else
                        return primerVacio();
                case 9:
                    if(posWin(this.computador) != -1)
                        return posWin(computador);
                    else if(posWin(this.jugador) != -1)
                        return posWin(jugador);
                    else
                        return primerVacio();
            }
        }else{
            switch(turnoActual){
                case 2:
                    if(this.board[4] == tiposJugadores.VACIO)
                        return 4;
                    else 
                        return 0;
                case 4:
                    if(posWin(jugador) != -1)
                        return posWin(jugador);
                    else 
                        return make();
                case 6:
                    if(posWin(computador) != -1)
                        return posWin(computador);
                    else if(posWin(jugador) != -1)
                        return posWin(jugador);
                    else 
                        return make();
                case 8:
                    if(posWin(computador) != -1)
                        return posWin(computador);
                    else if(posWin(jugador) != -1)
                        return posWin(jugador);
                    else 
                        return primerVacio();
            }
        }
        return -1;
    }
    
    //comprueba si el player puede ganar
    //regresa -1 si player no puede ganar
    private int posWin(tiposJugadores player){
        int[] aux = new int[this.tamano];
        for (int i = 0; i < aux.length; i++) {
            if(this.board[i] == tiposJugadores.VACIO)
                aux[i] = 2;
            else if(this.board[i] == tiposJugadores.CRUZES)
                aux[i] = 3;
            if(this.board[i] == tiposJugadores.CIRCULOS)
                aux[i] = 5;
            
        }
        
        if(player == tiposJugadores.CRUZES){ // 3*3*2
            for (int[] win : wins) {
                if(aux[win[0]] * aux[win[1]] * aux[win[2]] == 18){
                    if(aux[win[0]] == 2)
                        return win[0];
                    else if(aux[win[1]] == 2)
                        return win[1];
                    else
                        return win[2];
                }
            }
        }else{//5*5*2
            for (int[] win : wins) {
                if(aux[win[0]] * aux[win[1]] * aux[win[2]] == 50){
                    if(aux[win[0]] == 2)
                        return win[0];
                    else if(aux[win[1]] == 2)
                        return win[1];
                    else
                        return win[2];
                }
            }
        }
        return -1;
    }
    
    private int primerVacio(){
        for (int i = 0; i < board.length; i++) {
            if(this.board[i] == tiposJugadores.VACIO)
                return i;
        }
        return 8;
    }
    
    private int make(){
        if(trampaEsquinas() != -1) 
            return trampaEsquinas();
        else if(trampaL() != -1) 
            return trampaL();
        else if(trampaDiagonal()!= -1) 
            return trampaDiagonal();
        else if(this.board[4] == tiposJugadores.VACIO)
            return 4;
        else if(this.board[0] == tiposJugadores.VACIO)
            return 0;
        else
            return primerVacio();
        
    }
    
    //regresa -1 si no existe la trampa
    private int trampaEsquinas(){
        if( (this.board[0]) == jugador && (this.board[2]) == jugador ||
            (this.board[0]) == jugador && (this.board[6]) == jugador ||    
            (this.board[0]) == jugador && (this.board[8]) == jugador ||
            (this.board[2]) == jugador && (this.board[6]) == jugador ||
            (this.board[2]) == jugador && (this.board[8]) == jugador ||
            (this.board[6]) == jugador && (this.board[8]) == jugador ){
            
            if(this.board[1] == tiposJugadores.VACIO) return 1;
            else if(this.board[3] == tiposJugadores.VACIO) return 3;
            else if(this.board[5] == tiposJugadores.VACIO) return 5;
            else if(this.board[7] == tiposJugadores.VACIO) return 7;
        }
        return -1;
    }
    //regresa -1 si no existe la trampa
    private int trampaL(){
        if((this.board[0]) == jugador && (this.board[5]) == jugador)return 2;
        else if((this.board[0]) == jugador && (this.board[7]) == jugador)return 6;  
        else if((this.board[1]) == jugador && (this.board[6]) == jugador)return 0;
        else if((this.board[1]) == jugador && (this.board[8]) == jugador)return 2;
        else if((this.board[2]) == jugador && (this.board[3]) == jugador)return 0;
        else if((this.board[2]) == jugador && (this.board[7]) == jugador)return 8;
        else if((this.board[3]) == jugador && (this.board[2]) == jugador)return 0;
        else if((this.board[3]) == jugador && (this.board[8]) == jugador)return 6;
        else if((this.board[5]) == jugador && (this.board[0]) == jugador)return 2;
        else if((this.board[5]) == jugador && (this.board[6]) == jugador)return 8;
        else if((this.board[6]) == jugador && (this.board[1]) == jugador)return 0;
        else if((this.board[6]) == jugador && (this.board[5]) == jugador)return 8;
        else if((this.board[7]) == jugador && (this.board[0]) == jugador)return 6;
        else if((this.board[7]) == jugador && (this.board[2]) == jugador)return 8;
        else if((this.board[8]) == jugador && (this.board[1]) == jugador)return 2;
        else if((this.board[8]) == jugador && (this.board[3]) == jugador)return 6;
        return -1;
    }
    //regresa -1 si no existe la trampa
    private int trampaDiagonal(){
        if( (this.board[4]) == jugador && (this.board[2]) == jugador ||
            (this.board[4]) == jugador && (this.board[6]) == jugador ||
            (this.board[4]) == jugador && (this.board[8]) == jugador){
            if(this.board[2] == tiposJugadores.VACIO)
                return 2;
            else if(this.board[6] == tiposJugadores.VACIO)
                return 6;
        }
        
        return -1;
        
    }
    
    public void imp(){
        int[] aux = new int[this.tamano];
        for (int i = 0; i < aux.length; i++) {
            if(this.board[i] == tiposJugadores.VACIO)
                aux[i] = 2;
            else if(this.board[i] == tiposJugadores.CRUZES)
                aux[i] = 3;
            if(this.board[i] == tiposJugadores.CIRCULOS)
                aux[i] = 5;
            
        }
        for (int i : aux) {
            System.out.print(i + "-");
        }
        System.out.println("");
        
    }
    
}
