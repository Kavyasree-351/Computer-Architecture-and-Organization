   .data
  pi: .float 3.1415926535897924
  radius: .float 0.0
  area: .float 0.0
  radius_msg: .asciiz "Enter radius: "
  area_msg: .asciiz "Circle Area = "
  	  .text
  main:   li $v0, 4
  	        la $a0, radius_msg
 	        syscall
 
 	        li $v0, 6
              syscall
              mov.s $f2, $f0
              l.s $f4, pi
              mul.s $f6, $f2, $f2
              mul.s $f8, $f4, $f6
 
                    li $v0, 4
             la $a0, area_msg
             syscall
             mov.s $f12, $f8
             li $v0, 2
             syscall

             li $v0, 10
             syscall
