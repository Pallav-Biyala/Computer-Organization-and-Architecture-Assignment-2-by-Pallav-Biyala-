Do: 	addi $a0, $0, $0 
	lw  $t1,  0($gp) 
	lw  $t2,  4($gp) 
	add $t3, $t2, $t1 
	sub $t4, $t2, $t1 
	slt $t5, $t4, $t3 
	beq $t5, $0, noswp 
	nop  
swp: 	sw  $t2  0($gp) 
	sw  $t1  4($gp) 
noswp 	j do