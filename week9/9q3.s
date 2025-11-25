     .data
  msg_a: .asciiz "Enter coefficient of a: "
  msg_b: .asciiz "Enter coefficient of b: "
  msg_c: .asciiz "Enter coefficient of c: "
  prompt: .asciiz "Enter the value of x: "
  result: .asciiz "Polynomial result y: "
           .text
  
  main:   li $v0, 4
         la $a0, msg_a
        syscall

         li $v0, 6
        syscall
         mov.s $f2, $f0

         li $v0, 4
         la $a0, msg_b
         syscall
li $v0, 6
syscall
mov.s $f4, $f0

li $v0, 4
la $a0, msg_c
syscall

li $v0, 6
syscall
mov.s $f6, $f0
li $v0, 4
la $a0, prompt
syscall

li $v0, 6
syscall
mov.s $f8, $f0

mul.s $f10, $f8, $f8
mul.s $f12, $f2, $f10
mul.s $f14, $f4, $f8
add.s $f16, $f12, $f14
add.s $f18, $f16, $f6

li $v0, 4
la $a0, result
syscall

mov.s $f12, $f18
li $v0,2
syscall

li $v0, 10
syscall
