.data

.text
main:

li $t0,1 #a
li $t1,2 #b
li $t2,3 #c
li $t3,4 #d
li $t4,5 #e

# a - [(b * c) + (d % e)]

mult $t1,$t2
mflo $t5 

div $t3,$t4
mfhi $t6

add $t2,$t5,$t6 # $t2 = 10

sub $t0,$t0,$t2

li $v0,1
move $a0,$t0
syscall

li $v0,10
syscall

.end main
