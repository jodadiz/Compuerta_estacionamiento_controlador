
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

module tester (
 clock,
 reset,
 sEntrada,
 sCode,
 sSalida,
 sEnter,
 sAbrir,
 sCerrar,
 sBloq,
 sAlmInc,
 sAlmBloq);


// Declaracion de entradas
 input	sAbrir,
		sCerrar, 
		sBloq, 
		sAlmInc, 
		sAlmBloq;


// Declaracion de salidas
 output	[7:0] sCode;

 output	clock,
		reset,
		sEntrada,
		sSalida,
		sEnter;

 wire sAbrir, sCerrar, sBloq, sAlmInc, sAlmBloq;
 
 reg clock, reset, sEntrada, sSalida, sEnter;
 reg	[7:0]	sCode;

// Se setean las señales de entrada para el controlador en cero

 initial begin
    clock = 0;
    reset = 0;
    sEntrada = 0;
    sSalida = 0;
    sEnter = 0;
    sCode = 8'b00000000;
    
    #5 reset = 1; //Reset a la todas las senales
    #15 reset = 0;
    
//PRUEBA #1 Funcionamiento normal basico
    #20 sEntrada = 1;
    #20 sCode = 8'b00111000;
    #20 sEnter = 1;
    #20 sEnter = 0;
    #20 {sEntrada,sSalida} = 2'b01;
    #20 {sEntrada,sSalida} = 2'b00;
      
//PRUEBA #2 Ingreso de pin incorrecto menos de 3 veces
    #20 sEntrada = 1;
    #20 sCode = 8'b11011010;							// pin incorrecto
    #20 sEnter = 1;
    #20 sEnter = 0;
    #20 sCode = 8'b00001111;							// pin incorrecto
    #20 sEnter = 1;
    #20 sEnter = 0;
    #20 sCode = 8'b00111000;							// pin CORRECTO
    #20 sEnter = 1;
    #20 sEnter = 0;
    #20 {sEntrada,sSalida} = 2'b01;
    #20 {sEntrada,sSalida} = 2'b00;

//PRUEBA #3 Ingreso de pin incorrecto 3 o mas veces    
    #20 sEntrada = 1;
    #20 sCode = 8'b01010110;							// pin incorrecto
    #20 sEnter = 1;
    #20 sEnter = 0;
    #20 sCode = 8'b01101110;							// pin incorrecto
    #20 sEnter = 1;
    #20 sEnter = 0;
    #20 sCode = 8'b11111111;							// pin incorrecto
    #20 sEnter = 1;
    #20 sEnter = 0;
    #20 sCode = 8'b00000001;							// pin incorrecto
    #20 sEnter = 1;
    #20 sEnter = 0;
    #20 sCode = 8'b00111000;							// pin CORRECTO
    #20 sEnter = 1;
    #20 sEnter = 0;
    #20 {sEntrada,sSalida} = 2'b01;
    #20 {sEntrada,sSalida} = 2'b00;
    
//PRUEBA #4 Alarma de Bloqueo
	#20 sEntrada = 1;
    #20 sCode = 8'b00111000;							// pin CORRECTO
    #20 sEnter = 1;
    #20 sEnter = 0;
    #20 {sEntrada,sSalida} = 2'b01;
    #20 {sEntrada,sSalida} = 2'b11;
    #20 {sEntrada,sSalida} = 2'b10;
    #20 sCode = 8'b01111101;							// pin incorrecto
    #20 sEnter = 1;
    #20 sEnter = 0;
    #20 sCode = 8'b00111000;							// pin CORRECTO
    #20 sEnter = 1;
    #20 sEnter = 0;
    #20 {sEntrada,sSalida} = 2'b01;
    #20 {sEntrada,sSalida} = 2'b00;
    
//Final tester
    #300 $finish;
  end

//Comportamiento del clock
  always begin
    #5 clock = !clock;
  end

endmodule
