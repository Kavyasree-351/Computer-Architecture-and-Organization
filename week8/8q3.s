.data
number: .asciiz "Enter a number n: "
result: .asciiz "Sum is: "
newline: .asciiz "\n"
	.text

main:	li $v0, 4
	la $a0, number
	syscall

	li $v0, 5
	syscall
	move $a0, $v0

	jal RSum 
	move $s0, $v0
	
	li $v0, 4
	la $a0, result
	syscall

	li $v0, 1
	move $a0, $s0
	syscall

	li $v0, 4
	la $a0, newline
	syscall

	li $v0, 10
	syscall

RSum: 	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, 0($sp)

	li $t0, 1
	beq $a0, $t0, base

	addi $a0, $a0, -1
	jal RSum 
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	add $v0, $v0, $a0
	addi $sp, $sp, 8
	jr $ra 

base:	move $v0, $a0
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	jr $ra 
