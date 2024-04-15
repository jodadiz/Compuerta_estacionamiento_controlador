controlador: testbench.v #Archivos requeridos
	iverilog testbench.v #Corre Icarus COMPILADOR
	vvp a.out #Corre la simulacion
	gtkwave ondas.gtkw #Abre las formas de onda organizadas
