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
	la $a0, str1
	ori $v0, $0, 4
	syscall
	la $t0, array1
	addi $s0, $s0, 0
ReadLoop:
	slt $t1, $s0, 10
	bne $t1, 1, EndReadLoop
	nop
	ori $v0, $0, 5
	syscall
	addu $t2, $0, $v0
	sw $t2, ($t0)
	addi $t0, $t0, 4
	addi $s0, $s0, 1
	j ReadLoop
EndReadLoop:
	la $a0, str2
	ori $v0, $0, 4
	syscall
	ori $v0, $0, 5
	syscall
	addu $t3, $0, $v0	
	la $a0, str3
	ori $v0, $0, 4
	syscall
	la 	$t0, array1
	addi $t5, $t5, 0
	addi $s1, $s1, 0
CheckLoop:
	slt $t1, $s1, 10
	bne $t1, 1, EndCheckLoop
	nop
	lw $t2, ($t0)
	bne $t2, $t3, NotEqual
	addu $a0, $0, $s1
	ori $v0, $0, 1
	syscall
	# Print a comma
	la $a0, str4
	ori $v0, $0, 4
	syscall
	addi $t5, $t5, 1
NotEqual:
	addi $t0, $t0, 4
	addi $s1, $s1, 1
	j CheckLoop
EndCheckLoop:
	la $a0, str5
	ori $v0, $0, 4
	syscall
	la $a0, str6
	ori $v0, $0, 4
	syscall
	addu $a0, $0, $t5
	ori $v0, $0, 1
	syscall
Exit:
	ori $v0, $0, 10
	syscall
