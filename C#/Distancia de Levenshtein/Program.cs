/*
    Proyecto: Distancia de Levenshtein
    Funcion: A partir de dos palabras calcula la distancia de Levenshtein 
            y porcentaje de similiridad

    Nombre: Arellano Ochoa Daniel Ignacio
*/
using System;
namespace Distancia_de_Levenshtein
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Distancia de Levenshtein");
            Console.Write("Dame una palabra: ");
            String pal1 = Console.ReadLine();
            Console.Write("Dame una segunda palabra: ");
            String pal2 = Console.ReadLine();
            Program p = new Program();
            double porc = 0;
            int dis = p.LevenshteinDistance(pal1,pal2, out porc);
            Console.WriteLine("Distancia entre \"" + pal1 + "\" y \"" + pal2 + "\": " + dis);
            Console.WriteLine("Porcentaje de similiridad: " + (100 - (porc * 100)) + " %");
        }

        public int LevenshteinDistance(string s, string t, out double porcentaje)
        {
            porcentaje = 0;
        
            // d es una tabla con m+1 renglones y n+1 columnas
            int costo = 0;
            int m = s.Length;
            int n = t.Length;
            int[,] d = new int[m + 1, n + 1]; 

            // Verifica que exista algo que comparar
            if (n == 0) return m;
            if (m == 0) return n;

            // Llena la primera columna y la primera fila.
            for (int i = 0; i <= m; d[i, 0] = i++) ;
            for (int j = 0; j <= n; d[0, j] = j++) ;
        
        
            /// recorre la matriz llenando cada unos de los pesos.
            /// i columnas, j renglones
            for (int i = 1; i <= m; i++)
            {
                // recorre para j
                for (int j = 1; j <= n; j++)
                {       
                    /// si son iguales en posiciones equidistantes el peso es 0
                    /// de lo contrario el peso suma a uno.
                    costo = (s[i - 1] == t[j - 1]) ? 0 : 1;  
                    d[i, j] = System.Math.Min(System.Math.Min(d[i - 1, j] + 1,  //Eliminacion
                                d[i, j - 1] + 1),                             //Insercion 
                                d[i - 1, j - 1] + costo);                     //Sustitucion
                }
            }

            /// Calculamos el porcentaje de cambios en la palabra.
            if (s.Length > t.Length)
                porcentaje = ((double)d[m, n] / (double)s.Length);
            else
                porcentaje = ((double)d[m, n] / (double)t.Length); 
            
            /*
            for (int i = 0; i < m+1; i++)
            {
                for (int j = 0; j < n+1; j++)
                {
                    Console.Write(d[i,j] + " ");
                }
                Console.WriteLine("");
            }
            */
            return d[m, n]; 
        }
    }
}

