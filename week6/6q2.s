.text
.globl main
main:
    # Load arguments for linear_search
    la $a0, array        # $a0 = base address of array
    lw $a1, n            # $a1 = number of elements (n)
    li $a2, 8            # $a2 = element to search for (key = 8)

    # Call linear_search function
    jal linear_search

    # Check the return value $v0
    beq $v0, $zero, not_found   # If $v0 == 0, element not found

    # Element found, print message
    la $a0, msg_found
    li $v0, 4            # syscall 4 = print string
    syscall

    # Print the index where element was found
    move $a0, $v1        # $v1 contains the index returned by function
    li $v0, 1            # syscall 1 = print integer
    syscall
    j exit_prog          # Jump to exit

not_found:
    # Element not found, print message
    la $a0, msg_notfound
    li $v0, 4            # syscall 4 = print string
    syscall

exit_prog:
    li $v0, 10           # syscall 10 = exit program
    syscall


# Linear search function
# Arguments:
#   $a0 = base address of array
#   $a1 = number of elements
#   $a2 = key to search
# Returns:
#   $v0 = 1 if found, 0 if not found
#   $v1 = index of element if found, -1 if not found
linear_search:
    move $t0, $a0        # $t0 = pointer to current element in array
    move $t1, $a1        # $t1 = number of elements (loop limit)
    move $t2, $a2        # $t2 = key to search
    li $t3, 0            # $t3 = index counter starting from 0

search_loop:
    beq $t3, $t1, not_found_label  # If index == n, element not found

    lw $t4, 0($t0)      # Load current array element into $t4
    beq $t4, $t2, found_label  # If current element == key, go to found

    addi $t0, $t0, 4    # Move pointer to next element (word = 4 bytes)
    addi $t3, $t3, 1    # Increment index counter
    j search_loop       # Repeat loop

found_label:
    li $v0, 1           # $v0 = 1 → element found
    move $v1, $t3       # $v1 = index where element found
    jr $ra              # Return to caller

not_found_label:
    li $v0, 0           # $v0 = 0 → element not found
    li $v1, -1          # $v1 = -1 → invalid index
    jr $ra              # Return to caller
