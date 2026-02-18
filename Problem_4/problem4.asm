.data
arr:    .word 2,5,10,11,13,15,21
n:      .word 7
key:    .word 21

.text
.globl main

main:
	la   $a0, arr        # base address of array
    	lw   $a1, n          # n
    	lw   $a2, key        # key to search
    	jal  binary_search

    	li   $v0, 10
    	syscall


# Function call
binary_search:
	li   $t0, 0          # low = 0
    	addi $t1, $a1, -1    # high = n-1
    	move $t4, $a2        # key

	Loop:
    		bgt  $t0, $t1, not_found   # if low > high → exit

    		# mid = (low + high)/2
    		add  $t2, $t0, $t1
    		srl  $t2, $t2, 1

   		# load arr[mid], $t2 contains index and hence address = base + index*4
    		sll  $t3, $t2, 2     # mid * 4
    		add  $t3, $t3, $a0   # address = base + offset
    		lw   $t3, 0($t3)     # arr[mid]

    		# if arr[mid] == key
    		beq  $t3, $t4, found

    		# if arr[mid] > key
    		bgt  $t3, $t4, go_left

    		# else arr[mid] < key
    		addi $t0, $t2, 1     # low = mid + 1
    		j Loop

	go_left:
    		addi $t1, $t2, -1    # high = mid - 1
    		j Loop

	found:
    		li $v0, 1 # $v0 = 1 means we found the element (true)
    		jr $ra

	not_found:
    		li $v0, 0 # $v0 = 0 means not found (false)
    		jr $ra
