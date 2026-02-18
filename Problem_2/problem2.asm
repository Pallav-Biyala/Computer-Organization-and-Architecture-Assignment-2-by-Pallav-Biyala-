	.data
A:      .word 1,2,3,4,5,6,7,8,9
B:      .word 9,8,7,6,5,4,3,2,1
result: .space 36      # 9 elements * 4 bytes
N:      .word 3

	.text
	.globl main

main:
	# Adding elements to the arguement registers
	la $a0, A
	la $a1, B
	la $a2, result
	lw $a3, N
	
	jal sum_matrix
	li $v0,10
	syscall
	
# Function call
sum_matrix:
	# Instead of two for loops since we are flattening matrices, we can just move till n*n elements 
	move $t1,$a3 # t1 = n
	mult $t1,$t1
	mflo $t2 # $t2 = n*n

	Loop:
		beq $t2, $0, end # if n*n == 0, we have done iteration n*n times and covered all n elements
		lw $t3, 0($a0) # $t3 = A[0]
		lw $t4, 0($a1) # $t4 = B[0]
		
		add $t5, $t3,$t4 # t5 = A[0] + B[0]
		sw $t5, 0($a2) # result[0] = $t5
		
		# moving to next elements
		addi $a0, $a0, 4
		addi $a1, $a1, 4
		addi $a2, $a2, 4
		
		# n -- 
		addi $t2, $t2, -1 
		
		j Loop
	end:
		jr $ra
		
		
		
			 
