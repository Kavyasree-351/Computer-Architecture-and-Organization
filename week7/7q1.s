.data
x: .word 15
y: .word 3
msg_sum: .asciiz "Sum: "
msg_diff: .asciiz "\nDifference: "
msg_prod: .asciiz "\nProduct: "
msg_quot: .asciiz "\nQuotient: "

.text
.globl main

main:
lw $a0, x
lw $a1, y
jal sum
move $t0, $v0


lw $a0, x
lw $a1, y
jal difference
move $t1, $v0

lw $a0, x
lw $a1, y
jal product
move $t2, $v0

lw $a0, x
lw $a1, y
jal quotient
move $t3, $v0

la $a0, msg_sum
li $v0, 4
syscall
move $a0, $t0
li $v0, 1
syscall

la $a0, msg_diff
li $v0, 4
syscall
move $a0, $t1
li $v0, 1
syscall

la $a0, msg_prod
li $v0, 4
syscall
move $a0, $t2
li $v0, 1
syscall

la $a0, msg_quot
li $v0, 4
syscall
move $a0, $t3
li $v0, 1
syscall

li $v0, 10
syscall
sum:
add $v0, $a0, $a1
jr $ra

difference:
sub $v0, $a0, $a1
jr $ra

product:
mul $v0, $a0, $a1
jr $ra

quotient:
div $a0, $a1
mflo $v0
jr $ra
