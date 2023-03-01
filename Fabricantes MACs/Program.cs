/*
    Proyecto: Distancia de Levenshtein
    Funcion: Permite saber el fabricante de las direcciones MAC

    Nombre: Arellano Ochoa Daniel Ignacio
*/

using System;
using System.Net;
using System.IO;
using System.Diagnostics;
/*

timeMeasure.Start();
timeMeasure.Stop();
Console.WriteLine($"Tiempo de solicitud: {timeMeasure.Elapsed.TotalMilliseconds} ms");

*/
namespace Fabricantes_MACs
{
    class Program
    {
        static void Main(string[] args)
        {
            Stopwatch timeMeasure = new Stopwatch();
            
            Console.WriteLine("Consultando pagina web, puede tardar unos minutos...");
            // Cear la solicitud de la URL
            WebRequest request = WebRequest.Create("http://standards-oui.ieee.org/oui/oui.txt");
            
            // Obtener la respuesta
            WebResponse response = request.GetResponse();

            // Abrir el stream de la respuesta recibida
            StreamReader reader = new StreamReader(response.GetResponseStream());
    
            // Leer el contenido
            string textoPagina = reader.ReadToEnd(); //reader.ReadLine();
    
            bool continuar = true;
            do
            {

                Console.WriteLine("Coloque la direccion MAC que desea consultar en el formato XX-XX-XX");
                string consulta = Console.ReadLine();
                string ren="";
                bool no_encontrado=true;
                foreach (char carac in textoPagina)
                {
                    if(carac==10)
                    {
                        if(ren.Contains(consulta))
                        {
                            ren = ren.Replace(consulta, "");
                            ren = ren.Replace("(hex)", "");
                            Console.WriteLine("Resultado: " + ren);
                            no_encontrado=false;
                            break;
                        }
                        else
                        {
                            ren="";
                        }
                    }
                    else
                    {
                        ren = ren + carac;
                    }
                }
                if(no_encontrado)
                    Console.WriteLine("No se encontro ningun fabricante con la direccion " + consulta);

                Console.WriteLine("Desea buscar otro fabricante? [si,no]");
                string op = Console.ReadLine();
                bool ciclo=true;
                do
                {
                    switch (op)
                    {
                        case "si":
                            continuar=true;
                            ciclo=false;
                            break;
                        case "no":
                            continuar=false;
                            ciclo=false;
                            break;
                        default:
                            Console.WriteLine("Escriba \"si\" o \"no\" ");
                            op=Console.ReadLine();
                            break;
                    }
                }while(ciclo);
            }while(continuar);

            // Cerrar los streams abiertos.
            reader.Close();
            response.Close();
        }
    }
}
