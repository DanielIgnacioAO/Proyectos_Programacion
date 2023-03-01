package sierspinki;

import java.awt.Graphics;

/**
 *
 * @author danny
 */
public class Triangulos{

    public Triangulos() {
    }
    
    
    /*
    1. Toma tres puntos en un plano para formar un triángulo, no necesitas dibujarlo.
    2. Seleccione aleatoriamente cualquier punto dentro del triángulo y considere que es su posición actual.
    3. Seleccione al azar cualquiera de los tres puntos de vértice.
    4. Muévase la mitad de la distancia desde su posición actual hasta el vértice seleccionado.
    5. Trace la posición actual.
    6 .Repita desde el paso 3.
    */
    //paso 1: los 3 puntos que forman el triangulo se crean en la interfaz al momento de oprimir el boton
    public void dibujarTri(Graphics g, int i, int x1, int y1, int x2, int y2, int x3, int y3){
        //paso 2: posicion actaul
        int xr = (int)(Math.random()*(325-275)+275);
        int yr = (int)(Math.random()*(325-275)+275);
        
        
        //paso 6
        for (int j = 0; j < i; j++) {
            
        
            //paso 3
            int op = (int)(Math.random()*(4-1)+1);
            int xAux=0, yAux=0;
            //System.out.println(op);
            switch(op){
                case 1:
                        xAux=x1;
                        yAux=y1;
                    break;
                case 2:
                        xAux=x2;
                        yAux=y2;
                    break;
                default:
                        xAux=x3;
                        yAux=y3;
                    break;
            }
        
            //paso 4: nueva posicion actual
            int dx1=(int)(xr+xAux)/2;
            int dy1=(int)(yr+yAux)/2;
            xr=dx1;
            yr=dy1;
    
            //paso 5
            g.drawRect(dx1, dy1, 0, 0);
        }
    }
}