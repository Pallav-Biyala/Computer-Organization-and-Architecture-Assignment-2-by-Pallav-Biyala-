.text
.globl main

main:
	move $a0, $gp #since it is given arr[0] base address is at gp so lets store address in a0
	li $a1, 100 #since size is given as 100
	jal find
	li $v0,10
	syscall
	
# Function call
find:
	# since we have to store output in callee saved registers, we are avoiding to store it in stack as we need data to be in them
	lw $t0, 0($a0) # max = a[0]
	lw $t1, 0($a0) # min = a[0]
	li $s0, 0 # max_idx = 0
	li $s1, 0 # min_idx = 0
	li $s2, 0 # sum = 0
	
	move $t2, $a1 # $t2 = 100
	move $t3, $a0 # t3 = address of arr[0] 
	addi $t4, $0, 0 # i = 0
	
	# finding all parameters
	Loop:
		beq $t2,$0, end # if t2 == 0, we are done. skip return
		lw $t5, 0($t3) # now t5 = arr[i] 
		# max time
		ble $t5, $t0, min # if t5<=max branch to min as max is not here
			move $t0, $t5 # max = t5
			move $s0, $t4 # max_idx = t4 = i
		
		# min time
		min: 
		bge $t5, $t1, sum # if t5>=min branch
			addi $t1, $t5, 0 # min = t5
			addi $s1, $t4, 0 # min_idx = t4 = i
		
		sum: 
		# sum time
		add $s2, $s2, $t5 # s2 += t5
		
		# incrementing i and moving to next element
		addi $t4, $t4, 1 # i++
		addi $t3, $t3, 4 # moving to next element
		addi $t2, $t2, -1 # n--
		j Loop
	
	end: 
		move $v0, $t0
		move $v1, $t1
		
		# max and min donw just average left
		move $t0, $a1
		div $s2, $t0
		mflo $s2
		jr $ra
		
		
