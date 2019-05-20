/* 
   Names: Theo Lee & Chris Andersen		 
   Date : 5/19/19
*/

	.global SpigotE

	.text

SpigotE:
	movb $2, (%rdi) 	# Move 2 into first index of output array
	movq %rdx, %r8		# Copy 'n' and move it to a scratch register
	mov %r8, %r13		# Set i = n
	incq %r13			# ++i
	cmp $0, %r13		# Compare i with 0
	jl end_loop_1		# If i is less than 0 go to done
loop_1:
	movl $1, (%rsi, %r13, 8)	# Set each index in the workbuffer array to 1
	dec %r13			# Decrement i
	cmp $0, %r13		# Compare i with 0
	jge loop_1			# If i is still greater than 0 than repeat loop
end_loop_1:
	nop
	movq $1, %r9		# Copy 1 into j
	cmp %r8, %r9		# Compare j & n
	jge end_loop_2		# If j is greater than n
loop_2:
	xorq %r10, %r10		# Assign 0 to q 	
	mov %r8, %r13		# Reset i to n
	incq %r13			# ++i
	cmp $0, %r13		# Compare i and 0
	jl end_loop_3		# If i is less than 0 than end the loop
loop_3:
	movq $10, %r11		# Move 10 into temp
	imul (%rsi, %r13, 8), %r11 	# Multiply temp by the work buffer index
	addq %r10, %r11		# Add q to temp
	movq %r13, %r12		# Copy i into scratch register
	addq $2, %r12			# Add 2 
	movq  %r11, %rax		# Move temp to make it the dividend
	movq  %r12, %rcx		# Move (i + 2) to make it the divisor
	movq $0, %rdx			# Zero out the top half of the dividend
	div %rcx				# Divide
	movq %rax, %r10 		# Move quotient to q
	movq %rdx, (%rsi, %r13, 8)	# Move modulus into workbuffer array
	decq %r13			# --i
	cmp	$0, %r13		# Compare i with 0
	jge loop_3			# If i is still greater than 0 than repeat loop
end_loop_3:
	nop
	movq  %r10, (%rdi, %r9, 1)		# Move 'q' into the j index of output array
	incq %r9			# j++
	cmp %r8, %r9		# Compare j with n
	jl loop_2			# If j is less than 'n' than repeat loop
end_loop_2:
	nop
done_2:
	ret
