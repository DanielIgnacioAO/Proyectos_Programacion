/**
 * 
 */
package com.itq.gestorMedicamentos.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ws.server.endpoint.annotation.Endpoint;
import org.springframework.ws.server.endpoint.annotation.PayloadRoot;
import org.springframework.ws.server.endpoint.annotation.RequestPayload;
import org.springframework.ws.server.endpoint.annotation.ResponsePayload;

import com.itq.gestorMedicamentos.business.gestorMedicamentos;
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
@Endpoint
public class MedicamentosEndpoint {
	@Autowired gestorMedicamentos gestorMedicamento;
	
	private static final String NAMESPACE_URI = "http://com.medicamento";
	
	@PayloadRoot(namespace = NAMESPACE_URI, localPart = "medicamento")
	@ResponsePayload
	public Ack medicamentoRegistration(@RequestPayload Medicamento request) {
		Ack response = gestorMedicamento.insertMedicamento(request); 
		return response;	
	}
	
	@PayloadRoot(namespace = NAMESPACE_URI, localPart = "nombreMedicamentoEliminar")
	@ResponsePayload
	public Ack medicamentoEliminar(@RequestPayload NombreMedicamentoEliminar request) {
		Ack response = gestorMedicamento.deleteMedicamento(request); 
		return response;	
	}
	
	@PayloadRoot(namespace = NAMESPACE_URI, localPart = "nombreMedicamentoConsulta")
	@ResponsePayload
	public Ack medicamentoConsulta(@RequestPayload NombreMedicamentoConsulta request) {
		Ack response = gestorMedicamento.consultarMedicamento(request); 
		return response;	
	}
	
	@PayloadRoot(namespace = NAMESPACE_URI, localPart = "actualizarMedicamento")
	@ResponsePayload
	public Ack medicamentoActualizar(@RequestPayload ActualizarMedicamento request) {
		Ack response = gestorMedicamento.actualizarMedicamento(request); 
		return response;	
	}

	@PayloadRoot(namespace = NAMESPACE_URI, localPart = "apartarMedicamento")
	@ResponsePayload
	public Ack medicamentoApartar(@RequestPayload ApartarMedicamento request) {
		Ack response = gestorMedicamento.apartarMedicamento(request); 
		return response;	
	}
}


