package sierspinki;

import java.awt.Graphics;
import sun.misc.JavaAWTAccess;

/**
 *
 * @author danny
 */
public class Interfaz extends javax.swing.JFrame {
    Graphics g;
    public int iteraciones;
    
    public Interfaz() {
        this.iteraciones=500;
        initComponents();
        g = this.getGraphics();
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jButton1 = new javax.swing.JButton();
        NumIte = new javax.swing.JComboBox<>();
        jLabel1 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Triángulo de Sierpinski");
        setPreferredSize(new java.awt.Dimension(600, 600));

        jButton1.setText("Dibujar / Redibujar");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        NumIte.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "500", "1000", "1500", "2000", "2500", "3000", "3500", "4000", "5000", "6000", "7000", "8000", "9000", "10000", "20000", "30000" }));
        NumIte.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                NumIteItemStateChanged(evt);
            }
        });

        jLabel1.setText("Numero de Iteraciones");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 148, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 323, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel1, javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(NumIte, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 41, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(NumIte, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(548, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
                update(g);
                //System.out.println(this.iteraciones);
                //random * (max-min) + min
                //paso 1
		Triangulos tri = new Triangulos();
                int x1 = (int)(Math.random()*(175-25)+25);
                int x2 = (int)(Math.random()*(375-225)+225);
                int x3 = (int)(Math.random()*(575-425)+425);
                int y1 = (int)(Math.random()*(550-350)+350);
                int y2 = (int)(Math.random()*(250-50)+50);
                int y3 = (int)(Math.random()*(550-350)+350);
                
                tri.dibujarTri(g, this.iteraciones, x1, y1, x2, y2, x3, y3);
                
    }//GEN-LAST:event_jButton1ActionPerformed

    private void NumIteItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_NumIteItemStateChanged
        // TODO add your handling code here:
        if(evt.getSource()==NumIte){
            String valor =(String)NumIte.getSelectedItem();
            int num = Integer.parseInt(valor);
            this.iteraciones=num;
        }
    }//GEN-LAST:event_NumIteItemStateChanged


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<String> NumIte;
    private javax.swing.JButton jButton1;
    private javax.swing.JLabel jLabel1;
    // End of variables declaration//GEN-END:variables

}
