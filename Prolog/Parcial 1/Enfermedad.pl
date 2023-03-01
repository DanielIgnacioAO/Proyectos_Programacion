/******************************************************
    Programa: Enfermedad.pl
    Funcion:  Sistema experto para diagnostico de
              enfermedades
              Extender al menos a 10 enfermedades
******************************************************/

main :-
    write('Responde con si o no las siguientes preguntas:'),nl,
    pregunta('Estornudas? ',estornudo),
    pregunta('Toses? ',tos),
    pregunta('Tienes tos seca?',tosSeca),
    pregunta('Te duele la cabeza? ',dolorCab),
    pregunta('Tienes congestion nasal? ',congestion),
    pregunta('Te duele la garganta? ',dolorGarganta),
    pregunta('Te duele el oido? ',dolorOido),
    pregunta('Tienes fiebre? ',fiebre),
    pregunta('Te duele el cuerpo? ',dolorCuerpo),
    pregunta('Te duele o sientes presion en la cara? ',dolorCara),
    pregunta('Tienes dificultad para respirar? ',difRespirar),
    pregunta('Sientes presion en el pecho? ', presionPecho),
    pregunta('Haces sonidos raros al respirar, como silbidos?',silbidos),
    pregunta('Has tosido flemas con sangre?', flemaSangre),
    pregunta('Tienes problemas para tragar?',difTragar),
    pregunta('Tienes el cuello hinchado?',cuelloHinchado),
    pregunta('Tienes dolor toracico?',dolorTorax),

    nl,write('Tus posibles causas son: '),nl,
    diagnosticoInflu(),
    diagnosticoMigrana(),
    diagnosticoResfriadoComun(),
    diagnosticoInfecOido(),
    diagnosticoSinusitis(),
    diagnosticoAsma(),
    diagnosticoBronqui(),
    diagnosticoCancerLarin(),
    diagnosticoEmbolia(),
    diagnosticoNeumonia(),
    retiraHechos().

retiraHechos() :-
    retractall(sintoma(_)).

pregunta(Pregunta,Sintoma) :-
    write(Pregunta), read(Resp), procesa(Resp,Sintoma).

procesa(si,Sintoma) :-
    !, assert(sintoma(Sintoma)).
procesa(_,_).


/*Enfermedades*/

diagnosticoInflu() :-
    sintoma(fiebre), sintoma(tos),sintoma(dolorGarganta),sintoma(congestion),sintoma(dolorCuerpo),!, 
    write('Enfermedad: Influenza'), nl.
diagnosticoInflu().

diagnosticoMigrana() :-
    sintoma(dolorCab), !,
    write('Enfermedad: Migrana'), nl.
diagnosticoMigrana().

diagnosticoResfriadoComun():-
    sintoma(estornudo),sintoma(congestion),sintoma(dolorGarganta),sintoma(tos),!,
    write('Enfermedad: Resfriado comun'),nl.
diagnosticoResfriadoComun().

diagnosticoInfecOido():-
    sintoma(dolorOido),sintoma(fiebre),!,
    write('Enfermedad: Infeccion de Oido'),nl.
diagnosticoInfecOido().

diagnosticoSinusitis():-
    sintoma(dolorCab), sintoma(congestion), sintoma(dolorCara),!,
    write('Enfermedad: Sinusitis'),nl.
diagnosticoSinusitis().

diagnosticoAsma():-
    sintoma(tos), sintoma(presionPecho), sintoma(difRespirar),sintoma(silbidos),!,
    write('Enfermedad: Asma'),nl.
diagnosticoAsma().

diagnosticoBronqui():-
    sintoma(tos), sintoma(congestion), sintoma(difRespirar),sintoma(silbidos),!,
    write('Enfermedad: Bronquitis'),nl.
diagnosticoBronqui().

diagnosticoCancerLarin():-
    sintoma(tos), sintoma(silbidos), sintoma(flemaSangre), sintoma(difTragar),sintoma(dolorGarganta),sintoma(cuelloHinchado),!,
    write('Enfermedad: Cancer de Laringe y garganta'), nl.
diagnosticoCancerLarin().

diagnosticoEmbolia():-
    sintoma(flemaSangre), sintoma(difRespirar),sintoma(dolorTorax),!,
    write('Enfermedad: Embolia pulmonar'),nl.
diagnosticoEmbolia().

diagnosticoNeumonia():-
    sintoma(tosSeca), sintoma(fiebre), sintoma(dolorCuerpo), sintoma(dolorCab), sintoma(dolorTorax),!,
    write('Enfermedad: Neumonia'),nl.
diagnosticoNeumonia().