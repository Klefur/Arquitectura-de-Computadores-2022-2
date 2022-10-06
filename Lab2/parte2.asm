.data
	numero: .space 12
	resultado: .asciiz "El resultado de sumar "
	punto: .asciiz "con "
	menos: .asciiz " es"
	uno: .double 1.00
	dos: .double 2.00
	
.text
	main:
		addi $a1, $zero, 51
		
		# se transforma el int a double
  		mtc1.d $a1, $f2
  		cvt.d.w $f2, $f2
  		
  		# se guarda 1.00 y 2.00
  		ldc1 $f0, uno
  		ldc1 $f10, dos
		
		jal newtonRaphson
		
		li $v0, 10
		syscall
		
	newtonRaphson:
		addi $sp, $sp, -4
		sw $ra, ($sp)
		
  		beq $t0, 7, exit
  		
		jal f
		jal df
		
		div.d $f4, $f4, $f6
		sub.d $f0, $f0, $f4
		
		addi $t0, $t0, 1 
		jal newtonRaphson
		
		exit:
		lw $ra, ($sp)
		addi $sp, $sp, 4
		
	f:
		mul.d $f4, $f0, $f0
		sub.d $f4, $f4, $f2
		jr $ra
	
	df:
		mul.d $f6, $f0, $f10
		jr $ra
