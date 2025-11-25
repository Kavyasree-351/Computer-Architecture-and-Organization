.data
array:  .word 10, 20, 30, 40, 50   # array with 5 integers
msg:    .asciiz "Sum of array: "

.text
.globl main
main:
    li   $t0, 0          # sum = 0
    li   $t1, 0          # i = 0 (index)
    li   $t2, 5          # n = 5 (array size)

loop:
    beq  $t1, $t2, done  # if i == n → exit loop
    la   $t3, array      # load base address of array
    sll  $t4, $t1, 2     # offset = i * 4 (word = 4 bytes)
    add  $t5, $t3, $t4   # address of array[i]
    lw   $t6, 0($t5)     # load array[i]
    add  $t0, $t0, $t6   # sum += array[i]
    addi $t1, $t1, 1     # i++
    j    loop            # repeat

done:
    # print message
    li   $v0, 4
    la   $a0, msg
    syscall

    # print sum
    move $a0, $t0  #$v0 = 1 → print integer syscall.
    li   $v0, 1    #$a0 = $t0 → load the final sum (150).
    syscall

    # exit program
    li   $v0, 10
    syscall
