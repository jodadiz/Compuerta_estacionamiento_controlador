
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

module controlador (
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
sAlmBloq
);

output	sAbrir,																	// Declaracion de salidas
		sCerrar, 
		sBloq, 
		sAlmInc, 
		sAlmBloq;

input 	[7:0]	sCode;															// Declaracion de Entradas

input	clock,	
		reset,
		sEntrada,
		sSalida,
		sEnter;

reg sAbrir, sCerrar, sBloq, sAlmInc, sAlmBloq;
reg		[7:0]	codeCorrect;													// Constante que mantiene el valor del codigo correcto

reg		[1:0]	intento;														// Variable para el contador de los intentos
reg		[1:0]	nxt_intento;


reg [5:0] estado;
reg [5:0] nxt_estado;
         
wire clock, reset, sEntrada, sSalida, sEnter;									// Conexion de las entradas a un wire
wire	[7:0]	sCode;

// Logica para cuando se ejecute un reset y variables creados por FF en el flanco positivo del reloj

always @(posedge clock) begin
	
	if (reset) begin
		estado <= 6'b000001;													// Estado 1 default
		sAbrir <= 0;
		sCerrar <= 1;
		sBloq <= 0;
		sAlmInc <= 0;
		sAlmBloq <= 0;
		intento = 2'b00; 														// Inicio de contador en 0
		codeCorrect = 8'b00111000; 												// Clave correcta
	end else begin
		estado  <= nxt_estado;
		intento <= nxt_intento;
	end
end

always @(*) begin
	
	nxt_estado = estado;
	nxt_intento = intento;
	
	
// Comportamiento de la maquina de estados para el funcionamiento de la compuerta
	
	case(estado)
		6'b000001:	begin														// ESTADO 1 inicial 
						sAbrir = 0;			
						sCerrar = 1;											// La puerta se mantiente cerrada
		
						if (sEntrada && sSalida) nxt_estado = 6'b100000;		// Si se activan al mismo tiempo estado 6
						else if (sEntrada && !sSalida) nxt_estado = 6'b000010;	// Si llega un vehiculo --> estado 2
					end
		
		6'b000010:	begin														// ESTADO 2 Solicitud del codigo
						if(sEnter) begin
							if (sCode == codeCorrect) nxt_estado = 6'b000100;	// Si el codigo es correcto --> estado 3
							
							else begin
								nxt_intento = intento + 1;						// Codigo incorrecto intento++
								if (nxt_intento >= 3) nxt_estado = 6'b001000;	// Si el intento >= 3 --> estado 4
								else nxt_estado = 6'b010000;					// Si no pasar al estado 5
							end
						end
					end
						
		6'b000100:	begin														// ESTADO 3 Apertura de la compuerta
						sCerrar = 0;
						sAbrir = 1;
						nxt_intento = 2'b00;									// Se reinician los intentos
							
						if (sSalida) begin
							if (sEntrada) nxt_estado = 6'b100000;				// Si la sSalida & sEntrada --> estado 6
							else nxt_estado = 6'b000001;						// Si solo sSalida volvemos --> estado 1
						end
					end
		
		
		6'b001000:	begin														// ESTADO 4 Alarma de intentos incorrectos
						sAlmInc = 1;
						
						if (sEnter) begin
							if (sCode == codeCorrect) begin						// Codigo correcto desactivar alarma
								sAlmInc = 0;
								nxt_estado = 6'b000100;							// Siguiente --> estado 3
							end
						end
					end


		6'b010000:	if (!sEnter) nxt_estado = 6'b000010;						// ESTADO 5 espera desactivacion enter

	
		6'b100000:	begin														// ESTADO 6 Sistema de bloqueo
						sBloq = 1;
						sAlmBloq = 1;
						
						if(sEnter) begin
							if (sCode == codeCorrect) begin						// Codigo correcto desactivar bloqueo
								sBloq = 0;
								sAlmBloq = 0;
								nxt_estado = 6'b000100;							// Apertura de compuerta --> estado 3
							end
						end
					end
		

		
		
		default: nxt_estado = 6'b000001;										// Estado 1 por default 
		
										
	endcase
end

endmodule	
		
	
