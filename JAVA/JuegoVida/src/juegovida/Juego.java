/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package juegovida;

import java.awt.List;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;

/**
 *
 * @author danny
 */
public class Juego {
    int celulasVivas=0;
    int turno=0;
    protected int [][] matrizTablero = new int[50][50];
    protected int [][] matrizAnt = new int[50][50];
    protected ArrayList<int[][]> respaldos;
    public Juego() {
        respaldos=new ArrayList<>();
        for (int i = 0; i < 50; i++) {
            for (int j = 0; j < 50; j++) {
                matrizTablero[i][j]=0;
            }
        }
        
        int x,y;
        for (int i = 0; i < 10; i++) {
            x = (int)(Math.random()*(6)+25);
            y = (int)(Math.random()*(6)+25);
            matrizTablero[x][y]=1;
        }
        
        this.contarCelulas();
    }
    
    public void sigTurno(){
        this.respaldar();
        this.turno++;
        
        int vivasAlr=0;
        for (int i = 0; i < 50; i++) {
            for (int j = 0; j < 50; j++) {
                if(i<49){
                    if(matrizAnt[i+1][j]==1)
                        vivasAlr++;
                }
                if(i<49 && j<49){
                    if(matrizAnt[i+1][j+1]==1)
                        vivasAlr++;
                }
                if(j<49 ){
                    if(matrizAnt[i][j+1]==1)
                        vivasAlr++;
                }
                if(i>0 && j<49){
                    if(matrizAnt[i-1][j+1]==1)
                        vivasAlr++;
                }
                if(i>0 ){
                    if(matrizAnt[i-1][j]==1)
                        vivasAlr++;
                }
                if(i>0 && j>0 ){
                    if(matrizAnt[i-1][j-1]==1)
                        vivasAlr++;
                }
                if(j>0){
                    if(matrizAnt[i][j-1]==1)
                        vivasAlr++;
                }
                if(i<49 && j>0){
                    if(matrizAnt[i+1][j-1]==1)
                        vivasAlr++;
                }
                
                
                if(matrizAnt[i][j]==0 && vivasAlr==3){
                    matrizTablero[i][j]=1;
                }else if(matrizAnt[i][j]==1 && vivasAlr==2){
                    matrizTablero[i][j]=1;
                }else if(matrizAnt[i][j]==1 && vivasAlr==3){
                    matrizTablero[i][j]=1;
                }else{
                    matrizTablero[i][j]=0;
                }
                vivasAlr=0;
            }
        }
        
        this.contarCelulas();
    }
    
    public void antTurno(){
        this.turno--;
        this.respaldos.remove(turno);
        
        for (int i = 0; i < 50; i++) {
            for (int j = 0; j < 50; j++) {
                matrizTablero[i][j] = this.matrizAnt[i][j];
            }
        }
        if(turno>0){
            int aux2=turno-1;
            int[][] aux = respaldos.get(aux2);
            for (int i = 0; i < 50; i++) {
                for (int j = 0; j < 50; j++) {
                    this.matrizAnt[i][j] = aux[i][j];
                }
            }
        }
        this.contarCelulas();
    }
    
    private void respaldar(){
        for (int i = 0; i < 50; i++) {
            for (int j = 0; j < 50; j++) {
                this.matrizAnt[i][j] = matrizTablero[i][j];
            }
        }
        
        int[][] aux= new int[50][50];
            for (int i = 0; i < 50; i++) {
                for (int j = 0; j < 50; j++) {
                    aux[i][j] = this.matrizAnt[i][j] ;
                }
            }
        
        respaldos.add(turno,aux);
        
       
    }
    
    private void contarCelulas(){
        int aux=0;
        for (int i = 0; i < 50; i++) {
            for (int j = 0; j < 50; j++) {
                if(matrizTablero[i][j]==1)
                    aux++;
            }
        }
        this.celulasVivas=aux;
    }
    
    
    
}
