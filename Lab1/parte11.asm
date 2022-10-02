.data
	# v1 y v2 son espacios reservados para que al ejecutar se asignen los valores y no perder los textos
	# ya que 0x10010000 es el primer segmento de .data
	v1: .space 12
	espacio: .asciiz " "
	newL: .asciiz "\n"
	inicio: .asciiz "[ "
	fin: .asciiz "]"
	vacio: .space 12
	v2: .space 12
	enun: .asciiz "la suma de vectores es: "
	
.text
	main:
		# se imprime la etiqueta enun almacenada em .data
		li $v0, 4
		la $a0, enun
		syscall
		
		# se salta a la etiqueta sumVectores y
		# se almacena la direccion de regreso en $ra
		jal sumVectores
		# se salta a la etiqueta printFin y
		# se almacena la direccion de regreso en $ra
		jal printFin
		
		# final del programa
		li $v0, 10
		syscall
	
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
	
	setVar:
		# se fijan los valores de $t0 y $t1 en 0 
		addi $t0, $zero, 0
		addi $t1, $zero, 0
		
		# se salta a la instruccion en $ra es decir
		# regresa a la instruccion siguiente al salto
		jr $ra
		
	sumVectores:
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
		# se salta a la etiqueta whileSum y
		# se almacena la direccion de regreso en $ra
		jal whileSum
	
	whileSum:
		# si $t0 es igual o mayor que 2 se salta a la etiqueta exit
		bgt $t0, 2, exit
		
		# se carga en $t2 y $t3 lo que almacenan las memorias 0x10010000 y 0x10010020
		# en la posicion $t1
		lw $t2, 0x10010000($t1)
		lw $t3, 0x10010020($t1)
		
		# se imprime la suma entre $t2 y $t3
		li $v0, 1
		add $a0, $t2, $t3
		syscall
		
		# se salta a la etiqueta printEspacio y
		# se almacena la direccion de regreso en $ra
		jal printEspacio
		
		# se suma el valor 1 a $t0 y el valor 4 a $t1
		addi $t0, $t0, 1
		addi $t1, $t1, 4
		
		# se salta a whileSum
		j whileSum
	
	exit:
		# se recupera la direccion guardada en el stack en $ra y se restaura $sp
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		# se salta a la instruccion en $ra es decir
		# regresa a la instruccion siguiente al salto
		jr $ra
