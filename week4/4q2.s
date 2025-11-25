.data
Ansh: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
msg: .asciiz "Enter a number to check in a array by linear search "
result1: .asciiz "Number is found "
result2: .asciiz "Number was not found "

.text
main:

li $t7,1 #index to check if array is done searching

li $v0,4
la $a0,msg
syscall

la $t0,Ansh     # array loaded on $t0

li $v0,5
syscall
move $t1,$v0        #number taken from user stored in $t1

loop:
lw $t8,0($t0)
bne $t1,$t8,forward

li $v0,4
la $a0,result1
syscall

li $v0,1
move $a0,$t1
syscall

j endd

forward:
addi $t7,$t7,1
beq $t7,10,endd
addi $t0,$t0,4
j loop

endd:
li $v0,10
syscall
.end main


