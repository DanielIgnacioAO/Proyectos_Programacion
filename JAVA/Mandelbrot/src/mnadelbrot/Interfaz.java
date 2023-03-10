/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mnadelbrot;

import java.awt.Color;
import java.awt.Graphics;

/**
 *
 * @author danny
 */
public class Interfaz extends javax.swing.JFrame {
    Graphics g;
    int color=0;
    /**
     * Creates new form Interfaz
     */
    public Interfaz() {
        initComponents();
        g = this.panel.getGraphics();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jButton1 = new javax.swing.JButton();
        panel = new java.awt.Panel();
        Colores = new javax.swing.JComboBox<>();
        jLabel1 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Conjunto de Mandelbrot");
        setBackground(new java.awt.Color(51, 255, 255));

        jButton1.setText("Dibujar / Redibujar");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout panelLayout = new javax.swing.GroupLayout(panel);
        panel.setLayout(panelLayout);
        panelLayout.setHorizontalGroup(
            panelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 700, Short.MAX_VALUE)
        );
        panelLayout.setVerticalGroup(
            panelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 500, Short.MAX_VALUE)
        );

        Colores.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Multicolor", "Verde", "Azul", "Rojo" }));
        Colores.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                ColoresItemStateChanged(evt);
            }
        });

        jLabel1.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        jLabel1.setText("Color");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jButton1)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 48, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(Colores, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(panel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(0, 0, Short.MAX_VALUE)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 36, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(Colores, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(panel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        // TODO add your handling code here:
        this.panel.update(g);
        int i, j, n, h, w;
        double x, y, cx, cy, xt, yt;
        //ayuda a centrarlo
        h = (this.panel.getHeight() / 2);
        w = (this.panel.getWidth() / 2);
        
        for (i = 0; i < getHeight(); i++) {
            for (j = 0; j < getWidth(); j++) {
                //punto C, para la sucesion Z0=C, Z(n+1)=Zn^2 + C
                cx = (j - w) / 200.0 - 0.7;//ayuda a hacer "zoom" y centrar sobre x
                cy = (i - h) / 200.0;//ayuda a hacer "zoom" y centrar sobre y
                x = 0;
                y = 0;
                n = 0;
                //p=100, maximo de iteraciones para la sucesion Z
                while (n < 100 && x * x + y * y < 4) {//pertenece
                    xt = x * x - y * y + cx;
                    yt = 2 * x * y + cy;
                    x = xt;
                    y = yt;
                    n++;
                }
                if (n < 100) {
                    switch(this.color){
                        case 0:
                            g.setColor(new Color((int)(n * (Math.random()*(50)+1) % 209),(int)(n * (Math.random()*(50)+50) % 209), (int)(n * (Math.random()*(100)+100) % 209)));
                            break;
                        case 1:g.setColor(new Color(0, 255 - (n * 16) % 256, n * 2));
                            break;
                        case 2:g.setColor(new Color(n*2, 255 - (n * 16) % 256, 240));
                            break;
                        case 3:g.setColor(new Color(240, (255 - (n * 16) % 256), n*2));
                            break;
                    }
                    
                    //
                    //
                    g.fillRect(j, i, 1, 1);
                }
            }
        }
    }//GEN-LAST:event_jButton1ActionPerformed

    private void ColoresItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_ColoresItemStateChanged
        // TODO add your handling code here:
        if(evt.getSource()==Colores){
            String valor =(String)Colores.getSelectedItem();
            switch(valor){
                case "Verde":
                        this.color=1;
                    break;
                case "Azul":
                        this.color=2;
                    break;
                case "Rojo":
                        this.color=3;
                    break;
                default:
                        this.color=0;
                    break;
            }
        }
    }//GEN-LAST:event_ColoresItemStateChanged

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Interfaz.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Interfaz.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Interfaz.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Interfaz.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Interfaz().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<String> Colores;
    private javax.swing.JButton jButton1;
    private javax.swing.JLabel jLabel1;
    private java.awt.Panel panel;
    // End of variables declaration//GEN-END:variables
}
