using System;

namespace Expresiones_Logicas
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Bienvenido, escribe una expresion logica");
            string expresion = Console.ReadLine();
            Analizador analizador = new Analizador(expresion);
        }
    }
}
