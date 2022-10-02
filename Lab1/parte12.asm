.data
	espacio: .asciiz " "
	newL: .asciiz "\n"
	inicio: .asciiz "[ "
	fin: .asciiz "]"
	pedir: .asciiz "ingrese numero: "
	enun: .asciiz "la multiplicacion por vectorial es: "
	
	
.text
	main:
		
		# se salta a la etiqueta printPedir y
		# se almacena la direccion de regreso en $ra
		jal printPedir
		# se pide un numero por consola
		li $v0, 5
		syscall
		# se mueve el valor obtenido a $t3
		move $t3, $v0
		# se salta a la etiqueta printNewLine y
		# se almacena la direccion de regreso en $ra
		jal printNewLine
		
		# se imprime la etiqueta enun almacenada em .data
		li $v0, 4
		la $a0, enun
		syscall
		
		# se salta a la etiqueta mulVectorial y
		# se almacena la direccion de regreso en $ra
		jal mulVectorial
		# se salta a la etiqueta printFin y
		# se almacena la direccion de regreso en $ra
		jal printFin

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
	
	printInicio:
		# se imprime la etiqueta inicio almacenada em .data
		li $v0, 4
		la $a0, inicio
		syscall
		# se salta a la instruccion en $ra es decir
		# regresa a la instruccion siguiente al salto
		jr $ra
	
	printFin:
		# se imprime la etiqueta fin almacenada em .data
		li $v0, 4
		la $a0, fin
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
		
	mulVectorial:
		# se crea un espacio para almacenar en $sp
		# y se almacena la direccion de $ra en $sp (el stack)
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		# se salta a la etiqueta printInicio y
		# se almacena la direccion de regreso en $ra
		jal printInicio
		# se salta a la etiqueta setVar y
		# se almacena la direccion de regreso en $ra
		jal setVar
		# se salta a la etiqueta whileMul y
		# se almacena la direccion de regreso en $ra
		jal whileMul
	
	whileMul:
		# si $t0 es igual o mayor que 2 se salta a la etiqueta exit
		bgt $t0, 2, exit
		
		# se carga en $t2 lo que almacena la memoria 0x10010040
		# en la posicion $t1
		lw $t2, 0x10010040($t1)
		
		# se imprime la multiplicacion entre $t2 y $t3 (escalar pedido)
		li $v0, 1
		mul $a0, $t2, $t3
		syscall
		
		# se salta a la etiqueta printEspacio y
		# se almacena la direccion de regreso en $ra
		jal printEspacio
		
		# se suma el valor 1 a $t0 y el valor 4 a $t1
		addi $t0, $t0, 1
		addi $t1, $t1, 4
		
		# se salta a whileSum
		j whileMul
		
	exit:
		# se recupera la direccion guardada en el stack en $ra y se restaura $sp
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		# se salta a la instruccion en $ra es decir
		# regresa a la instruccion siguiente al salto
		jr $ra
