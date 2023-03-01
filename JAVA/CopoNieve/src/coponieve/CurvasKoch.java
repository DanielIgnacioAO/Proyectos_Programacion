/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package coponieve;

import java.awt.Graphics;

/**
 *
 * @author danny
 */
public class CurvasKoch {
    double sin60=Math.sin(3.14/3.);
    public CurvasKoch() {
    }
    
    
    
    public void dibujarCurva(Graphics g, int i, double x1, double y1, double x2, double y2){
        //parte la linea en 3
        double dx=(x2-x1)/3.;
        double dy=(y2-y1)/3.;
        double xP=x1+3*dx/2.-dy*sin60;
        double yP=y1+3*dy/2.+dx*sin60;
        if(i==0){
            g.drawLine((int)x1, (int)y1, (int)x2, (int)y2);
        }
        else{
            dibujarCurva(g,i-1,x1,y1,x1+dx,y1+dy);
            dibujarCurva(g,i-1,x1+dx,y1+dy,xP,yP);
            dibujarCurva(g,i-1,xP,yP,x2-dx,y2-dy);
            dibujarCurva(g,i-1,x2-dx,y2-dy,x2,y2);
        }
    }
}
