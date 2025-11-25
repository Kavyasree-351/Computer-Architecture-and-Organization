.data
input: .asciiz "Enter temperature in F: "
result: .asciiz "Temperature in Celsius is: "
const5: .float 5.0
const9: .float 9.0
const32: .float 32.0
.text

main:   	li $v0, 4
la $a0, input
syscall

li $v0, 6
syscall
mov.s $f2, $f0

l.s $f4, const5
l.s $f6, const9
l.s $f8, const32

sub.s $f10, $f2, $f8
div.s $f12, $f4, $f6

mul.s $f14, $f12, $f10

li $v0, 4
la $a0, result
syscall

mov.s $f12, $f14
li $v0, 2
syscall

li $v0, 10
syscall
