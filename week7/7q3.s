.data
prompt: .asciiz "Enter number of Fibonacci terms: "
msg:    .asciiz "Fibonacci Series:\n"
newline:.asciiz "\n"
overflow_msg: .asciiz "Arithmetic overflow detected\n"

.text
.globl main

main:
    la $a0, prompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $a0, $v0

    jal fibo

    li $v0, 10
    syscall

fibo:
    move $s0, $a0
    li $t0, 2
    li $t1, 0
    li $t2, 1

    la $a0, msg
    li $v0, 4
    syscall

    move $a0, $t1
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    move $a0, $t2
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    blez $s0, end_fib

loop:
    beq $t0, $s0, end_fib
    add $t3, $t1, $t2

    xor $t4, $t1, $t2
    bltz $t4, no_overflow
    xor $t5, $t1, $t3
    bgez $t5, no_overflow

    la $a0, overflow_msg
    li $v0, 4
    syscall
    li $v0, 10
    syscall

no_overflow:
    move $a0, $t3
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    move $t1, $t2
    move $t2, $t3

    addi $t0, $t0, 1
    j loop

end_fib:
    jr $ra
