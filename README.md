# Compuerta_estacionamiento_controlador
Descripcion conductual de un controlador automatizado para la entrada de un estacionamiento

## Resumen
Se disena el controlador automatizado para la entrada de un estacionamiento el cual cuenta
con el funcionamiento normal de al llegar un vehıculo este ingresa el codigo correctamente
y puede ingresar al estacionamiento. En caso de que el vehıculo ingrese 3 veces el codigo
incorrectamente se activa una alarma de pin incorrecto, la cual se desactiva hasta que se ingrese
el codigo correctamente. Si un vehıculo esta saliendo de la compuerta y en ese mismo instante
desea ingresar otro vehıculo sin digital el codigo, se activa un estado de bloqueo en el cual
enciende una alarma de bloqueo y se bloquea la compuerta hasta que se ingrese el codigo
correcto.

Como primera prueba se realiza la prueba del funcionamiento basico, el ingreso del pin
incorrecto menos de 3 veces, ingreso de pin incorrecto 3 o mas veces y para la alarma de
bloqueo. Se da un buen funcionamiento del controlador en todas las pruebas mınimas, en el
caso del manejo del contador de intentos para la segunda y tercera prueba, este contaba cada
flanco del reloj sin que se digitara un nuevo codigo, por lo que se decide el anadir una senal
de enter la cual nos va ayudar a saber en que instante se realiza el intento y en este contar,
otro problema presentado es que si esta pulsacion de enter duraba mas de un flanco de reloj
contaba mas intentos por lo que se decide anadir un nuevo estado para esperar que la senal de
enter vuelva a cero.

El generar el controlador automatizado, la manera mas sencilla para la implementacion de
este es realizar una maquina de estados con la cual se maneja la secuencia de manera ordenada
y concisa. Como una de las recomendaciones para un diseno posterior es la senal de enter para
facilidad de implementacion de la descripcion conductual y para que el usuario pueda presionar
cuando ya se ha digitado el codigo que desea. Tambien para un diseno posterior se puede realizar
la descripcion a fondo del cuidado que se debe tener con los contadores en los controladores.
