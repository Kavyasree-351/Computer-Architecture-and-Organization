
	.data
input1: .asciiz "Enter a number a: "
exponent1: .asciiz "Enter the exponent n: "
result: .asciiz "Power of n is: "
newline: .asciiz "\n"
	.text
main:	li $v0, 4
	la $a0, input1
	syscall

	li $v0, 5
	syscall
	move $s0, $v0 

	li $v0, 4
	la $a0, exponent1
	syscall

	li $v0, 5
	syscall
	move $s1, $v0
	
	move $a0, $s0
	move $a1, $s1 
	jal power 

	move $s2, $v0
	
	li $v0, 4
	la $a0, result
	syscall

	li $v0, 1
	move $a0, $s2
	syscall

	li $v0, 4
	la $a0, newline
	syscall

	li $v0, 10
	syscall

power:	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a1, 0($sp)

	li $t0, 1
	beq $a1, $t0, base_case 
	
	addi $a1, $a1, -1
	jal power
	lw $a1, 0($sp)
	lw $ra, 4($sp)
	mul $v0, $a0, $v0
	addi $sp, $sp, 8
	jr $ra 
base_case:	move $v0, $a0
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		jr $ra 
