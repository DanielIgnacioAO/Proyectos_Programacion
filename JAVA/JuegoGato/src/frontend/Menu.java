/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package frontend;

import enumeradores.tiposJuego;
import enumeradores.tiposJugadores;

/**
 *
 * @author danny
 */
public class Menu extends javax.swing.JFrame{

    /**
     * Creates new form Menu
     * Agregar etiquetas de elegir avatar
     * Agregar lo de 1 jugador
     * METODO acomodo iniclal
     */
    public Menu() {
        initComponents();
        this.acomodoInicial();
    }
    private void acomodoInicial(){
        this.botonInicar.setVisible(true);
        this.labelInstrucciones.setVisible(false);
        this.label2jugadores.setVisible(false);
        this.labelJugador.setVisible(false);
        this.labelTurno1.setVisible(false);
        this.labelTurno2.setVisible(false);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel1 = new javax.swing.JLabel();
        botonInicar = new javax.swing.JButton();
        labelInstrucciones = new javax.swing.JLabel();
        labelJugador = new javax.swing.JLabel();
        label2jugadores = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        labelTurno1 = new javax.swing.JLabel();
        labelTurno2 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setBackground(new java.awt.Color(0, 204, 255));

        jLabel1.setFont(new java.awt.Font("Tempus Sans ITC", 1, 18)); // NOI18N
        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel1.setText("GATO-GAME");

        botonInicar.setText("Iniciar");
        botonInicar.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        botonInicar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                botonInicarActionPerformed(evt);
            }
        });

        labelInstrucciones.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        labelInstrucciones.setText("Seleccione modo de juego");

        labelJugador.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        labelJugador.setText("1 Jugador");
        labelJugador.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        labelJugador.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                labelJugadorMouseClicked(evt);
            }
        });

        label2jugadores.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        label2jugadores.setText("2 Jugadores");
        label2jugadores.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        label2jugadores.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mousePressed(java.awt.event.MouseEvent evt) {
                label2jugadoresMousePressed(evt);
            }
        });

        jLabel5.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel5.setIcon(new javax.swing.ImageIcon(getClass().getResource("/diseños/logo.png"))); // NOI18N

        labelTurno1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        labelTurno1.setText("Pac-Man");
        labelTurno1.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        labelTurno1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                labelTurno1MouseClicked(evt);
            }
        });

        labelTurno2.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        labelTurno2.setText("Fantasma");
        labelTurno2.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        labelTurno2.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                labelTurno2MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(77, 77, 77)
                        .addComponent(labelTurno1, javax.swing.GroupLayout.PREFERRED_SIZE, 61, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(label2jugadores)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(labelJugador)
                                .addGap(32, 32, 32)
                                .addComponent(labelTurno2, javax.swing.GroupLayout.PREFERRED_SIZE, 64, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGap(88, 88, 88))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(labelInstrucciones, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                                .addComponent(jLabel5)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 214, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(0, 0, Short.MAX_VALUE)))
                        .addContainerGap())))
            .addGroup(layout.createSequentialGroup()
                .addGap(163, 163, 163)
                .addComponent(botonInicar)
                .addGap(0, 0, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 70, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel5, javax.swing.GroupLayout.PREFERRED_SIZE, 65, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(botonInicar)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(labelInstrucciones)
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(labelJugador)
                    .addComponent(labelTurno1)
                    .addComponent(labelTurno2))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(label2jugadores)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void botonInicarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_botonInicarActionPerformed
        this.botonInicar.setVisible(false);
        this.labelInstrucciones.setVisible(true);
        this.label2jugadores.setVisible(true);
        this.labelJugador.setVisible(true);
    }//GEN-LAST:event_botonInicarActionPerformed

    private void labelJugadorMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_labelJugadorMouseClicked
      this.labelInstrucciones.setText("Elige tu avatar");
        this.labelJugador.setVisible(false);
        this.label2jugadores.setVisible(false);
        this.labelTurno1.setVisible(true);
        this.labelTurno2.setVisible(true);
        
    }//GEN-LAST:event_labelJugadorMouseClicked

    private void label2jugadoresMousePressed(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_label2jugadoresMousePressed
        // TODO add your handling code here:
        tableroGrafico tab = new tableroGrafico(tiposJuego.DOS_JUGADORES,this, null);
        tab.setVisible(true);
        
        this.acomodoInicial();
    }//GEN-LAST:event_label2jugadoresMousePressed

    private void labelTurno1MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_labelTurno1MouseClicked
        // TODO add your handling code here:
        tableroGrafico tab = new tableroGrafico(tiposJuego.UN_JUGADOR,this, tiposJugadores.CIRCULOS);
        tab.setVisible(true);
        
        this.acomodoInicial();
    }//GEN-LAST:event_labelTurno1MouseClicked

    private void labelTurno2MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_labelTurno2MouseClicked
        // TODO add your handling code here:
        tableroGrafico tab = new tableroGrafico(tiposJuego.UN_JUGADOR,this, tiposJugadores.CRUZES);
        tab.setVisible(true);
        
        this.acomodoInicial();
    }//GEN-LAST:event_labelTurno2MouseClicked

    

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton botonInicar;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel label2jugadores;
    private javax.swing.JLabel labelInstrucciones;
    private javax.swing.JLabel labelJugador;
    private javax.swing.JLabel labelTurno1;
    private javax.swing.JLabel labelTurno2;
    // End of variables declaration//GEN-END:variables
}
