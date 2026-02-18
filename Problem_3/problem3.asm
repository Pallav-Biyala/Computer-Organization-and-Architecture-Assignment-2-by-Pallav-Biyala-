	.data
arr	.word 9,1,5,2,10,12,6
n	.word 7

	.text
	.globl main

main:
	la $a0, arr # stores abse address of arr
	jal sort
	li $v0, 10
	syscall
	
# Sort function is non leaf
sort:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	# $a0 already contains arr
	li $a1, 0 # a1 = 0 = low
	lw $t0, n # t0 = n = high
	addi $a2, $t0, -1 # a2 = high-1 = n-1
	jal quicksort
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	

# Swap function is leaf function so no need to store $ra.
swap:
	lw $t8, 0($a0) # $t0 = arr[a]
	lw $t9, 0($a1) # $t1 = arr[b]
	
	sw $t9, 0($a0) # storing value of arr[b] in arr[a]
	sw $t8, 0($a1) # storing value of arr[a] in arr[b]
	jr $ra
	
# Partition function is non leaf function need to store $ra
partition:
	# Function prologue
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	# Function Body
	move $t0, $a0 # t0 stores address of arr[0]
	move $t1, $a1 # stores LOW INDEX
	move $t2, $a2 # stores HIGH INDEX
	
	# now we need to store arr[high] for pivot: so address = high*4 + base
	sll $t3, $t2, 2
	add $t3, $t3, $t0 # $t3 stores address of arr[high]
	lw $t3, 0($t3) # $t3 = pivot = arr[high]
	
	# i and j pointers
	addi $t4, $t1,-1 # i = low -1
	move $t5,$t1  # j = low 
	
	
	
	# Now loop time
	Loop:
		bge $t5, $t2, skip # if j>=high skip
		
		# store arr[j] = j*4 + base
		sll $t6, $t5, 2
		add $t6, $t6, $t0 # address of arr[j]
		lw $t8, 0($t6) # arr[j]
		
		# now if condition
		bge $t8, $t3, else
		addi $t4,$t4,1 # i++
		
		# Now we need to load arr[i] and arr[j] in a0 and a1. since t6 stores arr[j] it moves to a1
		# finding arr[i] = i*4 +base
		sll $t7, $t4, 2
		add $t7, $t7, $t0 # $t7 stores address of arr[i]
		move $a0, $t7 
		move $a1, $t6
		
		# now call swap
		jal swap
		else:
			addi $t5, $t5, 1 
			j Loop
	
	skip:
		# now we just need to swap arr[i+1] and arr[high]
		# so address = (i+1)*4 + base 
		addi $t4, $t4, 1 # i+1
		sll $t7, $t4, 2
		add $t7, $t7, $t0 # $t7 stores address of arr[i+1]
		move $a0, $t7
		
		# so address = (HIGH)*4 + base 
		sll $t8, $t2, 2
		add $t8, $t8, $t0 # address of arr[high]
		move $a1, $t8  
		
		jal swap
		
		move $v0, $t4
		
	# Function epilogue
	lw $ra, 0($sp)
	addi $sp,$sp,4
	jr $ra
	
	
# Quicksort function is a non leaf function
quicksort:
	# Prologue
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	sw $t2, 12($sp)
	sw $t3, 16($sp)
	
	
	# Function Body
	move $t0, $a0 # address of arr[0]
	move $t1, $a1 # address of low
	move $t2, $a2 # address of high
	
	bge $t1,$t2, end # if low>= high skip
	# partition uses same $a0,$a1,$a2
	move $a0, $t0
	move $a1, $t1
	move $a2, $t2
	jal partition
	move $t3, $v0 # t3 = p
	
	# calling quicksort low,p-1
	move $a0, $t0
	move $a1, $t1
	addi $a2, $t3, -1
	jal quicksort
	lw $t3, 16($sp)   # restoring pivot index

	
	# calling quicksort p+1,high
	move $a0, $t0
	addi $a1, $t3,1
	move $a2, $t2
	jal quicksort

	
	# Function epilogue
	end:
    		lw $ra, 0($sp)
    		lw $t0, 4($sp)
    		lw $t1, 8($sp)
    		lw $t2, 12($sp)
    		lw $t3, 16($sp)	
    		addi $sp, $sp, 20
    		jr $ra

	
	
