.data
	array1: .space 40
	str1: .asciiz "Type in array numbers:\n"
	str2: .asciiz "Type in occurrence value: "
	str3: .asciiz "Occurances indices are: "
	str4: .asciiz ", "
	str5: .asciiz "\n"
	str6: .asciiz "Number of occurrences found: "
.text	 
main:
	# Print
	la $a0, str1
	ori $v0, $0, 4
	syscall

	# Load array into t0
	la 	$t0, array1

	# define the index var for loop
	addi $s0, $s0, 0
ReadLoop:
	# Compare $s0 with 10. If $s0 < 10 then $t1=1
	slt $t1, $s0, 10
	bne $t1, 1, EndReadLoop
	nop
	
	# Read user input to t2
	ori $v0, $0, 5
	syscall
	addu $t2, $0, $v0
	
	# Saves user input to array
	sw $t2, ($t0)
	
	# increment index by 1
	addi $t0, $t0, 4
	addi $s0, $s0, 1
	
	
	# go back to the top of the loop
	j ReadLoop
EndReadLoop:

	# Print
	la $a0, str2
	ori $v0, $0, 4
	syscall
	
	# Read user input to t3
	ori $v0, $0, 5
	syscall
	addu $t3, $0, $v0	
	
	# Print
	la $a0, str3
	ori $v0, $0, 4
	syscall
	
	# load array
	la 	$t0, array1
	
	# define variable to keep track of the number of occurrences
	addi $t5, $t5, 0
	
	# define the index var for loop
	addi $s1, $s1, 0
CheckLoop:
	# Compare $s1 with 10. If $s1 < 10 then $t1=1
	slt $t1, $s1, 10
	bne $t1, 1, EndCheckLoop
	nop
	
	# Load array[i] into t2
	lw $t2, ($t0)
	
	# If array[i] != occurrenceNum, goto NotEqual
	bne $t2, $t3, NotEqual
	
	# Print index of match
	addu $a0, $0, $s1
	ori $v0, $0, 1
	syscall
	# Print a comma
	la $a0, str4
	ori $v0, $0, 4
	syscall
	
	# Increment occurrence counter
	addi $t5, $t5, 1
	
NotEqual:

	# increment index by 1
	addi $t0, $t0, 4
	addi $s1, $s1, 1

	# go back to the top of the loop
	j CheckLoop
EndCheckLoop:

	# new line
	la $a0, str5
	ori $v0, $0, 4
	syscall

	# Print
	la $a0, str6
	ori $v0, $0, 4
	syscall
	
	# print number of occurrences
	addu $a0, $0, $t5
	ori $v0, $0, 1
	syscall

Exit:
	ori $v0, $0, 10
	syscall