//
// Este archivo ha sido generado por la arquitectura JavaTM para la implantación de la referencia de enlace (JAXB) XML v2.3.2 
// Visite <a href="https://javaee.github.io/jaxb-v2/">https://javaee.github.io/jaxb-v2/</a> 
// Todas las modificaciones realizadas en este archivo se perderán si se vuelve a compilar el esquema de origen. 
// Generado el: 2022.10.18 a las 08:12:06 AM CDT 
//


package com.itq.gestorMedicamentos.dto;

import javax.xml.bind.annotation.XmlRegistry;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.itq.gestorMedicamentos.dto package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {


    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.itq.gestorMedicamentos.dto
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link Medicamento }
     * 
     */
    public Medicamento createMedicamento() {
        return new Medicamento();
    }

    /**
     * Create an instance of {@link ActualizarMedicamento }
     * 
     */
    public ActualizarMedicamento createActualizarMedicamento() {
        return new ActualizarMedicamento();
    }

    /**
     * Create an instance of {@link Pacientes }
     * 
     */
    public Pacientes createPacientes() {
        return new Pacientes();
    }

    /**
     * Create an instance of {@link Pacientes.Paciente }
     * 
     */
    public Pacientes.Paciente createPacientesPaciente() {
        return new Pacientes.Paciente();
    }

    /**
     * Create an instance of {@link Ack }
     * 
     */
    public Ack createAck() {
        return new Ack();
    }

    /**
     * Create an instance of {@link Medicamento.FechaCaducidad }
     * 
     */
    public Medicamento.FechaCaducidad createMedicamentoFechaCaducidad() {
        return new Medicamento.FechaCaducidad();
    }

    /**
     * Create an instance of {@link NombreMedicamentoEliminar }
     * 
     */
    public NombreMedicamentoEliminar createNombreMedicamentoEliminar() {
        return new NombreMedicamentoEliminar();
    }

    /**
     * Create an instance of {@link NombreMedicamentoConsulta }
     * 
     */
    public NombreMedicamentoConsulta createNombreMedicamentoConsulta() {
        return new NombreMedicamentoConsulta();
    }

    /**
     * Create an instance of {@link ActualizarMedicamento.FechaCaducidad }
     * 
     */
    public ActualizarMedicamento.FechaCaducidad createActualizarMedicamentoFechaCaducidad() {
        return new ActualizarMedicamento.FechaCaducidad();
    }

    /**
     * Create an instance of {@link ApartarMedicamento }
     * 
     */
    public ApartarMedicamento createApartarMedicamento() {
        return new ApartarMedicamento();
    }

    /**
     * Create an instance of {@link Medico }
     * 
     */
    public Medico createMedico() {
        return new Medico();
    }

    /**
     * Create an instance of {@link Pacientes.Paciente.Nombre }
     * 
     */
    public Pacientes.Paciente.Nombre createPacientesPacienteNombre() {
        return new Pacientes.Paciente.Nombre();
    }

}
