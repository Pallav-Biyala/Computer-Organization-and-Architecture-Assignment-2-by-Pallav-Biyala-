.data 
A	.word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,0,2,2,3,2,5
B	.word 1,2,3,0,5,6,7,8,1,10,1,2,0,4,5,6,9,8,3,0,1,6,9,2,5
result  .space 100

.text
.globl main

main:
	la $a0, A # $a0 stores address of A
	la $a1, B # $a1 stores address of B
	la $a2, result # $a2 stores address of result
	jal matrix_multiplication
	
	li $v0, 10
	syscall
	
# Function call
matrix_multiplication:
	# Function prologue
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)

	move $s0, $a2 # stores base address of result 
	
	# Creating variables
	li $s1, 0 #i
	li $s4, 5 #n
	
	for_1: 
		beq $s1, $s4, end # if i == n we are done branch off
		li $s2, 0 #j
		
		for_2:
			beq $s2, $s4, i_plus_plus # if j == n means i = current value is completed now we need to incremenet i
			li $t5, 0 # sum container
			li $s3, 0 #k
			
			for_3:
				beq $s3, $s4, j_plus_plus # if k == n means j = current value is done now we need to increment j
				
				# Finding A[i][k]
				# Step 1: Find address = base + (i*5 + k)*4
				mult $s4, $s1
				mflo $t0 # let t0 store address
				add $t0, $t0, $s3 # 5i+k done
				sll $t0, $t0, 2 # (5i+k)*4 done
				add $t0, $t0, $a0 # base + (5i+k)*4 computed
				
				# Now extract value
				lw $t1, 0($t0) # $t1 stores A[i][k]
				
				# Finding B[k][j]
				# Step 1: Find address = base + (k*5 + j)*4
				mult $s4, $s3 
				mflo $t2 # let t2 store address
				add $t2, $t2, $s2 # 5k+j done
				sll $t2, $t2, 2 # (5k+j)*4 done
				add $t2, $t2, $a1 # base + (5k+j)*4 computed
				
				# Now extract value
				lw $t3, 0($t2) # $t3 stores B[k][j]
				
				# Let $t5 sontain sum
				mult $t1, $t3
				mflo $t6
				add $t5, $t5, $t6 # sum += A[i][k]*B[k][j] 
				
				# Now go for next k++
				addi $s3, $s3, 1 # k++
				j for_3
			
			j_plus_plus:
				# storing value of $t5 in result
				# Finding result[i][j] to know where to store
				
				# Step 1: Find address = base + (i*5 + j)*4
				mult $s4, $s1
				mflo $t4 # let t0 store address
				add $t4, $t4, $s2 # 5i+j done
				sll $t4, $t4, 2 # (5i+j)*4 done
				add $t4, $t4, $s0 # base + (5i+j)*4 computed
				
				# Now we can store result in $t4 as $t4 contains address 
				sw $t5, 0($t4)
				
				# now j++
				addi $s2, $s2, 1 #j++
				j for_2
		i_plus_plus:
			addi $s1, $s1, 1 #i++
			j for_1
	
	end:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		addi $sp, $sp, 20
		
		# adding returning value
		move $v0, $a2 # as $s0 stores base address of result
		jr $ra