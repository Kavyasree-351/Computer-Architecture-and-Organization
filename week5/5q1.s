.data

A: .word 10, 9, 8, 40, 6, 5, 20, 3, 2, 1

msg: .asciiz "The largest element in the array is: "

.text
main:

li $v0,4
la $a0,msg
syscall

la $s1,A
lw $t0,0($s1)
li $t7,10
li $t6,1


loop:
lw $t1,0($s1)
bgt $t0,$t1,greater
move $t0,$t1

greater:
addi $s1,$s1,4
sub $t7,$t7,$t6
beq $t7,$0,endd
j loop


endd:
li $v0,1
move $a0,$t0
syscall

li $v0,10
syscall
.end main




