.data
	pedir: .asciiz "Ingrese un numero: "
.text
	main:
		# se imprime el tag pedir
		li $v0, 4
		la $a0, pedir
		syscall
		# se pide un numero entero, y se guarda en $a0
		li $v0, 5
		syscall
		move $a0, $v0
		# se llama la subrutina collatz
		jal collatz
		# fin de programa
		li $v0, 10
		syscall
		
	collatz:
		# se guarda el numero en $a0 en 0x10010A0 y se suma 4 al indice $t7
		sw $a0, 0x100100A0($t7)
		addi $t7, $t7, 4
		# si el numero es igual a 1 se termina
		beq $a0, 1, exit
		# se calcula el resto de $a0 con 2 para determinar si es par o impar
		rem $t0, $a0, 2
		beq $t0, 0, par
		bne $t0, 0, impar
		impar:
			# se multiplica por 3 y se suma 1
			mul $a0, $a0, 3
			addi $a0, $a0, 1
			j collatz
		par:
			# se divide por 2
			div $a0, $a0, 2
			j collatz	
		exit:
			# salida de regreso a main
			jr $ra