using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace Expresiones_Logicas
{
    public class Analizador
    {
        private double numeroVariables;
        private List<Char> listaVariables;
        string expresion, expresionPost;
        const int F = -1;
        const int E = -2;

        int[,] trand = {
        /*
        - negacion
        * and
        + or
        > si, entonces
        = equivale, si y solo si
        */
        //   (  -  *  +  >  =  )  L  LA ES [  ]
            {0, 0, E, E, E, E, E, 1, E, E, 0, E},
            {E, E, 2, 2, 2, 2, 1, E, E, F, E, 1},
            {2, 2, E, E, E, E, E, 3, E, E, 2, E},
            {E, E, 2, 2, 2, 2, 1, E, E, F, E, 1}

        };

        int[] PE = {7, 6, 4, 3, 2, 1};
                //  ([ -  *  +  >  =    

        int[] PS = {0, 5, 4, 3, 2, 1};
                //  ([ -  *  +  >  =   
        public Analizador(string expresion)
        {
            this.numeroVariables = 0;
            this.expresion = expresion;
            this.listaVariables = new List<Char>();

            int estado = 0;
            int posicion = 0;
            char caracter;
            int parentesis = 0;
            int corchetes = 0;
            while(estado >= 0)
            {
                if(posicion < expresion.Length)
                {
                    caracter = this.expresion[posicion];
                    //Console.WriteLine(caracter);
                    if(char.IsLetter(caracter) && !(listaVariables.Contains(caracter)))
                    {
                        listaVariables.Add(caracter);
                        numeroVariables++;
                    }
                    else if (caracter == '(')
                    {
                        parentesis++;
                    }
                    else if (caracter == '[')
                    {
                        corchetes++;
                    }
                    else if (caracter == ')')
                    {
                        parentesis--;
                    }
                    else if (caracter == ']')
                    {
                        corchetes--;
                    }
                }
                estado = trand[estado, columnaAutomata(posicion)];
                posicion++;
                
            }

            if(estado == E)
            {
                throw new Exception("Error, favor de escribir correctamente la expresion");
            }

            if(estado == F)
            {
                if(corchetes==0 && parentesis==0)
                {
                    Console.WriteLine("La expresion ha sido escrita correctamente");
                    Console.WriteLine("Expresion:" + expresion);
                }
                else
                {
                    throw new Exception("Error Lexico, debe abrir y cerrar todos los corchetes o parentesis");
                }
            }
            postFija();

        }

        private void postFija()
        {
            this.expresionPost="";
            Stack<char> pila = new Stack<char>();
            foreach (char caracter in expresion)
            {
                if(char.IsLetter(caracter))
                {
                    expresionPost = expresionPost + caracter;
                }
                else if(caracter == ')' || caracter == ']')
                {
                    char auxiliar = pila.Pop();
                    while (auxiliar != '(' && auxiliar != '[')
                    {
                        expresionPost = expresionPost + auxiliar;
                        if(pila.Count > 0)
                            auxiliar = pila.Pop();
                        else   
                            auxiliar='(';
                    }
                }
                else
                {
                    bool con = false;
                    while(con == false)
                    {
                        if(pila.Count == 0)
                        {
                            pila.Push(caracter);
                            con=true;
                        }
                        else if(prioridades(caracter, pila.Peek()))
                        {
                            pila.Push(caracter);
                            con=true;
                        }
                        else
                        {
                            expresionPost = expresionPost + pila.Pop();
                        }
                    }
                }
                //Console.WriteLine(expresionPost);
            }
            while(pila.Count >0)
            {
                expresionPost = expresionPost + pila.Pop();
            }
            Console.WriteLine("Expresion Postfija: " + expresionPost);
            generarTablas();
        }

        private void generarTablas()
        {
            List<List<bool>> tablas = new List<List<bool>>();
            double renglones = Math.Pow(2,numeroVariables);
            List<bool> ren;
            for (int i = 0; i < renglones; i++)
            {
                ren = new List<bool>();
                tablas.Add(ren);
            }
            double distribuicion = renglones/2;
            int contador = 1;
            bool escribirV = true;
            for (int i = 0; i < numeroVariables; i++)
            {
                foreach (List<bool> renglon in tablas)
                {
                    if(escribirV)
                    {
                        renglon.Add(true);
                        contador++;
                        if(contador > distribuicion)
                            escribirV=false;
                    }
                    else
                    {
                        renglon.Add(false);
                        contador--;
                        if(contador == 1)
                            escribirV=true;
                    }
                }
                contador=1;
                distribuicion = distribuicion/2;
            }

            Console.WriteLine("Tabla de verdad:");
            Console.WriteLine("");
            foreach(char var in listaVariables)
            {
                Console.Write(var + " ");
            }
            Console.Write("Resultado");
            Console.WriteLine("");
            foreach (List<bool> renglon in tablas)
            {
                foreach(bool valor in renglon)
                {
                    if(valor)
                        Console.Write("V ");
                    else
                        Console.Write("F ");
                }
                if(evaluar(renglon))
                    Console.Write("V");
                else
                    Console.Write("F");
                Console.WriteLine("");
            }
            Console.WriteLine("");

        }
        private bool evaluar(List<bool> valores)
        {
            Stack<bool> pila = new Stack<bool>();
            bool aux1, aux2;
            foreach (char caracter in expresionPost)
            {
                if(char.IsLetter(caracter))
                {
                    pila.Push(asignarVariablesValor(caracter,valores));
                }
                else if(caracter == '-')
                {
                    aux1 = pila.Pop();
                    aux1 = !aux1;
                    pila.Push(aux1);
                }
                else if(caracter == '+')
                {
                    aux1 = pila.Pop();
                    aux2 = pila.Pop();
                    aux1 = aux1 || aux2;
                    pila.Push(aux1);
                }
                else if(caracter == '*')
                {
                    aux1 = pila.Pop();
                    aux2 = pila.Pop();
                    aux1 = aux1 && aux2;
                    pila.Push(aux1);
                }
                else if(caracter == '>')
                {
                    aux1 = pila.Pop();
                    aux2 = pila.Pop();
                    aux1 = si_entonces(aux1, aux2);
                    pila.Push(aux1);
                }
                else//caracter == '='
                {
                    aux1 = pila.Pop();
                    aux2 = pila.Pop();
                    aux1 = si_y_solo_si(aux1, aux2);
                    pila.Push(aux1);
                }
            }
            bool resultado = pila.Pop();
            return resultado;
        }

        private bool si_entonces(bool p, bool q)
        {
            if(p==true && q==false)
                return false;
            else
                return true;
        }
        private bool si_y_solo_si(bool p, bool q)
        {
            if(p==q)
                return true;
            else
                return false;
        }

        private bool asignarVariablesValor(char variable,List<bool> valores)
        {
            int posicion = listaVariables.IndexOf(variable);
            bool val = valores[posicion];
            return val;
        }

        private bool prioridades(char entra, char enPila)
        {
            int prioE = PE[columnaPrioridades(entra)];
            int prioP = PS[columnaPrioridades(enPila)];
            if(prioE > prioP)
                return true;
            else
                return false;
        }
        
        private int columnaPrioridades(char caracter)
        {
            //  ([ -  *  +  >  =
            if(caracter == '(' || caracter == '[')
            {
                return 0;
            }
            else if(caracter == '-')
            {
                return 1;
            }
            else if(caracter == '*')
            {
                return 2;
            }
            else if(caracter == '+')
            {
                return 3;
            }
            else if(caracter == '>')
            {
                return 4;
            }
            else
            {
                return 5;
            }
        }
        private int columnaAutomata(int posicion)
        {
            
            //   (  -  *  +  >  =  )  L  LA ES [  ]
            if(posicion == expresion.Length)
            {
                return 9;
            }
            else
            {
                char caracter = this.expresion[posicion];
                if(caracter == '(')
                {
                    return 0;
                }
                else if(caracter == '-')
                {
                    return 1;
                }
                else if(caracter == '*')
                {
                    return 2;
                }
                else if(caracter == '+')
                {
                    return 3;
                }
                else if(caracter == '>')
                {
                    return 4;
                }
                else if(caracter == '=')
                {
                    return 5;
                }
                else if(caracter == ')')
                {
                    return 6;
                }
                else if(char.IsLetter(caracter))
                {
                    return 7;
                }
                else if(caracter == '[')
                {
                    return 10;
                }
                else if(caracter == ']')
                {
                    return 11;
                }
                else
                {
                    return 8;
                }

                //   (  -  *  +  >  =  )  L  LA ES [  ]
            }
        }
        
    }
}