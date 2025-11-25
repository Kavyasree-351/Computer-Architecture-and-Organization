.data
prompt:         .asciiz "Enter number of Fibonacci terms: "  # Prompt message for user input
msg:            .asciiz "Fibonacci Series:\n"              # Message displayed before series output
newline:        .asciiz "\n"                               # Newline character to format output
overflow_msg:   .asciiz "Arithmetic overflow detected\n"   # Message displayed in case of integer overflow

.text
.globl main

main:
    # Print prompt message
    la $a0, prompt       # Load address of 'prompt' into $a0
    li $v0, 4            # System call code 4 = print string
    syscall

    # Read integer input from user
    li $v0, 5            # System call code 5 = read integer
    syscall
    move $a0, $v0        # Move user input (number of Fibonacci terms) into $a0 for function call

    # Call Fibonacci function
    jal fibo             # Jump and link to fibo function

    # Exit program
    li $v0, 10           # System call code 10 = exit
    syscall

# Fibonacci function
fibo:
    move $s0, $a0        # Store the number of terms in $s0
    li $t0, 2            # Initialize counter starting from 2 (first two terms already handled)
    li $t1, 0            # First Fibonacci term
    li $t2, 1            # Second Fibonacci term

    # Print "Fibonacci Series:" message
    la $a0, msg
    li $v0, 4
    syscall

    # Print first Fibonacci term
    move $a0, $t1
    li $v0, 1            # System call 1 = print integer
    syscall
    la $a0, newline      # Print newline
    li $v0, 4
    syscall

    # Print second Fibonacci term
    move $a0, $t2
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # If number of terms <= 0, skip loop
    blez $s0, end_fib     # Branch to end_fib if $s0 <= 0

loop:
    beq $t0, $s0, end_fib # If counter equals number of terms, end loop

    add $t3, $t1, $t2     # Compute next Fibonacci term: t3 = t1 + t2

    # Overflow detection
    # This uses a classic XOR-based check:
    xor $t4, $t1, $t2     # XOR of previous two terms
    bltz $t4, no_overflow  # If result is >= 0, continue (no overflow yet)
    xor $t5, $t1, $t3      # XOR of previous term and new term
    bgez $t5, no_overflow   # If result >= 0, continue (no overflow)
    
    # If overflow detected, print message and exit
    la $a0, overflow_msg
    li $v0, 4
    syscall
    li $v0, 10
    syscall

no_overflow:
    # Print next Fibonacci term
    move $a0, $t3
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # Update previous terms for next iteration
    move $t1, $t2
    move $t2, $t3

    addi $t0, $t0, 1      # Increment counter
    j loop                # Repeat loop

end_fib:
    jr $ra                # Return to caller
