.data
	v1: .space 12
	espacio: .asciiz " "
	newL: .asciiz "\n"
	pedir: .asciiz "ingrese numero: "
	enun: .asciiz "el producto punto es: "
	
.text
	main:
		jal getV1
		
		jal proPunto
		
		# se imprime la etiqueta enun almacenada em .data
		li $v0, 4
		la $a0, enun
		syscall
		
		# se imprime el valor del acumulador
		li $v0, 1
		add $a0, $zero, $t5 
		syscall
		
		# final del programa
		li $v0, 10
		syscall
	
	printNewLine:
		# se imprime la etiqueta newL almacenada em .data
		li $v0, 4
		la $a0, newL
		syscall
		# se salta a la instruccion en $ra es decir
		# regresa a la instruccion siguiente al salto
		jr $ra
			
	printEspacio:
		# se imprime la etiqueta espacio almacenada em .data
		li $v0, 4
		la $a0, espacio
		syscall
		# se salta a la instruccion en $ra es decir
		# regresa a la instruccion siguiente al salto
		jr $ra
	
	printPedir:
		# se imprime la etiqueta pedir almacenada em .data
		li $v0, 4
		la $a0, pedir
		syscall
		# se salta a la instruccion en $ra es decir
		# regresa a la instruccion siguiente al salto
		jr $ra
	
	setVar:
		# se fijan los valores de $t0 y $t1 en 0 
		addi $t0, $zero, 0
		addi $t1, $zero, 0
		
		# se salta a la instruccion en $ra es decir
		# regresa a la instruccion siguiente al salto
		jr $ra
		
	getV1:
		# se crea un espacio para almacenar en $sp
		# y se almacena la direccion de $ra en $sp (el stack)
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		# se salta a la etiqueta setVar y
		# se almacena la direccion de regreso en $ra
		jal setVar
		# se salta a la etiqueta whileGetV1 y
		# se almacena la direccion de regreso en $ra
		jal whileGetV1
		
	whileGetV1:
		# si $t0 es igual o mayor que 2 se salta a la etiqueta exit
		bgt $t0, 2, exit
		
		# se salta a la etiqueta printPedir y
		# se almacena la direccion de regreso en $ra
		jal printPedir
		# se lee el numero
		li $v0, 5
		syscall
		# se guarda en v1 en la posicion $t1 el valor de $v0
		sw $v0, v1($t1)
		# se salta a la etiqueta printNewLine y
		# se almacena la direccion de regreso en $ra
		jal printNewLine
		
		# se suma el valor 1 a $t0 y el valor 4 a $t1
		addi $t0, $t0, 1
		addi $t1, $t1, 4
		
		# se salta a whileGetV1
		j whileGetV1
	
	exit:
		# se recupera la direccion guardada en el stack en $ra y se restaura $sp
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		# se salta a la instruccion en $ra es decir
		# regresa a la instruccion siguiente al salto
		jr $ra
				
	proPunto:
		# se crea un espacio para almacenar en $sp
		# y se almacena la direccion de $ra en $sp (el stack)
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		# se salta a la etiqueta setVar y
		# se almacena la direccion de regreso en $ra
		jal setVar
		# se salta a la etiqueta whileProducto y
		# se almacena la direccion de regreso en $ra
		jal whileProducto
	
	whileProducto:
		# si $t0 es igual o mayor que 2 se salta a la etiqueta exit
		bgt $t0, 2, exit
		
		# se carga en $t2 el vector guardado en v1 y en $t3 lo que almacena la memoria 0x10010060
		# en la posicion $t1
		lw $t2, v1($t1)
		lw $t3, 0x10010060($t1)
		
		# se guarda en $t4 la multiplicacion de $t2 y $t3
		# y se almacena en $t5 la suma de $t5 con el resultado de $t4
		mul $t4, $t2, $t3
		add $t5, $t5, $t4
		
		# se suma el valor 1 a $t0 y el valor 4 a $t1
		addi $t0, $t0, 1
		addi $t1, $t1, 4
		
		# se salta a whileProducto
		j whileProducto
