/*
	Programa que permite realizar suma, restas, multiplicaciones y divisiones entre 2 numeros, 
	realizando las operacione en ensamblador
	Nombre: Arellano Ochoa Daniel Ignacio
*/

#include "conio.h"
#include <iostream>
#include <stdio.h>
using namespace std;

int multiplicacion(int a, int b) {
	int resultado;
	
	_asm{
		push ax; 
		push cx;
		mov  ecx, a
		mov  eax,0h 
	}
	mult: _asm{
		add  eax,b
		loop mult
		mov  resultado,eax
		pop  cx; 
		pop ax;
	}

	
	return  resultado;
}

int suma(int a, int b) {
	int valor;
	
	_asm {
		mov eax, a
		add eax, b
		mov valor, eax
	}
	return valor;
}

int resta(int a, int b) {
	int valor;
	_asm {
		mov eax, a
		sub eax, b
		mov valor, eax
	}
	return valor;
}

int dividir(int a, int b) {
	int res = 0, signo=1;
	if (b == 0)
		throw exception("NO puedes dividir sobre 0");
	if ((a < 0 && b > 0)||(a > 0 && b < 0))
		signo = -1;
	a = abs(a);
	b = abs(b);

	_asm {
		push eax
		push ebx
		mov eax, 0
		mov ebx, 0
	}
	divi: _asm {
		add eax, b
		inc ebx

		cmp eax, a
		jbe divi

		dec ebx
		mov res, ebx

		pop eax
		pop ebx

	}
	return signo*res;
}

int main(int argc, const char* argv[]) {
	bool condicion = 1;
	int opc = 1, res = 0, num1, num2;
	try
	{
		do
		{
		cout << "Que desea realizar \n Suma-->1 \n Resta-->2 \n Multiplicacion-->3 \n Division-->4 " << endl;
		cin >> opc;
		cout << "====================================================================================" << endl;
		switch (opc)
		{
		case 1:
			cout << "SUMA: a+b" << endl;
			cout << "Primer numero incluyendo signo (a):" << endl;
			cin >> num1;
			cout << "Segundo numero incluyendo signo (b):" << endl;
			cin >> num2;
			res = suma(num1, num2);
			cout << "El resultado es: " << res << endl;
			break;

		case 2:
			cout << "RESTA: a-b" << endl;
			cout << "Primer numero incluyendo signo (a):" << endl;
			cin >> num1;
			cout << "Segundo numero incluyendo signo (b):" << endl;
			cin >> num2;
			res = resta(num1, num2);
			cout << "El resultado es: " << res << endl;
			break;

		case 3:
			cout << "MULTIPLICACION: a*b" << endl;
			cout << "Primer numero incluyendo signo (a):" << endl;
			cin >> num1;
			cout << "Segundo numero incluyendo signo (b):" << endl;
			cin >> num2;
			res = multiplicacion(num1, num2);
			cout << "El resultado es: " << res << endl;
			break;

		case 4:
			cout << "DIVISION: a/b" << endl;
			cout << "Primer numero incluyendo signo (a):" << endl;
			cin >> num1;
			cout << "Segundo numero incluyendo signo (b):" << endl;
			cin >> num2;
			res = dividir(num1, num2);
			cout << "El resultado es: " << res << endl;
			break;
		default:
			cout << "No existe esa opcion" << endl;
			break;
		}
		cout << "====================================================================================" << endl;
		cout << "Desea realizar otra operacion?\n 0-->NO \n 1-->SI" << endl;
		cin >> condicion;
		system("cls");
	} while (condicion);
	}
	catch (exception e)
	{
		cout<<e.what()<<endl;
	}
	
	return 0;
}