/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package frontend;

import enumeradores.estadosTablero;
import enumeradores.tiposJuego;
import enumeradores.tiposJugadores;
import java.awt.Color;
import java.awt.Graphics;
import logicaJuego.Bot;
import logicaJuego.Tablero;

/**
 * Unificacion de tableroGrafico y Juwego (metodo jugar) 
 * iniciar estado de tablero en constructor 
 * Metodo cambiar texto 
 * Metodo comprobar 
 * Metodos dibujar pacmas(cruces) y dibujar fantasma(circulos) (generalizados) 
 * implemntacion de eventos de casillas 
 * evento de cerrar ventana(dispose) 
 * implmentar bot, 
 * iniciar juego 
 * metodo desbloqueo
 *
 * @author danny
 */
public final class tableroGrafico extends javax.swing.JFrame {

    private Menu menu;
    private Tablero tablero;
    private tiposJugadores turno;
    private tiposJuego tipoJuego;

    private tiposJugadores avatarBot;
    private boolean bloqueo;
    private Bot bot;

    /**
     * Creates new form tableroGrafico
     *
     * @param tipoJuego
     * @param menu
     */
    public tableroGrafico(tiposJuego tipoJuego, Menu menu, tiposJugadores avatarBot) {
        initComponents();
        this.menu = menu;
        this.tablero = new Tablero();
        this.turno = tiposJugadores.CRUZES;
        this.tipoJuego = tipoJuego;

        this.menu.setVisible(false);

        this.jPanel1.setBackground(Color.black);
        this.jPanel2.setBackground(Color.black);
        this.jPanel3.setBackground(Color.black);
        this.jPanel4.setBackground(Color.black);
        this.jPanel5.setBackground(Color.black);
        this.jPanel6.setBackground(Color.black);
        this.jPanel7.setBackground(Color.black);
        this.jPanel8.setBackground(Color.black);
        this.jPanel9.setBackground(Color.black);

        this.avatarBot = avatarBot;
        this.bloqueo = false;
        this.iniciarJuego();
    }

    private void iniciarJuego() {
        this.tablero.estado = estadosTablero.JUEGO_INICIADO;
        this.cambiarTexto();

        if (this.tipoJuego == tiposJuego.UN_JUGADOR) {
            this.bot = new Bot(avatarBot);
            if (avatarBot == tiposJugadores.CRUZES) {
                this.turno = tiposJugadores.CIRCULOS;
                this.cambiarTexto();

                this.bloqueo = true;
                this.etiquetaTurno.setText("Pac-Man comienza ");
                this.textoInstrucciones.setVisible(true);
                this.textoInstrucciones.setText("(click en cualquier casilla para continuar)");
            }
        } else {
            this.bot = null;
        }

    }

    private void cambiarTexto() {
        String text = (this.turno == tiposJugadores.CRUZES) ? "Turno: Pac-Man" : "Turno: Fantasma";
        this.etiquetaTurno.setText(text);
    }

    private void jugar(int x, int y) {
        if (tipoJuego == tiposJuego.DOS_JUGADORES) {
            this.tablero.jugada(turno, x, y);
            if (this.tablero.estado == estadosTablero.JUEGO_INICIADO) {
                this.turno = (this.turno == tiposJugadores.CRUZES) ? tiposJugadores.CIRCULOS : tiposJugadores.CRUZES;
                this.cambiarTexto();
            }
        } else {
            this.tablero.jugada(turno, x, y);
            this.jugarBot();
        }

        if (tablero.estado == estadosTablero.JUEGO_GANADO_CIRCULO) {
            this.etiquetaTurno.setText("FANTASMA GANA");
            this.textoInstrucciones.setText("(Click para jugar de nuevo)");
            this.textoInstrucciones.setVisible(true);
        } else if (tablero.estado == estadosTablero.JUEGO_GANADO_CRUZ) {
            this.etiquetaTurno.setText("PAC-MAN GANA");
            this.textoInstrucciones.setText("(Click para jugar de nuevo)");
            this.textoInstrucciones.setVisible(true);
        } else if (tablero.estado == estadosTablero.JUEGO_EMPATADO) {
            this.etiquetaTurno.setText("SIN GANADOR");
            this.textoInstrucciones.setText("(Click para jugar de nuevo)");
            this.textoInstrucciones.setVisible(true);
        }

    }

    private void jugarBot() {
        this.bot.actualizarBoard(this.tablero.getBoard(), this.tablero.tamTablero);
        int jugadaBot = this.bot.algoritmoBot();
        if (jugadaBot == -1) {
            return;
        }

        Graphics g = null;

        switch (jugadaBot) {
            case 0:
                this.tablero.jugada(this.bot.computador, 0, 0);
                g = this.jPanel1.getGraphics();
                break;
            case 1:
                this.tablero.jugada(this.bot.computador, 0, 1);
                g = this.jPanel2.getGraphics();
                break;
            case 2:
                this.tablero.jugada(this.bot.computador, 0, 2);
                g = this.jPanel3.getGraphics();
                break;
            case 3:
                this.tablero.jugada(this.bot.computador, 1, 0);
                g = this.jPanel4.getGraphics();
                break;
            case 4:
                this.tablero.jugada(this.bot.computador, 1, 1);
                g = this.jPanel5.getGraphics();
                break;
            case 5:
                this.tablero.jugada(this.bot.computador, 1, 2);
                g = this.jPanel6.getGraphics();
                break;
            case 6:
                this.tablero.jugada(this.bot.computador, 2, 0);
                g = this.jPanel7.getGraphics();
                break;
            case 7:
                this.tablero.jugada(this.bot.computador, 2, 1);
                g = this.jPanel8.getGraphics();
                break;
            case 8:
                this.tablero.jugada(this.bot.computador, 2, 2);
                g = this.jPanel9.getGraphics();
                break;
        }
        this.bot.actualizarBoard(tablero.getBoard(), tablero.tamTablero);
        if (this.bot.computador == tiposJugadores.CRUZES) {
            this.dibujarPacman(g);
        } else {
            this.dibujarFantasma(g);
        }

    }

    private void dibujarPacman(Graphics g) {
        g.setColor(Color.yellow);
        g.fillArc(0, 0, 100, 100, 45, 270);
    }

    private void dibujarFantasma(Graphics g) {
        g.setColor(Color.blue);
        g.fillArc(10, 0, 80, 50, 0, 180);
        g.fillRect(10, 25, 80, 50);

        int[] puntosX = {10, 20, 30};
        int[] puntosY = {75, 100, 75};
        for (int i = 0; i < 4; i++) {
            g.fillPolygon(puntosX, puntosY, 3);
            for (int j = 0; j < puntosX.length; j++) {
                puntosX[j] = puntosX[j] + 20;
            }
        }

        g.setColor(Color.white);
        g.fillOval(25, 25, 20, 20);
        g.fillOval(55, 25, 20, 20);

        g.setColor(Color.black);
        g.fillOval(30, 30, 10, 10);
        g.fillOval(60, 30, 10, 10);

    }

    //comprueba si el juego continua o no
    private boolean comprobacionJuego() {
        if (bloqueo) {
            this.etiquetaTurno.setText("Turno: FANTASMA");
            this.textoInstrucciones.setVisible(false);
            this.jugarBot();
            this.bloqueo = false;
        }

        if (this.tablero.estado == estadosTablero.JUEGO_GANADO_CIRCULO
                || this.tablero.estado == estadosTablero.JUEGO_GANADO_CRUZ
                || this.tablero.estado == estadosTablero.JUEGO_EMPATADO) {

            this.repaint();

            this.tablero = new Tablero();
            this.turno = tiposJugadores.CRUZES;
            this.tablero.estado = estadosTablero.JUEGO_INICIADO;
            this.cambiarTexto();

            this.iniciarJuego();
            return false;
        } else {
            return true;
        }
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jPanel2 = new javax.swing.JPanel();
        jPanel3 = new javax.swing.JPanel();
        jPanel4 = new javax.swing.JPanel();
        jPanel5 = new javax.swing.JPanel();
        jPanel6 = new javax.swing.JPanel();
        jPanel7 = new javax.swing.JPanel();
        jPanel8 = new javax.swing.JPanel();
        jPanel9 = new javax.swing.JPanel();
        etiquetaTurno = new javax.swing.JLabel();
        textoInstrucciones = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosed(java.awt.event.WindowEvent evt) {
                formWindowClosed(evt);
            }
        });

        jPanel1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jPanel1MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );

        jPanel2.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jPanel2MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );

        jPanel3.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jPanel3MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );

        jPanel4.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jPanel4MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );

        jPanel5.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jPanel5MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel5Layout = new javax.swing.GroupLayout(jPanel5);
        jPanel5.setLayout(jPanel5Layout);
        jPanel5Layout.setHorizontalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );
        jPanel5Layout.setVerticalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );

        jPanel6.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jPanel6MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel6Layout = new javax.swing.GroupLayout(jPanel6);
        jPanel6.setLayout(jPanel6Layout);
        jPanel6Layout.setHorizontalGroup(
            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );
        jPanel6Layout.setVerticalGroup(
            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );

        jPanel7.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jPanel7MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel7Layout = new javax.swing.GroupLayout(jPanel7);
        jPanel7.setLayout(jPanel7Layout);
        jPanel7Layout.setHorizontalGroup(
            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );
        jPanel7Layout.setVerticalGroup(
            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );

        jPanel8.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jPanel8MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel8Layout = new javax.swing.GroupLayout(jPanel8);
        jPanel8.setLayout(jPanel8Layout);
        jPanel8Layout.setHorizontalGroup(
            jPanel8Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );
        jPanel8Layout.setVerticalGroup(
            jPanel8Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );

        jPanel9.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jPanel9MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel9Layout = new javax.swing.GroupLayout(jPanel9);
        jPanel9.setLayout(jPanel9Layout);
        jPanel9Layout.setHorizontalGroup(
            jPanel9Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );
        jPanel9Layout.setVerticalGroup(
            jPanel9Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );

        etiquetaTurno.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        etiquetaTurno.setText("Turno: ");

        textoInstrucciones.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(textoInstrucciones, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(etiquetaTurno, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jPanel5, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jPanel6, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jPanel7, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(jPanel8, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(jPanel9, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGap(0, 0, Short.MAX_VALUE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jPanel5, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jPanel6, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jPanel7, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jPanel8, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jPanel9, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(etiquetaTurno, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(textoInstrucciones, javax.swing.GroupLayout.DEFAULT_SIZE, 16, Short.MAX_VALUE)
                .addGap(12, 12, 12))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jPanel1MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jPanel1MouseClicked
        // TODO add your handling code here:
        if (comprobacionJuego() == false) {
            return;
        }
        if (this.tablero.validacion(0, 0) == false) {
            return;
        }

        Graphics g = this.jPanel1.getGraphics();
        if (this.turno == tiposJugadores.CRUZES) {
            this.dibujarPacman(g);
        } else {
            this.dibujarFantasma(g);
        }

        this.jugar(0, 0);
    }//GEN-LAST:event_jPanel1MouseClicked

    private void jPanel2MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jPanel2MouseClicked
        // TODO add your handling code here:
        if (comprobacionJuego() == false) {
            return;
        }
        if (this.tablero.validacion(0, 1) == false) {
            return;
        }

        Graphics g = this.jPanel2.getGraphics();
        if (this.turno == tiposJugadores.CRUZES) {
            this.dibujarPacman(g);
        } else {
            this.dibujarFantasma(g);
        }

        this.jugar(0, 1);
    }//GEN-LAST:event_jPanel2MouseClicked

    private void jPanel3MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jPanel3MouseClicked
        // TODO add your handling code here:
        if (comprobacionJuego() == false) {
            return;
        }
        if (this.tablero.validacion(0, 2) == false) {
            return;
        }

        Graphics g = this.jPanel3.getGraphics();
        if (this.turno == tiposJugadores.CRUZES) {
            this.dibujarPacman(g);
        } else {
            this.dibujarFantasma(g);
        }

        this.jugar(0, 2);
    }//GEN-LAST:event_jPanel3MouseClicked

    private void jPanel4MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jPanel4MouseClicked
        // TODO add your handling code here:
        if (comprobacionJuego() == false) {
            return;
        }
        if (this.tablero.validacion(1, 0) == false) {
            return;
        }

        Graphics g = this.jPanel4.getGraphics();
        if (this.turno == tiposJugadores.CRUZES) {
            this.dibujarPacman(g);
        } else {
            this.dibujarFantasma(g);
        }

        this.jugar(1, 0);
    }//GEN-LAST:event_jPanel4MouseClicked

    private void jPanel5MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jPanel5MouseClicked
        // TODO add your handling code here:
        if (comprobacionJuego() == false) {
            return;
        }
        if (this.tablero.validacion(1, 1) == false) {
            return;
        }

        Graphics g = this.jPanel5.getGraphics();
        if (this.turno == tiposJugadores.CRUZES) {
            this.dibujarPacman(g);
        } else {
            this.dibujarFantasma(g);
        }

        this.jugar(1, 1);
    }//GEN-LAST:event_jPanel5MouseClicked

    private void jPanel6MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jPanel6MouseClicked
        // TODO add your handling code here:
        if (comprobacionJuego() == false) {
            return;
        }
        if (this.tablero.validacion(1, 2) == false) {
            return;
        }

        Graphics g = this.jPanel6.getGraphics();
        if (this.turno == tiposJugadores.CRUZES) {
            this.dibujarPacman(g);
        } else {
            this.dibujarFantasma(g);
        }

        this.jugar(1, 2);
    }//GEN-LAST:event_jPanel6MouseClicked

    private void jPanel7MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jPanel7MouseClicked
        // TODO add your handling code here:
        if (comprobacionJuego() == false) {
            return;
        }
        if (this.tablero.validacion(2, 0) == false) {
            return;
        }

        Graphics g = this.jPanel7.getGraphics();
        if (this.turno == tiposJugadores.CRUZES) {
            this.dibujarPacman(g);
        } else {
            this.dibujarFantasma(g);
        }

        this.jugar(2, 0);
    }//GEN-LAST:event_jPanel7MouseClicked

    private void jPanel8MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jPanel8MouseClicked
        // TODO add your handling code here:
        if (comprobacionJuego() == false) {
            return;
        }
        if (this.tablero.validacion(2, 1) == false) {
            return;
        }

        Graphics g = this.jPanel8.getGraphics();
        if (this.turno == tiposJugadores.CRUZES) {
            this.dibujarPacman(g);
        } else {
            this.dibujarFantasma(g);
        }

        this.jugar(2, 1);
    }//GEN-LAST:event_jPanel8MouseClicked

    private void jPanel9MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jPanel9MouseClicked
        // TODO add your handling code here:
        if (comprobacionJuego() == false) {
            return;
        }
        if (this.tablero.validacion(2, 2) == false) {
            return;
        }

        Graphics g = this.jPanel9.getGraphics();
        if (this.turno == tiposJugadores.CRUZES) {
            this.dibujarPacman(g);
        } else {
            this.dibujarFantasma(g);
        }

        this.jugar(2, 2);
    }//GEN-LAST:event_jPanel9MouseClicked

    private void formWindowClosed(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowClosed
        // TODO add your handling code here:
        this.menu.setVisible(true);
    }//GEN-LAST:event_formWindowClosed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel etiquetaTurno;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JPanel jPanel7;
    private javax.swing.JPanel jPanel8;
    private javax.swing.JPanel jPanel9;
    private javax.swing.JLabel textoInstrucciones;
    // End of variables declaration//GEN-END:variables
}
