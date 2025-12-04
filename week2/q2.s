.data
input1: .asciiz “Enter integer 1: ”
input2: .asciiz “Enter integer 2: ”
result: .asciiz “The result is: ”
num1: .word 0
num2: .word 0
sum: .word 0
.text
main: li $v0, 4
la $a0, input1
syscall
li $v0, 5
syscall
move $t0, $v0
sw $t0,num1
li $v0, 4
la $a0, input2
syscall
li $v0, 5
syscall
move $t1, $v0
sw $t1, num2
lw $t0,num1
lw $t1,num2
add $t2, $t0, $t1
sw $t2, sum
li $v0, 4
la $a0, result
syscall
li $v0, 1
lw $a0,sum
syscall
li $v0,10
syscall
