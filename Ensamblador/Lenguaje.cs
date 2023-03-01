using System; 
using System.Collections.Generic;
using System.Text;
using System.Linq;

//o Requerimiento 1: Progrmar el residuo de la division en porFactor (para c y ensamblador)
//                  y hacer un salto de linea cuando se imprima un \n
//o Requerimiento 2: Programar en ensamblador el else, SERA NECESARIO AGREGAR ETIQUETAS
//o Requerimiento 3: Agregar en ensamblador la negacion de condicion
//o Requerimiento 4: Declarar variables en el for (int i )
//o Requerimiento 5: Actualizar la variable del for con += y -=


namespace Ensamblador
{
    class Lenguaje : Sintaxis
    {
        Stack s;
        ListaVariables l;
        Variable.tipo maxBytes;
        int numeroIf, numeroFor, numeroElse, numeroConj_If_Else;
        string condicionElse;
        public Lenguaje()
        {
            s = new Stack(5);
            l = new ListaVariables();
            numeroConj_If_Else = numeroElse = numeroFor = numeroIf = 0;
            condicionElse = "";
            Console.WriteLine("Iniciando analisis gramatical.");
        }

        public Lenguaje(string nombre) : base(nombre)
        {
            s = new Stack(5);
            l = new ListaVariables();
            numeroConj_If_Else = numeroElse = numeroFor = numeroIf = 0;
            condicionElse = "";
            Console.WriteLine("Iniciando analisis gramatical.");
        }

        // Programa -> Libreria Main
        public void Programa()
        {
            asm.WriteLine("include \"emu8086.inc\"");
            asm.WriteLine("org 100h");
            Libreria();
            Main();
            asm.WriteLine("ret");
            asm.WriteLine("define_print_string");
            asm.WriteLine("define_print_num");
            asm.WriteLine("define_print_num_uns");
            asm.WriteLine("define_scan_num");
            asm.WriteLine("; Variables");
            l.imprime(bitacora, asm);

        }

        // Libreria -> (#include <identificador(.h)?> Libreria) ?
        private void Libreria()
        {
            if (getContenido() == "#")
            {
                match("#");
                match("include");
                match("<");
                match(clasificaciones.identificador);

                if (getContenido() == ".")
                {
                    match(".");
                    match("h");
                }

                match(">");

                Libreria();
            }
        }

        // Main -> tipoDato main() BloqueInstrucciones 
        private void Main()
        {
            match(clasificaciones.tipoDato);
            match("main");
            match("(");
            match(")");

            BloqueInstrucciones(true);
        }

        // BloqueInstrucciones -> { Instrucciones }
        private void BloqueInstrucciones(bool ejecuta)
        {
            match(clasificaciones.inicioBloque);

            Instrucciones(ejecuta);

            match(clasificaciones.finBloque);
        }

        // Lista_IDs -> identificador (= Expresion)? (,Lista_IDs)? 
        private void Lista_IDs(Variable.tipo tipoDato, bool ejecuta)
        {
            string nombre = getContenido();
            match(clasificaciones.identificador); 

            if (!l.Existe(nombre))
            {
                l.Inserta(nombre, tipoDato);
            }
            else
            {
                throw new Error(bitacora, "Error de sintaxis: Variable duplicada (" + nombre + ") " + "(" + linea + ", " + caracter + ")");
            }
            
            if (getClasificacion() == clasificaciones.asignacion)
            {
                match(clasificaciones.asignacion);
                string contenido = getContenido(); 

                if(getClasificacion()==clasificaciones.cadena){
                    if(tipoDato == Variable.tipo.STRING){
                        match(clasificaciones.cadena);
                        if (ejecuta)
                        {
                            l.setValor(nombre, contenido);    
                        }
                    }
                    else{
                        throw new Error(bitacora, "Error semantico: No se puede asignar un STRING a un (" + tipoDato + ") " + "(" + linea + ", " + caracter + ")");
                    }
                    
                }else
                {
                   //Requerimiento 3
                    maxBytes=Variable.tipo.CHAR;
                    Expresion();
                    float valor =  s.pop(bitacora, linea, caracter);
                    asm.WriteLine("\tPOP CX");

                    if(tipoDatoExpresion(valor) > maxBytes){
                        maxBytes=tipoDatoExpresion(valor);
                    }

                    if(tipoDato == Variable.tipo.STRING){
                        throw new Error(bitacora, "Error semantico: No se puede asignar un "+ maxBytes +" a un (" + tipoDato + ") " + "(" + linea + ", " + caracter + ")");
                    }
                    if(maxBytes > l.getTipoDato(nombre)){
                        throw new Error(bitacora,  "Error semantico: No se puede asignar un "+ maxBytes +" a un (" + l.getTipoDato(nombre) + ") " + "(" + linea + ", " + caracter + ")");
                    }

                    if (ejecuta)
                    {
                        asm.WriteLine("\tMOV " + nombre + ", CX");
                        l.setValor(nombre, valor.ToString());
                    }
                }
                
            }

            if (getContenido() == ",")
            {
                match(",");
                Lista_IDs(tipoDato, ejecuta);
            }
        }

        // Variables -> tipoDato Lista_IDs; 
        private void Variables(bool ejecuta)
        {
            Variable.tipo tipoDato=determinarTipoDato(getContenido());
            
            match(clasificaciones.tipoDato);
            Lista_IDs(tipoDato, ejecuta);
            match(clasificaciones.finSentencia);
        }

        // Instruccion -> (If | cin | cout | const | Variables | asignacion) ;
        private void Instruccion(bool ejecuta)
        {
            if (getContenido() == "do")
            {
                DoWhile(ejecuta);
            }
            else if (getContenido() == "while")
            {
                While(ejecuta);
            }
            else if (getContenido() == "for")
            {
                For(ejecuta);
            }
            else if (getContenido() == "if")
            {
                If(ejecuta);
            }
            else if (getContenido() == "cin")
            {
                //Requirimiento 4
                match("cin");
                match(clasificaciones.flujoEntrada);
                string nombre = getContenido();
                if (l.Existe(nombre))
                {
                    match(clasificaciones.identificador); 

                    asm.WriteLine("\tcall scan_num");
                    asm.WriteLine("\tMOV " + nombre + ", CX");
                    asm.WriteLine("\tprintn \"\"");

                    if(ejecuta){
                        reasignacion_cin(nombre);//Requirimiento 4
                    }
                }
                else
                {
                    throw new Error(bitacora, "Error de sintaxis: La variable "+ nombre +" no ha sido declarada." + "(" + linea + ", " + caracter + ")");
                }
                match(clasificaciones.finSentencia);
                
            }
            else if (getContenido() == "cout")
            {
                match("cout");
                ListaFlujoSalida(ejecuta);
                match(clasificaciones.finSentencia);
            }
            else if (getContenido() == "const")
            {
                Constante(ejecuta);
            }
            else if (getClasificacion() == clasificaciones.tipoDato)
            {
                Variables(ejecuta);
            }
            else
            {
                string nombre = getContenido();
                if (l.Existe(nombre))
                {
                    match(clasificaciones.identificador); 
                }
                else
                {
                    throw new Error(bitacora, "Error de sintaxis: La variable "+ nombre +" no ha sido declarada." + "(" + linea + ", " + caracter + ")");
                }

                match(clasificaciones.asignacion);
                string valor;
                //Requirimiento 2

                if (getClasificacion() == clasificaciones.cadena)
                {
                    if(l.getTipoDato(nombre) == Variable.tipo.STRING){
                        valor = getContenido();
                        match(clasificaciones.cadena);
                    }
                    else{
                        throw new Error(bitacora, "Error semantico: No se puede asignar un STRING a un (" + l.getTipoDato(nombre) + ") " + "(" + linea + ", " + caracter + ")");
                    }
                }
                else
                {
                    //Requirimiento 3
                    Expresion();
                    maxBytes=Variable.tipo.CHAR;
                    valor = s.pop(bitacora, linea, caracter).ToString();
                    asm.WriteLine("\tPOP CX");

                    if(tipoDatoExpresion(float.Parse(valor)) > maxBytes){
                        maxBytes=tipoDatoExpresion(float.Parse(valor));
                    }
                    
                    if(l.getTipoDato(nombre) == Variable.tipo.STRING){
                        throw new Error(bitacora, "Error semantico: No se puede asignar un "+ maxBytes +" a un (" + l.getTipoDato(nombre) + ") " + "(" + linea + ", " + caracter + ")");
                    }
                    if(maxBytes > l.getTipoDato(nombre)){
                        throw new Error(bitacora,  "Error semantico: No se puede asignar un "+ maxBytes +" a un (" + l.getTipoDato(nombre) + ") " + "(" + linea + ", " + caracter + ")");
                    }
                }
                asm.WriteLine("\tMOV " + nombre + ", CX");
                if(ejecuta)
                {
                    l.setValor(nombre, valor);
                }
                
                match(clasificaciones.finSentencia);
            }
        }

        // Instrucciones -> Instruccion Instrucciones?
        private void Instrucciones(bool ejecuta)
        {
            Instruccion(ejecuta);

            if (getClasificacion() != clasificaciones.finBloque)
            {
                Instrucciones(ejecuta);
            }
        }

        // Constante -> const tipoDato identificador = numero | cadena;
        private void Constante(bool ejecuta)
        {
            match("const");

            Variable.tipo tipoDato=determinarTipoDato(getContenido());
            
            match(clasificaciones.tipoDato);
            string nombre = getContenido();
            match(clasificaciones.identificador); 
            if (!l.Existe(nombre) && ejecuta)
            {
                l.Inserta(nombre, tipoDato, true);
            }
            else
            {
                throw new Error(bitacora, "Error de sintaxis: Variable duplicada (" + nombre + ") " + "(" + linea + ", " + caracter + ")");
            }

            match(clasificaciones.asignacion);
            string valor=getContenido();
            if (getClasificacion() == clasificaciones.numero)
            {
                match(clasificaciones.numero);
            }
            else
            {
                match(clasificaciones.cadena);
            }

            if(ejecuta){
                l.setValor(nombre,valor);
            }
            match(clasificaciones.finSentencia);
        }

        // ListaFlujoSalida -> << cadena | identificador | numero (ListaFlujoSalida)?
        private void ListaFlujoSalida(bool ejecuta)
        {
            match(clasificaciones.flujoSalida);

            if (getClasificacion() == clasificaciones.numero)
            {
                asm.WriteLine("MOV AX, " + getContenido());
                asm.WriteLine("call print_num");
                if (ejecuta)
                {
                    Console.Write(getContenido());   
                }
                match(clasificaciones.numero);
            }
            else if (getClasificacion() == clasificaciones.cadena)
            {
                //asm.WriteLine("\tprint " + getContenido());
                if(ejecuta){
                    imrpimir_String();
                }
                match(clasificaciones.cadena);
            }
            else
            {
                string nombre = getContenido();
                if (l.Existe(nombre))
                {
                    asm.WriteLine("MOV AX, " + nombre);
                    asm.WriteLine("call print_num");
                    if(ejecuta){
                        Console.Write(l.getValor(nombre));
                    }
                    match(clasificaciones.identificador); 
                }
                else
                {
                    throw new Error(bitacora, "Error de sintaxis: La variable "+ nombre +" no ha sido declarada." + "(" + linea + ", " + caracter + ")");
                }

            }

            if (getClasificacion() == clasificaciones.flujoSalida)
            {
                ListaFlujoSalida(ejecuta);
            }
        }

        // If -> if (Condicion) { BloqueInstrucciones } (else BloqueInstrucciones)?
        private void If(bool ejecuta2)
        {
            match("if");
            match("(");

            bool ejecuta;
            string etiquetaFinConjIfs = "endIfs" + numeroConj_If_Else;
            string etiquetaIf = "if" + numeroIf++;
            if(getContenido() == "!")
            {
                match("!");
                match("(");
                ejecuta = Condicion(etiquetaIf, true);
                ejecuta = !ejecuta;
                match(")");
            }
            else
            {
                ejecuta = Condicion(etiquetaIf);
            }

            match(")");
            BloqueInstrucciones(ejecuta && ejecuta2);

            //asm.WriteLine("JMP " + etiquetaFinConjIfs);

            //asm.WriteLine(etiquetaIf + ":");
            
            if (getContenido() == "else")
            {
                asm.WriteLine("JMP " + etiquetaFinConjIfs);
                asm.WriteLine(etiquetaIf + ":");
                
                match("else");

                if(getContenido() == "if")
                {
                    If(!ejecuta && ejecuta2);
                }
                else
                {
                    string etiquetaElse = "else" + numeroElse++;
                    asm.WriteLine("\tCMP CX, BX");
                    asm.WriteLine(condicionElse + etiquetaElse);
                    BloqueInstrucciones(!ejecuta && ejecuta2);

                    asm.WriteLine("JMP " + etiquetaFinConjIfs);
                    
                    asm.WriteLine(etiquetaElse + ":");

                    asm.WriteLine(etiquetaFinConjIfs + ":");

                    numeroConj_If_Else++;
                }
                
                
            }else
            {
                asm.WriteLine(etiquetaIf + ":");
            }
        }

        // Condicion -> Expresion operadorRelacional Expresion
        private bool Condicion(string etiqueta, bool condNegadaEns = false)//es true si la condicion es negada
        {
            maxBytes=Variable.tipo.CHAR;
            Expresion();
            float n1= s.pop(bitacora, linea, caracter);
            asm.WriteLine("\tPOP CX");
            string operador = getContenido();
            match(clasificaciones.operadorRelacional);
            maxBytes=Variable.tipo.CHAR;
            Expresion();
            float n2 = s.pop(bitacora, linea, caracter);
            asm.WriteLine("\tPOP BX");

            asm.WriteLine("\tCMP CX, BX");
            if(condNegadaEns)//lo unico que se modifica es la parte ensamblador
            {
                switch (operador)
                {
                    case ">":
                        asm.WriteLine("\tJG " + etiqueta);
                        condicionElse = "\tJLE ";
                        return n1>n2;
                    case ">=":
                        asm.WriteLine("\tJGE " + etiqueta);
                        condicionElse = "\tJL ";
                        return n1>=n2;
                    case "<":
                        asm.WriteLine("\tJL " + etiqueta);
                        condicionElse = "\tJGE ";
                        return n1<n2;
                    case "<=":
                        asm.WriteLine("\tJLE " + etiqueta);
                        condicionElse = "\tJG ";
                        return n1<=n2;
                    case "==":
                        asm.WriteLine("\tJE " + etiqueta);
                        condicionElse = "\tJNE ";
                        return n1==n2;
                    default:
                        asm.WriteLine("\tJNE " + etiqueta);
                        condicionElse = "\tJE ";
                        return n1!=n2;
                }
            }
            else
            {
                switch (operador)
                {
                    case ">":
                        asm.WriteLine("\tJLE " + etiqueta);
                        condicionElse = "\tJG ";
                        return n1>n2;
                    case ">=":
                        asm.WriteLine("\tJL " + etiqueta);
                        condicionElse = "\tJGE ";
                        return n1>=n2;
                    case "<":
                        asm.WriteLine("\tJGE " + etiqueta);
                        condicionElse = "\tJL ";
                        return n1<n2;
                    case "<=":
                        asm.WriteLine("\tJG " + etiqueta);
                        condicionElse = "\tJLE ";
                        return n1<=n2;
                    case "==":
                        asm.WriteLine("\tJNE " + etiqueta);
                        condicionElse = "\tJE ";
                        return n1==n2;
                    default:
                        asm.WriteLine("\tJE " + etiqueta);
                        condicionElse = "\tJNE ";
                        return n1!=n2;
                }
            }
            
        }

        // x26 = (3+5)*8-(10-4)/2;
        // Expresion -> Termino MasTermino 
        private void Expresion()
        {
            Termino();
            MasTermino();
        }
        // MasTermino -> (operadorTermino Termino)?
        private void MasTermino()
        {
            if (getClasificacion() == clasificaciones.operadorTermino)
            {
                string operador = getContenido();
                match(clasificaciones.operadorTermino);
                Termino();
                float e1 = s.pop(bitacora, linea, caracter), e2 = s.pop(bitacora, linea, caracter);
                asm.WriteLine("\tPOP BX");
                asm.WriteLine("\tPOP AX");

                switch (operador)
                {
                    case "+":
                        asm.WriteLine("\tADD AX, BX");
                        s.push(e2 + e1, bitacora, linea, caracter);
                        asm.WriteLine("\tPUSH AX");
                        break;
                    case "-":
                        asm.WriteLine("\tSUB AX, BX");
                        s.push(e2 - e1, bitacora, linea, caracter);
                        asm.WriteLine("\tPUSH AX");
                        break;
                }
                s.display(bitacora);
            }
        }
        // Termino -> Factor PorFactor
        private void Termino()
        {
            Factor();
            PorFactor();
        }
        // PorFactor -> (operadorFactor Factor)?
        private void PorFactor()
        {
            if (getClasificacion() == clasificaciones.operadorFactor)
            {
                string operador = getContenido();
                match(clasificaciones.operadorFactor);
                Factor();
                float e1 = s.pop(bitacora, linea, caracter), e2 = s.pop(bitacora, linea, caracter);
                asm.WriteLine("\tPOP BX");
                asm.WriteLine("\tPOP AX");
                // Console.Write(operador + " ");

                switch (operador)
                {
                    case "*":
                        asm.WriteLine("\tMUL BX");
                        s.push(e2 * e1, bitacora, linea, caracter);
                        asm.WriteLine("\tPUSH AX");
                        break;
                    case "/":
                        asm.WriteLine("\tDIV BX");
                        s.push(e2 / e1, bitacora, linea, caracter);
                        asm.WriteLine("\tPUSH AX");
                        break;
                    case "%":
                        asm.WriteLine("\tDIV BX");
                        s.push(e2 % e1, bitacora, linea, caracter);
                        asm.WriteLine("\tPUSH DX");
                        break;
                }
                s.display(bitacora);
            }
        }
        // Factor -> identificador | numero | ( Expresion )
        private void Factor()
        {
            if (getClasificacion() == clasificaciones.identificador)
            {

                string nombre = getContenido();
                if (l.Existe(nombre))
                {
                    s.push(float.Parse(l.getValor(getContenido())), bitacora, linea, caracter);
                    asm.WriteLine("\tMOV AX, " + nombre);
                    asm.WriteLine("\tPUSH AX");
                    s.display(bitacora);
                    match(clasificaciones.identificador); 

                    if(l.getTipoDato(nombre)>maxBytes){
                        maxBytes = l.getTipoDato(nombre);
                    }
                }
                else
                {
                    throw new Error(bitacora, "Error de sintaxis: La variable " + nombre + " no ha sido declarada." + "(" + linea + ", " + caracter + ")");
                }
            }
            else if (getClasificacion() == clasificaciones.numero)
            {
                s.push(float.Parse(getContenido()), bitacora, linea, caracter);
                asm.WriteLine("\tMOV AX, " + getContenido());
                asm.WriteLine("\tPUSH AX");
                s.display(bitacora);
                
                
                if(tipoDatoExpresion(float.Parse(getContenido())) > maxBytes){
                    maxBytes = tipoDatoExpresion(float.Parse(getContenido()));
                }
                match(clasificaciones.numero);
            }
            else
            {
                match("(");
                bool huboCast=false;
                Variable.tipo tipoDato = Variable.tipo.CHAR;
                if(getClasificacion() == clasificaciones.tipoDato){
                    huboCast=true;
                    tipoDato = determinarTipoDato(getContenido());
                    match(clasificaciones.tipoDato);
                    match(")");
                    match("(");
                }
                Expresion();
                match(")");
                if(huboCast){
                    //Hacer un pop y convertir ese numero al tipo dato y meterlo al stack
                    float n1 = s.pop(bitacora, linea, caracter);
                    asm.WriteLine("\tPOP BX");
                    n1 = cast(n1, tipoDato);
                    s.push(n1,bitacora,linea,caracter);
                    asm.WriteLine("\tMOV AX, " + n1);
                    asm.WriteLine("\tPUSH AX");
                    maxBytes = tipoDato;
                }
            }
        }

        // For -> for (identificador = Expresion; Condicion; identificador incrementoTermino) BloqueInstrucciones
        private void For(bool ejecuta2)
        {
            match("for");

            match("(");

            bool ejecuta;
            string nombre;
            if(getClasificacion() == clasificaciones.tipoDato)
            {
                Variable.tipo tipoDato=determinarTipoDato(getContenido());
                match(clasificaciones.tipoDato);
                nombre = getContenido();
                match(clasificaciones.identificador); 

                if (!l.Existe(nombre))
                {
                    l.Inserta(nombre, tipoDato);
                }
                else
                {
                    throw new Error(bitacora, "Error de sintaxis: Variable duplicada (" + nombre + ") " + "(" + linea + ", " + caracter + ")");
                }
            }
            else
            {
                nombre = getContenido();
                if (l.Existe(nombre))
                {
                    match(clasificaciones.identificador); // Validar existencia
                }
                else
                {
                    throw new Error(bitacora, "Error de sintaxis: La variable " + nombre + " no ha sido declarada." + "(" + linea + ", " + caracter + ")");
                }
            }

            match(clasificaciones.asignacion);
            Expresion();
            maxBytes=Variable.tipo.CHAR;
            string valor = s.pop(bitacora, linea, caracter).ToString();
            asm.WriteLine("\tPOP CX");

            if(tipoDatoExpresion(float.Parse(valor)) > maxBytes){
                maxBytes=tipoDatoExpresion(float.Parse(valor));
            }
                    
            if(l.getTipoDato(nombre) == Variable.tipo.STRING){
                throw new Error(bitacora, "Error semantico: No se puede asignar un "+ maxBytes +" a un (" + l.getTipoDato(nombre) + ") " + "(" + linea + ", " + caracter + ")");
            }
            if(maxBytes > l.getTipoDato(nombre)){
                throw new Error(bitacora,  "Error semantico: No se puede asignar un "+ maxBytes +" a un (" + l.getTipoDato(nombre) + ") " + "(" + linea + ", " + caracter + ")");
            }
                
            asm.WriteLine("\tMOV " + nombre + ", CX");
            l.setValor(nombre, valor);
            
            match(clasificaciones.finSentencia);

            string etiquetaFin = "endFor" + numeroFor;
            string etiquetaInicio = "beginFor" + numeroFor++;
            asm.WriteLine(etiquetaInicio + ":");
            ejecuta = Condicion(etiquetaFin);
            match(clasificaciones.finSentencia);

            string nombre2 = getContenido();
            if (l.Existe(nombre2))
            {
                match(clasificaciones.identificador); // Validar existencia
            }
            else
            {
                throw new Error(bitacora, "Error de sintaxis: La variable " + nombre2 + " no ha sido declarada." + "(" + linea + ", " + caracter + ")");
            }


            string operador = getContenido();
            match(clasificaciones.incrementoTermino);

            if(operador == "++")
            {
                l.setValor(nombre2, (float.Parse(l.getValor(nombre2)) + 1).ToString());
                asm.WriteLine("\tINC " + nombre2);
            }
            else if(operador == "--")
            {
                l.setValor(nombre2, (float.Parse(l.getValor(nombre2)) - 1).ToString());    
                asm.WriteLine("\tDEC " + nombre2);
            }
            else if(operador == "+=")
            {
                string numero = getContenido();
                match(clasificaciones.numero);

                l.setValor(nombre2, (float.Parse(l.getValor(nombre2)) + float.Parse(numero)).ToString());    
                asm.WriteLine("\tADD " + nombre2 + ", " + numero);
            }
            else if(operador == "-=")
            {
                string numero = getContenido();
                match(clasificaciones.numero);

                l.setValor(nombre2, (float.Parse(l.getValor(nombre2)) - float.Parse(numero)).ToString());    
                asm.WriteLine("\tSUB " + nombre2 + ", " + numero);
            }

            match(")");

            BloqueInstrucciones(ejecuta && ejecuta2);
            asm.WriteLine("JMP " + etiquetaInicio);

            asm.WriteLine(etiquetaFin + ":");
        }

        // While -> while (Condicion) BloqueInstrucciones
        private void While(bool ejecuta)
        {
            match("while");

            match("(");
            Condicion("");
            match(")");

            BloqueInstrucciones(ejecuta);
        }

        // DoWhile -> do BloqueInstrucciones while (Condicion);
        private void DoWhile(bool ejecuta)
        {
            match("do");

            BloqueInstrucciones(ejecuta);

            match("while");

            match("(");
            Condicion("");
            match(")");
            match(clasificaciones.finSentencia);
        }

        // x26 = (3 + 5) * 8 - (10 - 4) / 2
        // x26 = 3 + 5 * 8 - 10 - 4 / 2
        // x26 = 3 5 + 8 * 10 4 - 2 / -
        private void imrpimir_String()
        {
            string contenidoLimpio = getContenido();
            contenidoLimpio = contenidoLimpio.Substring(1);//elimina comilla de inicio
            contenidoLimpio = contenidoLimpio.Remove(contenidoLimpio.Length - 1);//elimina comilla final
            string auxEns = "";
            for (int i = 0; i < contenidoLimpio.Length; i++)
            {
                if (contenidoLimpio[i] == '\\')
                {
                    if (contenidoLimpio[i + 1] == 'n')
                    {
                        Console.Write("\n");
                        i++;

                        asm.WriteLine("\tprint \"" + auxEns + "\"");
                        auxEns = "";
                        /*asm.WriteLine("\tMOV AH, 2");
                        asm.WriteLine("\tMOV DL, 0Dh");
                        asm.WriteLine("\tINT 21h");
                        asm.WriteLine("\tMOV AH, 2");
                        asm.WriteLine("\tMOV DL, 0Ah");
                        asm.WriteLine("\tINT 21h");*/
                        asm.WriteLine("\tprintn \"\"");
                        continue;
                    }
                    else if (contenidoLimpio[i + 1] == 't')
                    {
                        Console.Write("\t");
                        i++;
                        continue;
                    }
                    else if (contenidoLimpio[i + 1] == '\\')
                    {
                        Console.Write("\\");
                        i++;
                        continue;
                    }
                    throw new Error(bitacora, "Error: El caracter \\ no se reconoce (" + linea + ", " + caracter + ")");
                }
                Console.Write(contenidoLimpio[i]);
                auxEns = auxEns + contenidoLimpio[i];
            }
            asm.WriteLine("\tprint \"" + auxEns + "\"");
        }
        private void reasignacion_cin(string nombre)
        {
            String valorLeido = Console.ReadLine();
            if(valorLeido.All(char.IsDigit))
            {
               maxBytes = tipoDatoExpresion(float.Parse(valorLeido));
               if(maxBytes > l.getTipoDato(nombre))
                {
                    throw new Error(bitacora,  "Error semantico: No se puede asignar un "+ maxBytes +" a un (" + l.getTipoDato(nombre) + ") " + "(" + linea + ", " + caracter + ")");
                }
            }
            else
            {
                if(!(l.getTipoDato(nombre) == Variable.tipo.STRING)){
                    throw new Error(bitacora, "Error semantico: No se puede asignar un STRING a un (" + l.getTipoDato(nombre) + ") " + "(" + linea + ", " + caracter + ")");
                }    
            }
            
            
            l.setValor(nombre, valorLeido);
        }

        private Variable.tipo determinarTipoDato(string tipoDato){
            Variable.tipo tipoVar;
            switch (tipoDato)
            {
                case "int":
                    tipoVar=Variable.tipo.INT;
                    break;
                case "float":
                    tipoVar=Variable.tipo.FLOAT;
                    break;
                case "string":
                    tipoVar=Variable.tipo.STRING;
                    break;
                default:
                    tipoVar=Variable.tipo.CHAR;
                    break;
            }
            return tipoVar;
        }

        private Variable.tipo tipoDatoExpresion(float valor){
            if(valor % 1 != 0)
            {
                return Variable.tipo.FLOAT;
            }
            else if(valor <256)
            {
                return Variable.tipo.CHAR;
            }
            else if(valor < 65535)
            {
                return Variable.tipo.INT;
            }
            
            return Variable.tipo.FLOAT;
        }

        private float cast(float n1, Variable.tipo tipoDato){
            float n2;
            //para convertir un entero a char necesitamos dividir entre 256 y el residuo es el resultado del cast
            // 256=0 257=1 258=2
            //o para convertir un float a entero necesitamos dividir entre 65536 y el residuo es el resultado del cast
            //o para convertir un float a otro tipo de dato redondear el numero para eliminar la parte fraccional 
            //o para convertir un float a char necesitamos dividir entre 65536 entre 256 y el residuo es el resultado del cast
            //o para convertir a float n1=n1

           switch (tipoDato)
            {
                case Variable.tipo.CHAR:
                {
                    n1= n1 - (n1 % 1);
                    n2 = (n1%65536)%256;
                }
                break;
                
                case Variable.tipo.INT:
                {
                    n1= n1 - (n1 % 1);
                    n2= (n1%65536);
                }
                break;
                
                default://float
                {
                    n2=n1;
                }
                break;
            }
            return n2;
        }
    }
}