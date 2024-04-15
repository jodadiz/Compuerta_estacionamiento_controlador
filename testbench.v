/*
*********************************************
**Tarea 01							       **
**Controlador automatizado para la entrada **
**de un estacionamiento	 		 		   **
**										   **
**Profesor: Enrique Coen Alfaro 		   **	
**Asistente: Eddy Jimenez Ulate			   **
**Estudiante: José David Díaz Pérez C02638 **
**I-2024							   	   **
**13 de abril del 2024					   **
*********************************************
*/

`include "tester.v"
`include "controlador.v"

module controlador_tb;
	
	wire sAbrir, sCerrar, sBloq, sAlmInc, sAlmBloq, clock, reset, sEntrada, sSalida, sEnter;						// Declaracion de wire todas las entradas y salidas
	wire	[7:0]	sCode;																							// Ya que el tb realiza la conexion entre el tester y el controlador
	
	initial begin
		$dumpfile("resultados.vcd");																				// Creacion del archivo vcd para la lectura de gtkwave
		$dumpvars(-1, C0);
		$monitor ("sAbrir=%b,sCerrar=%b,sBloq=%b,sAlmInc=%b,sAlmBloq=%b", sAbrir,sCerrar,sBloq,sAlmInc,sAlmBloq);	// Inmpresion en la terminal de los siguientes valores cuando se dan cambios
  	end
  	
// Definicion de conexion de las salidas y entradas con sus respectivos wires, para mayor facilidad
// los wires se nombran igual que la variable a conectar.

	controlador C0 (
	 .clock (clock),
	 .reset (reset),
	 .sEntrada (sEntrada),
	 .sSalida (sSalida),
	 .sEnter (sEnter),
	 .sCode (sCode),
	 .sAbrir (sAbrir),
	 .sCerrar (sCerrar),
	 .sBloq (sBloq),
	 .sAlmInc (sAlmInc),
	 .sAlmBloq (sAlmBloq)
	);

	tester T0(
	 .clock (clock),
	 .reset (reset),
	 .sEntrada (sEntrada),
	 .sSalida (sSalida),
	 .sEnter (sEnter),
	 .sCode (sCode),
	 .sAbrir (sAbrir),
	 .sCerrar (sCerrar),
	 .sBloq (sBloq),
	 .sAlmInc (sAlmInc),
	 .sAlmBloq (sAlmBloq)
	);
	
endmodule
