.data
x:       .word 15                   # Variable x = 15
y:       .word 3                    # Variable y = 3
msg_sum:  .asciiz "Sum: "           # Message for sum output
msg_diff: .asciiz "\nDifference: "  # Message for difference output
msg_prod: .asciiz "\nProduct: "     # Message for product output
msg_quot: .asciiz "\nQuotient: "   # Message for quotient output

.text
.globl main

main:
    
    # Compute sum of x and y
    lw $a0, x         # Load x into $a0
    lw $a1, y         # Load y into $a1
    jal sum           # Call sum function
    move $t0, $v0     # Store result of sum in $t0


    # Compute difference (x - y)
    lw $a0, x
    lw $a1, y
    jal difference    # Call difference function
    move $t1, $v0     # Store result in $t1

    # Compute product (x * y)
    lw $a0, x
    lw $a1, y
    jal product       # Call product function
    move $t2, $v0     # Store result in $t2

    
    # Compute quotient (x / y)
    lw $a0, x
    lw $a1, y
    jal quotient      # Call quotient function
    move $t3, $v0     # Store result in $t3

   
    # Print results
    la $a0, msg_sum   # Load message for sum
    li $v0, 4         # Syscall 4 = print string
    syscall
    move $a0, $t0     # Load sum result
    li $v0, 1         # Syscall 1 = print integer
    syscall

    la $a0, msg_diff
    li $v0, 4
    syscall
    move $a0, $t1     # Load difference result
    li $v0, 1
    syscall

    la $a0, msg_prod
    li $v0, 4
    syscall
    move $a0, $t2     # Load product result
    li $v0, 1
    syscall

    la $a0, msg_quot
    li $v0, 4
    syscall
    move $a0, $t3     # Load quotient result
    li $v0, 1
    syscall

    # Exit program
    li $v0, 10        # Syscall 10 = exit
    syscall


# Function: sum
# Arguments: $a0, $a1
# Returns: $v0 = sum of $a0 and $a1
sum:
    add $v0, $a0, $a1
    jr $ra

# Function: difference
# Arguments: $a0, $a1
# Returns: $v0 = $a0 - $a1
difference:
    sub $v0, $a0, $a1
    jr $ra


# Function: product
# Arguments: $a0, $a1
# Returns: $v0 = $a0 * $a1
product:
    mul $v0, $a0, $a1
    jr $ra


# Function: quotient
# Arguments: $a0, $a1
# Returns: $v0 = $a0 / $a1
quotient:
    div $a0, $a1       # Divide $a0 by $a1
    mflo $v0           # Move quotient from LO register to $v0
    jr $ra
