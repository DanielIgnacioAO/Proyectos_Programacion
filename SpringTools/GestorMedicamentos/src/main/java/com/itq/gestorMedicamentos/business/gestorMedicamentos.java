/**
 * 
 */
package com.itq.gestorMedicamentos.business;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.itq.gestorMedicamentos.dto.Ack;
import com.itq.gestorMedicamentos.dto.ActualizarMedicamento;
import com.itq.gestorMedicamentos.dto.ApartarMedicamento;
import com.itq.gestorMedicamentos.dto.Medicamento;
import com.itq.gestorMedicamentos.dto.NombreMedicamentoConsulta;
import com.itq.gestorMedicamentos.dto.NombreMedicamentoEliminar;

/**
 * @author al082
 *
 */
@Component
public class gestorMedicamentos {
	Map<Medicamento, Integer> medicamentos = new HashMap<Medicamento, Integer>();
	Map<Medicamento, Integer> apartados = new HashMap<Medicamento, Integer>();
	
	public Ack insertMedicamento(Medicamento medicamento) {
		Ack ack = new Ack();
		boolean repetido = false;
		
		if(medicamentos.isEmpty()) {
			medicamentos.put(medicamento, 10);
			ack.setDescription("Se ha insertado 10 unidad de " + medicamento.getNombre());
			System.out.println("Se ha insertado 10 unidad de " + medicamento.getNombre());
		} else {
			for(Map.Entry<Medicamento, Integer> set : medicamentos.entrySet()) {
				if(set.getKey().getNombre().equals(medicamento.getNombre().toString())) {
					ack.setDescription("Error: Medicamento repetido");
					System.out.println("Error: Medicamento repetido");
					repetido = true;
					break;
				}
			}
			
			if(!repetido) {
				medicamentos.put(medicamento, 10);
				ack.setDescription("Se ha insertado 10 unidad de " + medicamento.getNombre());
				System.out.println("Se ha insertado 10 unidad de " + medicamento.getNombre());
			}
		}
		System.out.println();
		for(Map.Entry<Medicamento, Integer> set : medicamentos.entrySet()) {
			System.out.println(set.getKey().getNombre() + " " + set.getKey().getNombre() + " " + set.getKey().getContenido());
		}
			
		ack.setCode(0);	
		return ack;
	}

	public Ack deleteMedicamento(NombreMedicamentoEliminar medicamento) {
		Ack ack = new Ack();
		boolean encontrado=false;
		if(!medicamentos.isEmpty()) {
			for(Map.Entry<Medicamento, Integer> set : medicamentos.entrySet()) {
				if(set.getKey().getNombre().equals(medicamento.getNombre().toString())) {
					medicamentos.remove(set.getKey());
					ack.setDescription("Medicamento removido");
					System.out.println("Medicamento removido");
					encontrado = true;
					break;
				}
			}
			if(!encontrado) {
				ack.setDescription("No hay medicamentos para eliminar");
				System.out.println("No hay medicamentos para eliminar");
			}	
		
		}else {
			ack.setDescription("No hay medicamentos registrados");
			System.out.println("No hay medicamentos registrados");
		}
		ack.setCode(0);
		return ack;
	}
	
	public Ack consultarMedicamento(NombreMedicamentoConsulta medicamento) {
		Ack ack = new Ack();
		
		boolean existe = false;
		
		for(Map.Entry<Medicamento, Integer> set : medicamentos.entrySet()) {
			if(set.getKey().getNombre().equals(medicamento.getNombre().toString())) {
				ack.setDescription("\nMedicamento: " + medicamento.getNombre() + 
						"\nMarca: "+ set.getKey().getMarca() +
						"\nCaducidad: " + set.getKey().getFechaCaducidad().getDia() + "-" + set.getKey().getFechaCaducidad().getMes() + "-" + set.getKey().getFechaCaducidad().getAnio() +
						"\nContenido: " + set.getKey().getContenido() +
						"\nExistencias: " + set.getValue() + "\n");
				System.out.println("Medicamento: " + medicamento.getNombre() + " -- Existencias: " + set.getValue());
				existe = true;
				break;
			}
		}
		
		if(!existe) {
			ack.setDescription("Medicamento no encontrado");
			System.out.println("Medicamento no encontrado");
		}
		
		ack.setCode(0);

		return ack;
	}
	
	public Ack actualizarMedicamento(ActualizarMedicamento medicamento) {
		Ack ack = new Ack();
		
		boolean existe = false;
		
		for(Map.Entry<Medicamento, Integer> set : medicamentos.entrySet()) {
			if(set.getKey().getNombre().equals(medicamento.getNombre().toString())) {
				set.getKey().setNombre(medicamento.getNombre());
				set.getKey().setContenido(medicamento.getContenido());
				set.getKey().setMarca(medicamento.getMarca());
				ack.setDescription("Medicamento actualizado");
				System.out.println("Medicamento actualizado");
				existe = true;
				break;
			}
		}
		
		if(!existe) {
			ack.setDescription("Medicamento no encontrado");
			System.out.println("Medicamento no encontrado");
		}

		ack.setCode(0);

		return ack;
	}
	
	public Ack apartarMedicamento(ApartarMedicamento medicamento) {
		Ack ack = new Ack();
		int cantidad = medicamento.getCantidad();
		boolean existe = false;
		
		for(Map.Entry<Medicamento, Integer> set : medicamentos.entrySet()) {
			if (set.getKey().getNombre().equals(medicamento.getNombre().toString())) {
				existe = true;
				if(cantidad > set.getValue()) {
					ack.setDescription("No hay suficientes existencias");
			        System.out.println("No hay suficientes existencias");
					break;
				}
				medicamentos.replace(set.getKey(), set.getValue(), set.getValue() - cantidad);
		        ack.setDescription("Listo!, medicamentos apartados");
		        System.out.println("Listo!, medicamentos apartados");
		        break;
		    }
		}
		
		if(!existe) {
			ack.setDescription("Medicamento no encontrado");
			System.out.println("Medicamento no encontrado");
		}
		
		ack.setCode(0);

		return ack;
	}
}