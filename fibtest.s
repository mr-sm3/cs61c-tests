.data

InputArray:   .word 1 7 6 0 

Space: .asciiz " "

BeforeString:   .asciiz "Input should be '1 7 6', and it is: "

AfterString:   .asciiz "After calling, it should be '1 13 8'. It is: "

.text

main:
#Feel free to edit this for your own tests, but this part will not be graded
#Print Array before running code
la a0 BeforeString
jal print_str
la a0 InputArray
jal print_array
jal print_newline
#Run callfib
la a0 InputArray
jal callfib
mv s0 a0
#Print String after running code
la a0 AfterString
jal print_str
la a0 InputArray
jal print_array
jal print_newline
#Exits the program
li a0 10
ecall



callfib:
#Runs the function fib on all elements of the input array a0. You may assume that all values of the array are nonzero, and that the array terminates on the first
#entry which is zero. Stores the results in the original array
#YOUR CODE HERE

addi sp, sp -16
sw s0, 0(sp)
sw s1, 4(sp)
sw s2, 8(sp)
sw ra, 12(sp)

add s0, a0, x0
j callfb_loop_start

callfb_loop_start:
ebreak
lw s1, 0(s0)
beq s1, x0, end
add a0, s1, x0
jal ra fib
sw a0, 0(s0)
addi s0, s0, 4
#slli s0, s0, 2
j callfb_loop_start
#li a0 0

end:
add a0, s0, x0
lw s0, 0(sp)
lw s1, 4(sp)
lw s2, 8(sp)
lw ra, 12(sp)
addi sp, sp, 16
#jr ra


fib:
#Recursively determines the a0th fibonacci number.
#YOUR CODE HERE
addi sp, sp, -20
sw s0, 0(sp)
sw s1, 4(sp)
sw s2, 8(sp)
sw s3, 12(sp)
sw ra, 16(sp)
#initiate the index and counter
addi s0, a0, -1
add s1, x0, x0
#initiate current, and next
addi s2, x0, 0
addi s3, x0, 1
beq s0, s1, return0
beq s0, s3, return1
j loop_start

loop_start:
beq s0, s1, loop_end
add a0, s2, s3
add t0, s2, x0
add s2, s3, x0
add s3, t0, s3
addi s1, s1, 1
j loop_start
loop_end:

lw s0, 0(sp)
lw s1, 4(sp)
lw s2, 8(sp)
lw s3, 12(sp)
lw ra, 16(sp)
addi sp, sp, 20
add a0, a0, x0
jr ra

return0:

lw s0, 0(sp)
lw s1, 4(sp)
lw s2, 8(sp)
lw s3, 12(sp)
lw ra, 16(sp)
addi sp, sp, 20
addi a0, x0, 1
jr ra

return1:

lw s0, 0(sp)
lw s1, 4(sp)
lw s2, 8(sp)
lw s3, 12(sp)
lw ra, 16(sp)
addi sp, sp, 20
addi a0, x0, 1
jr ra

###########################################
#Utility Functions
###########################################
print_int:
    mv a1, a0
    li a0, 1
    ecall
    jr    ra

print_str:
    mv a1, a0
    li a0, 4
    ecall
    jr    ra

print_newline:
    li a1, '\n'
    li a0, 11
    ecall
    jr    ra
    
print_array:
	addi sp sp -8
    sw s0 0(sp)
    sw ra 4(sp)
    mv s0 a0
    printarrayLoop:
    lw a0 0(s0)
    beq a0 x0 printarrayEnd
    jal print_int
    la a0 Space
    jal print_str
    addi s0 s0 4
    j printarrayLoop
    printarrayEnd:
    lw s0 0(sp)
    lw ra 4(sp)
    addi sp sp 8
    jr ra