{el programa utilizara variables flotantes (single para pascal) a excepcion de bresenham
* este programa mostrara una recta en un plano cartesiano, para ello se hara uso de las librerias
* crt y graph}
program algoritmosRecta;

uses
 crt, graph;
 

{
*									** DECLARACION DE LAS funciones y procesos ** 
* 
* A diferencia de C, las funciones y procesos se declaran antes de la funcion
* principal
* 
* 
}

{SE DECLARA UN "PROTOTIPO" DE LA FUNCION ALGORITMOS Y CAPTURADATOS USANDO FORWARD, ESTO CON LA FINALIDAD DE QUE LOS DEMAS PROCEDIMIENTOS PUEDAN USARLO}
function algoritmos(x1, y1, x2, y2 : single; driver, modo, res : integer;  graficos : string): integer;forward;
procedure capturaDatos(driver, modo : integer; graficos : string); forward;


{PROCEDIMIENTO DEL ALGORITMO DE LA ECUACION DE LA RECTA}
procedure ecuacionRecta(x1, y1, x2, y2 : single; driver, modo : integer; graficos : string);
var
	opcion : integer;
	x, y, b, m : single;

begin
	opcion := 0;							//colocamos el valor de 0 para las proximas opciones a elegir
	m := (y2 -y1)/(x2- x1);
	b := y2 - (m* x2);
	x := x1;
	y := y1;
	
	initgraph(driver, modo, graficos);
	line(320, 0, 320, 480);						//ambas lineas dividen la ventana
	line(0, 240, 640, 240);						//para generar el plano cartesiano

	if(x < x2) then										//hacemos la comparacion en caso de que el numero sea positivo o
	begin															//negativo
		while x <> x2 do								//hacemos el ciclo hasta llegar al segundo punto
		begin
			putpixel(round(x), round(y), 14);
			y := m*x +b;
			x+= 1;
		end;
	end
	else if(x > x2) then
	begin
		while x <> x2 do
		begin
			putpixel(round(x), round(y), 14);
			y := m*x +b;
			x-= 1;
		end;	
	end;
	readln;
	closegraph;
	algoritmos(x1, y1, x2, y2, driver, modo, opcion, graficos);		//se manda a llamar las opciones para usarse nuevamente
	exit;																													//salimos de la funcion para evitar que vuelva a ejecutarse
end;




{PROCEDIMIENTO DEL ALGORITMO DDA}
procedure algoritmoDDA(x1, y1, x2, y2 : single; driver, modo : integer; graficos : string);
 var
 opcion, cont : integer;
 dx, dy, pasos, x, y, incrementoX, incrementoY : single;

begin
	opcion := 0;
	cont := 0;
	dx := x2 - x1;
	dy := y2 - y1;
	
	if (abs(dx)) > (abs(dy)) then
		pasos := abs(dx)
	else
		pasos := abs(dy);
		
		incrementoX := dx/pasos;
		incrementoY := dy/pasos;
		
		x := x1;
		y := y1;

		initgraph(driver, modo, graficos); //abrimos la libreria de graficos
		line(320, 0, 320, 480);						//ambas lineas dividen la ventana		(linea de las y)
		line(0, 240, 640, 240);						//para generar el plano cartesiano  (linea de las x)
		while cont<= pasos do
			begin
				putpixel(round(x), round(y), 14);
				x += incrementoX;
				y += incrementoY;
				cont+= 1;
			end;
		
		readln;			//pausamos la pantalla de los graficos
		closegraph; //cerramos la libreria de graficos
		algoritmos(x1, y1, x2, y2, driver, modo, opcion, graficos);
		exit;
end;




{PROCEDIMIENTO DEL ALGORITMO BRESENHAM}


procedure algoritmoBresenham(x1, y1, x2, y2 : single; driver, modo : integer; graficos : string);
var
	opcion, x, y, pasos, pasosRecto, pasosInclinado, temporal : integer;
	dx, dy, xInclinada, yInclinada, xRecta, yRecta : single;
	
begin
	opcion := 0;
	dx := round(x2 - x1);
	dy := round(y2 - y1);
	
	
	{condicionales que definen el paso inclinado}
	if dy >= 0 then
		yInclinada := 1
	else
		begin
			dy := -dy;
			yInclinada := -1;
		end;
		
	if dx >= 0 then
		xInclinada := 1
	else
		begin
			dx := -dx;
			xInclinada := -1;
		end;
		
		{condicionales que definen el paso recto}
	if dx >= dy then
		begin
			yRecta := 0;
			xRecta := xInclinada;
		end
		else
		begin
			xRecta:= 0;
			yRecta:= yInclinada;
			
			temporal := round(dx);		//se intercambian los valores de dx
			dx := dy;									//y dy en caso de que dy sea mayor, esto
			dy := temporal;						//con el fin de reutilizar el bucle
		end;
	
	//iniciailizacion de los valores
	x:=	round(x1);
	y:= round(y1);
	
	//inicializacion de los pasos o slopes
	pasosRecto := round(2 * dy);
	pasos := round(pasosRecto - dx);
	pasosInclinado := round(pasos - dx);
	
	initgraph(driver, modo, graficos);
	line(320, 0, 320, 480);						//ambas lineas dividen la ventana
	line(0, 240, 640, 240);						//para generar el plano cartesiano
	repeat
		putpixel(round(x), round(y), 14);
		
		if pasos > 0 then
		begin
			x += round(xInclinada);
			y += round(yInclinada);
			pasos += pasosInclinado;
		end
		else
		begin
			x+= round(xRecta);
			y+= round(yRecta);
			pasos+= pasosRecto;
		end;		
	until x = x2;
	
	readln;
	closegraph;
	algoritmos(x1, y1, x2, y2, driver, modo, opcion, graficos);
	exit;
end;




{PROCEDIMIENTO DEL ALGORITMO DE LA ECUACION PARAMETRICA}
procedure ecuacionParametrica(x1, y1, x2, y2 : single; driver, modo : integer; graficos : string);
var
	opcion : integer;
	x, y, t : single;
	
begin
	opcion := 0;
	t:= 0;
	
	initgraph(driver, modo, graficos);
	line(320, 0, 320, 480);						//ambas lineas dividen la ventana
	line(0, 240, 640, 240);						//para generar el plano cartesiano
	while t < 1 do
	begin
		x := x1 + (x2 - x1) * t;
		y := y1 + (y2 - y1)*t;
		putpixel(round(x), round(y), 14);
		t := t+ 0.001;
	end;
	readln;
	closegraph;
	algoritmos(x1, y1, x2, y2, driver, modo, opcion, graficos);
	exit;
end;




function algoritmos(x1, y1, x2, y2 : single; driver, modo, res : integer;  graficos : string): integer;
begin	
	case res of
		1 : ecuacionRecta(x1, y1, x2, y2, driver, modo, graficos);
		2 : algoritmoDDA(x1, y1, x2, y2, driver, modo, graficos);
		3 : algoritmoBresenham(x1, y1, x2, y2, driver, modo, graficos);
		4 : ecuacionParametrica(x1, y1, x2, y2, driver, modo, graficos);
		5 : capturaDatos(driver, modo, graficos);
		6 : begin writeln('hasta luego'); delay(500); halt; end;						//se utiliza la orden halt para salir por completo del programa 
	else
		clrscr;
		writeln('que algoritmo desea utilizar?');
		writeln('(1) algoritmo ecuacion recta');
		writeln('(2) algoritmo DDA');
		writeln('(3) algoritmo Bresenham');
		writeln('(4) algoritmo ecuacion parametrica');
		writeln('(5) capturar nuevos datos');
		writeln('(6) salir del programa');
		readln(res);
		algoritmos:= res;
	end;
	
	algoritmos(x1, y1, x2, y2, driver, modo, res, graficos) //en caso de que no se cumpla ninguno de los casos
	
end;



 procedure capturaDatos(driver, modo : integer; graficos : string); 
 var 
  x1, y1, x2, y2 : single;
  opcion : integer;
 
 begin
	clrscr;
 	opcion := 0;
	writeln('escriba las coordenadas de los puntos');
	write('x1: ');
	readln(x1);
	write('y1: ');
	readln(y1);
	write('x2: ');
	readln(x2);
	write('y2: ');
	readln(y2);
	
	y1 := y1 *(-1);					//se multiplica por -1 para ajustar los valores
	y2 := y2 *(-1);					//de "y" en el cuadrante correcto
	
	algoritmos(x1 +320, y1 + 240, x2 + 320, y2 + 240, driver, modo, opcion, graficos);   //se suma (320, 240) para ajustarlo al punto de origen
 
 end;



{DECLARACION DE CONSTANTES PARA EL USO DEL PROGRAMA, A PARTIR DE AQUI, INICIA LA FUNCION MAIN O PRINCIPAL}
		
const driver = Vga;																					//se declaran estas constantes
const modo = VgaHi;																					//para poder realizar la graficacion
const graficos = 'C:\FPC\3.2.0\units\i386-win32\graph';			//de forma mas sencilla
	



{USO DE LA FUNCION PRINCIPAL}
BEGIN
	capturaDatos(driver, modo, graficos);
END.
