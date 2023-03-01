/*
    Proyecto: Ensamblador
    Funcion: Compila programas escritos en c++, para indicar errores, si todo es correcto genera un codigo ensamblador que 
		realiza lo mismo que el programa en c++

    Nombre: Arellano Ochoa Daniel Ignacio
*/

using System;

namespace Ensamblador
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                using (Lenguaje l = new Lenguaje("C:\\Archivos\\suma.cpp"))
                {
                    /*while (!l.FinDeArchivo())
                    {
                        l.NextToken();
                    }*/
                    l.Programa();

                }
            }
            catch (Error e)
            {
                Console.WriteLine(e.Message);
            }

            Console.ReadKey();
        }
    }
}
