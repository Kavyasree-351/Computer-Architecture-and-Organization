 .data
array:          .word 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
array_size:     .word 10
element_msg:    .asciiz "Enter element: "
found_msg:      .asciiz "The element is found: "
not_found_msg:  .asciiz "The element is not found: "
index_msg:      .asciiz "The element is found at index: "
newline:        .asciiz "\n"

        .text
        .globl main

main:
        # prompt for element
        li   $v0, 4
        la   $a0, element_msg
        syscall

        li   $v0, 5        # read integer
        syscall
        move $s0, $v0     # $s0 = search element

        la   $a0, array    # $a0 = base address of array
        move $a1, $s0     # $a1 = element to search
        li   $a2, 0       # left = 0
        li   $a3, 9       # right = size-1 (10 elements -> index 9)
        jal  bin_search
        move $s1, $v0     # result in $s1

        li   $t0, -1
        beq  $s1, $t0, print_not_found

        # print found message and index
        li   $v0, 4
        la   $a0, found_msg
        syscall

        li   $v0, 4
        la   $a0, index_msg
        syscall

        li   $v0, 1
        move $a0, $s1
        syscall

        li   $v0, 4
        la   $a0, newline
        syscall

        j    done

print_not_found:
        li   $v0, 4
        la   $a0, not_found_msg
        syscall

        li   $v0, 4
        la   $a0, newline
        syscall

done:
        li   $v0, 10
        syscall

# ------------------------------------------------------------------
# Recursive binary search:
# Arguments on entry:
#   $a0 = base address of array
#   $a1 = key (value to search)
#   $a2 = left index
#   $a3 = right index
# Returns:
#   $v0 = index if found, -1 if not found
# Preserves: $ra via stack; restores $a0-$a3 from stack as saved.
# ------------------------------------------------------------------
bin_search:
        addi $sp, $sp, -24
        sw   $ra, 20($sp)
        sw   $a0, 16($sp)
        sw   $a1, 12($sp)
        sw   $a2, 8($sp)
        sw   $a3, 4($sp)

        # if left > right -> not found
        bgt  $a2, $a3, not_found

        # mid = (left + right) / 2
        add  $t0, $a2, $a3
        li   $t1, 2
        divu $t0, $t1
        mflo $t2            # $t2 = mid

        # load array[mid]
        sll  $t3, $t2, 2    # offset = mid * 4
        add  $t3, $a0, $t3  # address = base + offset
        lw   $t4, 0($t3)    # t4 = array[mid]

        beq  $a1, $t4, found
        blt  $a1, $t4, left_half

        # right half: left = mid + 1
        addi $a2, $t2, 1
        jal  bin_search
        j    bin_search_end

left_half:
        # left half: right = mid - 1
        addi $a3, $t2, -1
        jal  bin_search

bin_search_end:
        lw   $ra, 20($sp)
        lw   $a0, 16($sp)
        lw   $a1, 12($sp)
        lw   $a2, 8($sp)
        lw   $a3, 4($sp)
        addi $sp, $sp, 24
        jr   $ra

found:
        move $v0, $t2
        j    bin_search_end

not_found:
        li   $v0, -1
        j    bin_search_end
