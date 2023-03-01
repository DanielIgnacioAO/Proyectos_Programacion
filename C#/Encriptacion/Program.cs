/*
    Proyecto: Encriptacion
    Funcion: Permite encriptar un documentos txt a partir de una clave, y desencriptar

    Nombre: Arellano Ochoa Daniel Ignacio
*/

using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace Encriptacion
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                Encriptador enc = new Encriptador(); 
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }
    }

    class Encriptador 
    {
            private StreamReader archivo;
            private StreamWriter encriptado;

            private string clave;

        public Encriptador()
        {
                Console.WriteLine("Que desea realizar? Encriptar--> 1, Desencriptar --> 2");
                string op = Console.ReadLine();

                Console.WriteLine("Coloque la ruta del archivo, no olvide el nombre del archivy su extension .txt: ");
                string ruta = Console.ReadLine();

                string nombreArchivo = Path.GetFileNameWithoutExtension(ruta);
                string nombreDir = Path.GetDirectoryName(ruta);
                string extension = Path.GetExtension(ruta);
                if(extension != ".txt")
                    throw new Exception(String.Format("El archivo {0} no es un archivo txt.", nombreArchivo));

                Console.WriteLine("Coloque la clave de caracteres de la encriptacion del archivo: ");
                clave = Console.ReadLine();
                

                Console.WriteLine("Leyendo " + nombreArchivo + extension + "...");
                if (File.Exists(ruta))
                {
                    archivo = new StreamReader(ruta);
                }
                else
                {
                    string mensaje = String.Format("El archivo {0} no existe.", nombreArchivo);
                    throw new Exception(mensaje);
                }
                
                switch (op)
                {
                    case "1":
                        encriptado = new StreamWriter(nombreDir + "\\" + nombreArchivo + "_encriptado" + extension);
                        encriptado.AutoFlush = true;
                        Console.WriteLine("Encriptando...");
                        this.encriptar();
                        Console.WriteLine("Se ha encriptado el archivo " + nombreArchivo + extension + " correctamente");
                        Console.WriteLine("El archivo encriptado se ha nombrado como: " + nombreArchivo + "_encriptado" + extension);
                    break;
                    case "2":
                        encriptado = new StreamWriter(nombreDir + "\\" + nombreArchivo + "_Desencriptado" + extension);
                        encriptado.AutoFlush = true;
                        Console.WriteLine("Desencriptando...");
                        this.encriptar();
                        Console.WriteLine("Se ha desencriptado el archivo " + nombreArchivo + extension + " correctamente");
                        Console.WriteLine("El archivo desencriptado se ha nombrado como: " + nombreArchivo + "_Desencriptado" + extension);
                    break;
                    default:
                        throw new Exception("Error: Seleccione una de las opciones");
                }
                encriptado.Close();
                archivo.Close();       
        }
        private void encriptar()
        {
            char caracter;
            char carEnc;
            int con = 0;
            while (!this.FinDeArchivo())
            {
                caracter = (char)archivo.Read();
                carEnc = (char)(caracter ^ clave[con]);
                encriptado.Write(carEnc);
                con++;
                if(con == this.clave.Length)
                    con=0;
            }
        }
        
        private bool FinDeArchivo()
        {
            return archivo.EndOfStream;
        }
    }
}
