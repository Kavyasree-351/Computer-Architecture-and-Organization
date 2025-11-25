.data
array:        .word 2, 4, 6, 8, 10, 12
n:            .word 6
msg_found:    .asciiz "Element found at index: "
msg_notfound: .asciiz "Element not found\n"

.text
.globl main
main:
    la $a0, array
    lw $a1, n
    li $a2, 8
    jal linear_search

    beq $v0, $zero, not_found

    la $a0, msg_found
    li $v0, 4
    syscall

    move $a0, $v1  # index
    li $v0, 1
    syscall
    j exit_prog

not_found:
    la $a0, msg_notfound
    li $v0, 4
    syscall

exit_prog:
    li $v0, 10
    syscall

linear_search:
    move $t0, $a0    
    move $t1, $a1    
    move $t2, $a2    
    li $t3, 0        

search_loop:
    beq $t3, $t1, not_found_label
    lw $t4, 0($t0)
    beq $t4, $t2, found_label
    addi $t0, $t0, 4
    addi $t3, $t3, 1
    j search_loop

found_label:
    li $v0, 1
    move $v1, $t3
    jr $ra

not_found_label:
    li $v0, 0
    li $v1, -1
    jr $ra
