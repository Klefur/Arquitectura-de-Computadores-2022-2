.data
	v1: .space 12
	v2: .space 12
	pedir1: .asciiz "Ingrese el vector 1: \n"
	pedir2: .asciiz "Ingrese el vector 2: \n"
	cero: .double 0.0
	uno: .double 1.0
	dos: .double 2.0
	resultado: .asciiz "El resultado es: "
	
.text
	main:
		# se imprime el tag pedir1
		li $v0 4
		la $a0, pedir1
		syscall
		
		# se establece $a0 en 0 para usarlo de indice
		# se llama a la subrutina whilePedir1
		addi $a0, $zero, 0 
		jal whilePedir1
		
		# se imprime el tag pedir2
		li $v0 4
		la $a0, pedir2
		syscall
		
		# se establece $a0 en 0 para usarlo de indice
		# se llama a la subrutina whilePedir2
		addi $a0, $zero, 0 
		jal whilePedir2
		
		# se establece $a0 en 0 para usarlo de indice, $t6 como acumulador
		# se restablece $v0 a 0 para poder utilizarlo de retorno
		# se llama a la subrutina multComponentes
		addi $a0, $zero, 0
		addi $v0, $zero, 0
		jal multComponentes
		move $t6, $v0
		
		# se transforma el int a double
  		mtc1.d $t6, $f2
  		cvt.d.w $f2, $f2
  		
  		# se guarda 0.00 1.00 y 2.00
  		ldc1 $f0, uno
  		ldc1 $f10, dos
  		ldc1 $f12, cero
		
		# se establece $t0 en 0 para usarlo de indice
		# se llama a la subrutina newtonRaphson
		addi $t0, $zero, 0
		jal newtonRaphson
		# se imprime el tag resultado
		li $v0, 4
		la $a0, resultado
		syscall
		# se imprime el double en $f12		
		li $v0, 3
		add.d $f12, $f12, $f0
		syscall
		
		# fin de programa
		li $v0, 10
		syscall
		
	whilePedir1:
		# hasta que $a0 sea 3 se pide un numero para contruir el vector 1
		beq $a0, 3, exitPedir1
		li $v0, 5
		syscall
		mul $t0, $a0, 4
		sw $v0, v1($t0)
		addi $a0, $a0, 1
		j whilePedir1
		exitPedir1:
		jr $ra
		
	whilePedir2:
		# hasta que $a0 sea 3 se pide un numero para contruir el vector 2
		beq $a0, 3, exitPedir2
		li $v0, 5
		syscall
		mul $t0, $a0, 4
		sw $v0, v2($t0)
		addi $a0, $a0, 1
		j whilePedir2
		exitPedir2:			
		jr $ra
	
	multComponentes:
		# hasta que $a0 sea 3 se multiplican los componentes de v1 y v2 para calcular
		# sus diferencias y luego elevarlos al cuadrado
		beq $a0, 3, exitMultComps
		mul $s0, $a0, 4
			
		lw $t1, v1($s0)
		lw $t2, v2($s0)
			
		sub $t3, $t1, $t2
		mul $t3, $t3, $t3
		
		add $v0, $v0, $t3
		addi $a0, $a0, 1
		j multComponentes
		exitMultComps:
		jr $ra
	
	newtonRaphson:
		# se crea espacio en el stack y se almacera $ra
		addi $sp, $sp, -4
		sw $ra, ($sp)
		# se realiza 7 veces la aproximacion newton raphson
  		beq $t0, 7, exitNewton
		
		jal f
		jal df
		
		addi $t0, $t0, 1 
		jal newtonRaphson
		# salida de regreso por cada llamada hasta llegar al main
		exitNewton:
		lw $ra, ($sp)
		addi $sp, $sp, 4
		jr $ra
	
	f:
		# funcion usada para la aproximacion f(x) = (x^2) - n donde n es el numero a calcular
		mul.d $f4, $f0, $f0
		sub.d $f4, $f4, $f2
		jr $ra
		
	df:
		# derivada de la funcion usada para la aproximacion f'(x) = 2x
		mul.d $f6, $f0, $f10
	
		div.d $f4, $f4, $f6
		sub.d $f0, $f0, $f4
		jr $ra
