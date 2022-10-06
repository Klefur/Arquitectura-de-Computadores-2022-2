.data
	numero: .space 12
	pedirNum: .asciiz "Ingrese el numerador: "
	pedirDiv: .asciiz "Ingrese el denominador: "
	resultado: .asciiz "El resultado es: "
	punto: .asciiz "."
	menos: .asciiz "-"
	
.text
	main:
		# se crea el indice del numero
		addi $s2, $zero, 0
		addi $s4, $zero, 0 # se usa para definir si el numero es negativo
		
		# se imprime pedirNum
		li $v0, 4
		la $a0, pedirNum
		syscall
		
		# se pide numero y se guarda en $s1
		li $v0, 5
		syscall
		move $s0 $v0
		
		# se imprime pedirDiv
		li $v0, 4
		la $a0, pedirDiv
		syscall
		
		# se pide numero y se guarda en $s1
		li $v0, 5
		syscall
		move $s1 $v0
		
		# si el numero es negativo, se hace posivo sino se sigue
		bgt $s0, 0, whileNum
		sub $s0, $zero, $s0
		addi $s4, $zero, 1
		
		whileNum:
			# se compara que el indice no sea 12 es decir se ejecuto 3 veces
			beq $s2, 12, exitNum
			# se establecen los parametros de entrada, se salta a la subrutina divNum
			# y se guardan los valores que entrega en $s0 y $t0
			move $a0, $s0
			move $a1, $s1
			jal divNum
			move $t0 $v0
			move $s0 $v1
			# se guarda la parte entera en resultado
			sw $t0, numero($s2)	
		
			# se entrega como parametro el resto a la subrutina mult10
			move $a0, $s0
			jal mult10
			move $s0 $v0
			
			#salto a whileNum y se suma 4 al indice
			addi $s2, $s2, 4
			j whileNum
			
		exitNum:
		# se imprime resultado
		li $v0, 4
		la $a0, resultado
		syscall
		
		# si el numero era negativo se imprime el menos
		beq $s4, 0, sino
		li $v0, 4
		la $a0, menos
		syscall
		
		sino:
		# se imprime la parte entera
		addi $t0, $zero, 0
		li $v0, 1
		lw $a0, numero($t0)
		syscall
		addi $t0, $t0, 4
		
		# se imprime coma
		li $v0, 4
		la $a0, punto
		syscall
		
		# se imprime la parte decimal
		li $v0, 1
		lw $a0, numero($t0)
		syscall
		addi $t0, $t0, 4
		
		# se imprime la parte centecimal
		li $v0, 1
		lw $a0, numero($t0)
		syscall
		
		# fin de programa
		li $v0, 10
		syscall
	
	divNum:
		# se establece $v0 en 0
		addi $v0, $zero, 0
		whileDiv:
			# si a0 menor a a1 se salta a exitDiv
			blt $a0, $a1, exitDiv
			# se resta a $a0 $a1 y se almacena en $a0 asi como tambien a $v0 se le suma 1
			sub $a0, $a0, $a1
			addi $v0, $v0, 1
			# salto a whileDiv
			j whileDiv
		exitDiv:
			# se guarda $a0 en $v1 y se regresa a main
			move $v1, $a0
			jr $ra
	
	mult10:
		# se establece en 0 $t0 y $v0
		addi $t0, $zero, 0
		addi $v0, $zero, 0
		whileMult:
			# si $t0 es igual a 10 se salta a exitMult
			beq $t0, 10, exitMult
			# se suma $a0 a $v0 y se guarda en $v0 y $t0 se incrementa en 1
			add $v0, $v0, $a0
			addi $t0, $t0, 1
			# salto a whileMult
			j whileMult
		exitMult:
			#se regresa a main
			jr $ra
