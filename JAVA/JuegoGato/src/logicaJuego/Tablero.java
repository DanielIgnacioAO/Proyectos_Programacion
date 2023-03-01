package logicaJuego;

import enumeradores.*;
/*
    Agregar validacion
    Agregar get board  
    Agregar empate
*/
public class Tablero {
    private tiposJugadores[][] board;
    public final int tamTablero = 3;

    public int getTamTablero() {
        return tamTablero;
    }
    public estadosTablero estado;
    public Tablero(){
        this.board = new tiposJugadores[tamTablero][tamTablero];
        for (int i = 0; i < tamTablero; i++) {
            for (int j = 0; j < tamTablero; j++) {
                board[i][j] = tiposJugadores.VACIO;
            }
        }
        this.estado = estadosTablero.SIN_JUEGO;
    }
    
    public boolean jugada(tiposJugadores jugador,int fila, int col){
        if(fila >= 0 && fila < tamTablero && col >= 0 && col < tamTablero){
            this.board[fila][col] = jugador;
            
            if ((board[0][0] == jugador && board[0][1] == jugador && board[0][2] == jugador)//compueba horizontales
                    ||(board[1][0] == jugador && board[1][1] == jugador && board[1][2] == jugador)
                    ||(board[2][0] == jugador && board[2][1] == jugador && board[2][2] == jugador)
                    
                    ||(board[0][0] == jugador && board[1][0] == jugador && board[2][0] == jugador)//´prueba vertical
                    ||(board[0][1] == jugador && board[1][1] == jugador && board[2][1] == jugador)
                    ||(board[0][2] == jugador && board[1][2] == jugador && board[2][2] == jugador)
                    
                    ||(board[0][0] == jugador && board[1][1] == jugador && board[2][2] == jugador)
                    ||(board[2][0] == jugador && board[1][1] == jugador && board[0][2] == jugador)
                    ) {
                
                /*
                if (jugador == 'o') 
                    this.estado = estadosTablero.JUEGO_GANADO_CIRCULO;
                else
                    this.estado = estadosTablero.JUEGO_GANADO_CRUZ;
                */
                    this.estado = (jugador == tiposJugadores.CIRCULOS) ?  estadosTablero.JUEGO_GANADO_CIRCULO : estadosTablero.JUEGO_GANADO_CRUZ; 
                
            }
            
            if(this.estado == estadosTablero.JUEGO_INICIADO){
                boolean tableroFull = true;
                for (int i = 0; i < this.tamTablero; i++) {
                    for (int j = 0; j < this.tamTablero; j++) {
                        if (this.board[i][j] == tiposJugadores.VACIO)
                            tableroFull = false;
                    }
                }
            
                if(tableroFull)
                    this.estado = estadosTablero.JUEGO_EMPATADO;
                else
                    this. estado = estadosTablero.JUEGO_INICIADO;
            
            }
                
            return true;
        }else{
            System.out.println("Jugada no valida");
            return false;
        }
    }
    public boolean validacion(int x, int y){
        if(this.board[x][y] == tiposJugadores.VACIO)
            return true;
        else
            return false;
    }
    
    public tiposJugadores[][] getBoard(){
        return this.board;
    }
}
