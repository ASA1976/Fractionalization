	.file	"proof.cpp"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	""
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align 4
.LC1:
	.string	"numerator/denominator operation numerator/denominator"
	.section	.rodata.str1.1
.LC2:
	.string	"operation: + - * /"
.LC3:
	.string	"example: 1/2 * 2/3"
.LC4:
	.string	"%u / %u %c %u / %u"
.LC5:
	.string	"Unable to parse expression\n"
.LC6:
	.string	"Denominator must not be 0\n"
.LC7:
	.string	"Unknown operation '%c'\n"
.LC8:
	.string	" = "
.LC9:
	.string	"%u"
.LC10:
	.string	"/%u"
	.text
	.globl	main
	.type	main, @function
main:
.LFB37:
	.cfi_startproc
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x70,0x6
	.cfi_escape 0x10,0x7,0x2,0x75,0x7c
	.cfi_escape 0x10,0x6,0x2,0x75,0x78
	.cfi_escape 0x10,0x3,0x2,0x75,0x74
	subl	$68, %esp
	pushl	$.LC0
	call	puts
	movl	$.LC1, (%esp)
	call	puts
	movl	$.LC2, (%esp)
	call	puts
	movl	$.LC3, (%esp)
	call	puts
	movl	$.LC0, (%esp)
	call	puts
	addl	$8, %esp
	leal	-32(%ebp), %eax
	leal	-28(%ebp), %edx
	pushl	%edx
	pushl	%eax
	leal	-41(%ebp), %eax
	pushl	%eax
	leal	-40(%ebp), %eax
	leal	-36(%ebp), %edx
	pushl	%edx
	pushl	%eax
	pushl	$.LC4
	call	scanf
	addl	$32, %esp
	cmpl	$4, %eax
	jle	.L53
	movl	-36(%ebp), %ecx
	testl	%ecx, %ecx
	je	.L4
	movl	-28(%ebp), %eax
	movl	%eax, -60(%ebp)
	testl	%eax, %eax
	je	.L4
	movb	-41(%ebp), %al
	cmpb	$43, %al
	je	.L7
	cmpb	$43, %al
	jle	.L54
	cmpb	$45, %al
	je	.L10
	cmpb	$47, %al
	jne	.L6
	movl	-40(%ebp), %esi
	movl	-32(%ebp), %eax
	movl	%eax, -64(%ebp)
	movl	%esi, %ebx
	cmpl	%eax, %esi
	jbe	.L32
	movl	-64(%ebp), %ebx
	movl	%esi, %eax
	jmp	.L32
.L53:
	pushl	stderr
	pushl	$27
	pushl	$1
	pushl	$.LC5
	call	fwrite
	addl	$16, %esp
	movl	$-1, %eax
	jmp	.L1
.L4:
	pushl	stderr
	pushl	$26
	pushl	$1
	pushl	$.LC6
	call	fwrite
	addl	$16, %esp
	movl	$-2, %eax
	jmp	.L1
.L54:
	cmpb	$42, %al
	jne	.L6
	movl	-40(%ebp), %esi
	movl	-60(%ebp), %eax
	movl	%esi, %ebx
	cmpl	%esi, %eax
	jnb	.L28
	movl	-60(%ebp), %ebx
	movl	%esi, %eax
	jmp	.L28
.L7:
	movl	-60(%ebp), %eax
	movl	%ecx, %ebx
	cmpl	%eax, %ecx
	jbe	.L13
	movl	-60(%ebp), %ebx
	movl	%ecx, %eax
	jmp	.L13
.L37:
	movl	%edx, %ebx
.L13:
	movl	$0, %edx
	divl	%ebx
	movl	%ebx, %eax
	testl	%edx, %edx
	jne	.L37
	movl	-60(%ebp), %esi
	cmpl	%esi, %ecx
	jbe	.L14
	movl	%ecx, %eax
	movl	$0, %edx
	divl	%ebx
	movl	%eax, %ebx
	imull	%esi, %ebx
.L15:
	movl	%ebx, %eax
	movl	$0, %edx
	divl	%ecx
	imull	-40(%ebp), %eax
	movl	%eax, %ecx
	movl	%ebx, %eax
	movl	$0, %edx
	divl	-60(%ebp)
	imull	-32(%ebp), %eax
	movl	%ecx, %esi
	addl	%eax, %esi
	je	.L16
	cmpl	%esi, %ebx
	jb	.L38
	movl	%esi, %ecx
	movl	%ebx, %eax
	jmp	.L18
.L14:
	movl	-60(%ebp), %eax
	movl	$0, %edx
	divl	%ebx
	movl	%eax, %ebx
	imull	%ecx, %ebx
	jmp	.L15
.L38:
	movl	%ebx, %ecx
	movl	%esi, %eax
	jmp	.L18
.L39:
	movl	%ecx, %eax
	movl	%edx, %ecx
.L18:
	movl	$0, %edx
	divl	%ecx
	testl	%edx, %edx
	jne	.L39
	movl	%esi, %eax
	movl	$0, %edx
	divl	%ecx
	movl	%eax, %esi
	movl	%ebx, %eax
	movl	$0, %edx
	divl	%ecx
	movl	%eax, %ebx
	jmp	.L19
.L10:
	movl	-60(%ebp), %eax
	movl	%ecx, %ebx
	cmpl	%eax, %ecx
	jbe	.L21
	movl	-60(%ebp), %ebx
	movl	%ecx, %eax
	jmp	.L21
.L41:
	movl	%edx, %ebx
.L21:
	movl	$0, %edx
	divl	%ebx
	movl	%ebx, %eax
	testl	%edx, %edx
	jne	.L41
	movl	-60(%ebp), %edi
	cmpl	%edi, %ecx
	jbe	.L22
	movl	%ecx, %eax
	movl	$0, %edx
	divl	%ebx
	movl	%eax, %ebx
	imull	%edi, %ebx
.L23:
	movl	%ebx, %eax
	movl	$0, %edx
	divl	%ecx
	movl	%eax, %esi
	imull	-40(%ebp), %esi
	movl	%ebx, %eax
	movl	$0, %edx
	divl	-60(%ebp)
	imull	-32(%ebp), %eax
	subl	%eax, %esi
	je	.L24
	cmpl	%esi, %ebx
	jb	.L42
	movl	%esi, %ecx
	movl	%ebx, %eax
	jmp	.L26
.L22:
	movl	-60(%ebp), %eax
	movl	$0, %edx
	divl	%ebx
	movl	%eax, %ebx
	imull	%ecx, %ebx
	jmp	.L23
.L42:
	movl	%ebx, %ecx
	movl	%esi, %eax
	jmp	.L26
.L43:
	movl	%ecx, %eax
	movl	%edx, %ecx
.L26:
	movl	$0, %edx
	divl	%ecx
	testl	%edx, %edx
	jne	.L43
	movl	%esi, %eax
	movl	$0, %edx
	divl	%ecx
	movl	%eax, %esi
	movl	%ebx, %eax
	movl	$0, %edx
	divl	%ecx
	movl	%eax, %ebx
	jmp	.L19
.L45:
	movl	%edx, %ebx
.L28:
	movl	$0, %edx
	divl	%ebx
	movl	%ebx, %eax
	testl	%edx, %edx
	jne	.L45
	movl	-32(%ebp), %eax
	movl	%eax, -64(%ebp)
	movl	%ecx, %edi
	cmpl	%eax, %ecx
	jbe	.L30
	movl	-64(%ebp), %edi
	movl	%ecx, %eax
	jmp	.L30
.L47:
	movl	%edx, %edi
.L30:
	movl	$0, %edx
	divl	%edi
	movl	%edi, %eax
	testl	%edx, %edx
	jne	.L47
	movl	%esi, %eax
	movl	$0, %edx
	divl	%ebx
	movl	%eax, %esi
	movl	-64(%ebp), %eax
	movl	$0, %edx
	divl	%edi
	imull	%eax, %esi
	movl	%ecx, %eax
	movl	$0, %edx
	divl	%edi
	movl	%eax, %ecx
	movl	-60(%ebp), %eax
	movl	$0, %edx
	divl	%ebx
	imull	%eax, %ecx
	movl	%ecx, %ebx
.L19:
	subl	$12, %esp
	pushl	$.LC8
	call	printf
	addl	$8, %esp
	pushl	%esi
	pushl	$.LC9
	call	printf
	addl	$16, %esp
	cmpl	$1, %ebx
	je	.L35
	subl	$8, %esp
	pushl	%ebx
	pushl	$.LC10
	call	printf
	addl	$16, %esp
.L35:
	subl	$12, %esp
	pushl	$.LC0
	call	puts
	addl	$16, %esp
	movl	$0, %eax
.L1:
	leal	-16(%ebp), %esp
	popl	%ecx
	.cfi_remember_state
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
.L49:
	.cfi_restore_state
	movl	%edx, %ebx
.L32:
	movl	$0, %edx
	divl	%ebx
	movl	%ebx, %eax
	testl	%edx, %edx
	jne	.L49
	movl	-60(%ebp), %eax
	movl	%ecx, %edi
	cmpl	%eax, %ecx
	jbe	.L34
	movl	-60(%ebp), %edi
	movl	%ecx, %eax
	jmp	.L34
.L51:
	movl	%edx, %edi
.L34:
	movl	$0, %edx
	divl	%edi
	movl	%edi, %eax
	testl	%edx, %edx
	jne	.L51
	movl	%esi, %eax
	movl	$0, %edx
	divl	%ebx
	movl	%eax, %esi
	movl	-60(%ebp), %eax
	movl	$0, %edx
	divl	%edi
	imull	%eax, %esi
	movl	%ecx, %eax
	movl	$0, %edx
	divl	%edi
	movl	%eax, %ecx
	movl	-64(%ebp), %eax
	movl	$0, %edx
	divl	%ebx
	imull	%eax, %ecx
	movl	%ecx, %ebx
	jmp	.L19
.L6:
	subl	$4, %esp
	movsbl	%al, %eax
	pushl	%eax
	pushl	$.LC7
	pushl	stderr
	call	fprintf
	addl	$16, %esp
	movl	$-3, %eax
	jmp	.L1
.L16:
	subl	$12, %esp
	pushl	$.LC8
	call	printf
	addl	$8, %esp
	pushl	$0
	pushl	$.LC9
	call	printf
	addl	$16, %esp
	jmp	.L35
.L24:
	subl	$12, %esp
	pushl	$.LC8
	call	printf
	addl	$8, %esp
	pushl	$0
	pushl	$.LC9
	call	printf
	addl	$16, %esp
	jmp	.L35
	.cfi_endproc
.LFE37:
	.size	main, .-main
	.ident	"GCC: (GNU) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
