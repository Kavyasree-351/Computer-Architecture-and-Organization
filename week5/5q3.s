.data
A:    .word 1, 2, 3, 4, 5
B:    .word 10, 20, 30, 40, 50
C:    .space 20              # reserve 5 words (5*4=20 bytes)
msg:  .asciiz "Result array c = a + b: "

.text
.globl main
main:
    li   $t0, 0          # i = 0
    li   $t1, 5          # n = 5

    # print message
    li   $v0, 4
    la   $a0, msg
    syscall

sum_loop:
    beq  $t0, $t1, done  # if i == n → exit loop

    la   $t2, A          # load base address of array A into $t2
    la   $t3, B          # load base address of array B into $t3
    la   $t4, C          # load base address of array C into $t4

    sll  $t5, $t0, 2      # offset = i * 4

    # load a[i]
    add  $t6, $t2, $t5  # address = base of A + offset
    lw   $t7, 0($t6)     # load value A[i] into $t7

    # load b[i]
    add  $t8, $t3, $t5   # address = base of B + offset
    lw   $t9, 0($t8)     # load value B[i] into $t9

    # c[i] = a[i] + b[i]
    add  $s0, $t7, $t9

    # store in c[i]
    add  $s1, $t4, $t5   # address = base of C + offset
    sw   $s0, 0($s1)     # store result in C[i]

    # print c[i]
   move $a0, $s0         # move the sum to $a0 (argument for print)
    li   $v0, 1          # syscall code 1 = print integer
    syscall              

    # print space
    li   $v0, 11         # syscall code 11 = print character
    li   $a0, 32         # 32 = ASCII code for space (' ')
    syscall

    addi $t0, $t0, 1      # i++
    j    sum_loop         # jump back to start of loop

done:
    li   $v0, 10          # exit
    syscall
