	.file	"proof.c"
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
.LFB36:
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
	call	__isoc99_scanf
	addl	$32, %esp
	cmpl	$4, %eax
	jle	.L59
	movl	-36(%ebp), %edi
	testl	%edi, %edi
	je	.L4
	movl	-28(%ebp), %esi
	testl	%esi, %esi
	je	.L4
	movb	-41(%ebp), %al
	cmpb	$43, %al
	je	.L6
	jle	.L60
	cmpb	$45, %al
	je	.L10
	cmpb	$47, %al
	jne	.L9
	movl	-32(%ebp), %eax
	movl	%eax, -64(%ebp)
	movl	-40(%ebp), %ebx
	movl	%ebx, %ecx
	cmpl	%ebx, %eax
	jnb	.L34
	movl	-64(%ebp), %ecx
	movl	%ebx, %eax
	jmp	.L34
.L59:
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
.L60:
	cmpb	$42, %al
	jne	.L9
	movl	-40(%ebp), %ebx
	movl	$1, -60(%ebp)
	testl	%ebx, %ebx
	jne	.L61
.L27:
	movl	-32(%ebp), %eax
	movl	%eax, -64(%ebp)
	movl	$1, %ecx
	testl	%eax, %eax
	jne	.L62
.L30:
	movl	%ebx, %eax
	movl	$0, %edx
	divl	-60(%ebp)
	movl	%eax, %ebx
	movl	-64(%ebp), %eax
	movl	$0, %edx
	divl	%ecx
	imull	%eax, %ebx
	movl	%edi, %eax
	movl	$0, %edx
	divl	%ecx
	movl	%eax, %edi
	movl	%esi, %eax
	movl	$0, %edx
	divl	-60(%ebp)
	movl	%eax, %esi
	imull	%edi, %esi
.L19:
	subl	$12, %esp
	pushl	$.LC8
	call	printf
	addl	$8, %esp
	pushl	%ebx
	pushl	$.LC9
	call	printf
	addl	$16, %esp
	cmpl	$1, %esi
	jne	.L63
.L37:
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
.L6:
	.cfi_restore_state
	cmpl	%esi, %edi
	ja	.L38
	movl	%edi, %ecx
	movl	%esi, %eax
	jmp	.L13
.L38:
	movl	%esi, %ecx
	movl	%edi, %eax
	jmp	.L13
.L39:
	movl	%edx, %ecx
.L13:
	movl	$0, %edx
	divl	%ecx
	movl	%edx, %ebx
	movl	%ecx, %eax
	testl	%edx, %edx
	jne	.L39
	cmpl	%esi, %edi
	ja	.L64
	movl	%esi, %eax
	movl	$0, %edx
	divl	%ecx
	imull	%edi, %eax
	movl	%eax, %ecx
.L15:
	movl	%ecx, %eax
	movl	$0, %edx
	divl	%edi
	imull	-40(%ebp), %eax
	movl	%eax, %edi
	movl	%ecx, %eax
	movl	$0, %edx
	divl	%esi
	imull	-32(%ebp), %eax
	movl	$1, %esi
	addl	%eax, %edi
	je	.L19
	cmpl	%ecx, %edi
	ja	.L41
	movl	%edi, %esi
	movl	%ecx, %eax
	jmp	.L18
.L64:
	movl	%edi, %eax
	movl	$0, %edx
	divl	%ecx
	imull	%esi, %eax
	movl	%eax, %ecx
	jmp	.L15
.L41:
	movl	%ecx, %esi
	movl	%edi, %eax
	jmp	.L18
.L42:
	movl	%edx, %esi
.L18:
	movl	$0, %edx
	divl	%esi
	movl	%esi, %eax
	testl	%edx, %edx
	jne	.L42
	movl	%edi, %eax
	movl	$0, %edx
	divl	%esi
	movl	%eax, %ebx
	movl	%ecx, %eax
	movl	$0, %edx
	divl	%esi
	movl	%eax, %esi
	jmp	.L19
.L10:
	cmpl	%esi, %edi
	ja	.L43
	movl	%edi, %ecx
	movl	%esi, %eax
	jmp	.L21
.L43:
	movl	%esi, %ecx
	movl	%edi, %eax
	jmp	.L21
.L44:
	movl	%edx, %ecx
.L21:
	movl	$0, %edx
	divl	%ecx
	movl	%edx, %ebx
	movl	%ecx, %eax
	testl	%edx, %edx
	jne	.L44
	cmpl	%esi, %edi
	ja	.L65
	movl	%esi, %eax
	movl	$0, %edx
	divl	%ecx
	imull	%edi, %eax
	movl	%eax, %ecx
.L23:
	movl	%ecx, %eax
	movl	$0, %edx
	divl	%edi
	imull	-40(%ebp), %eax
	movl	%eax, %edi
	movl	%ecx, %eax
	movl	$0, %edx
	divl	%esi
	imull	-32(%ebp), %eax
	movl	$1, %esi
	subl	%eax, %edi
	je	.L19
	cmpl	%ecx, %edi
	ja	.L46
	movl	%edi, %esi
	movl	%ecx, %eax
	jmp	.L26
.L65:
	movl	%edi, %eax
	movl	$0, %edx
	divl	%ecx
	imull	%esi, %eax
	movl	%eax, %ecx
	jmp	.L23
.L46:
	movl	%ecx, %esi
	movl	%edi, %eax
	jmp	.L26
.L47:
	movl	%edx, %esi
.L26:
	movl	$0, %edx
	divl	%esi
	movl	%esi, %eax
	testl	%edx, %edx
	jne	.L47
	movl	%edi, %eax
	movl	$0, %edx
	divl	%esi
	movl	%eax, %ebx
	movl	%ecx, %eax
	movl	$0, %edx
	divl	%esi
	movl	%eax, %esi
	jmp	.L19
.L61:
	cmpl	%ebx, %esi
	jb	.L49
	movl	%ebx, %ecx
	movl	%esi, %eax
	jmp	.L29
.L49:
	movl	%esi, %ecx
	movl	%ebx, %eax
	jmp	.L29
.L50:
	movl	%edx, %ecx
.L29:
	movl	$0, %edx
	divl	%ecx
	movl	%ecx, %eax
	testl	%edx, %edx
	jne	.L50
	movl	%ecx, -60(%ebp)
	jmp	.L27
.L62:
	movl	%edi, %ecx
	cmpl	%eax, %edi
	jbe	.L32
	movl	-64(%ebp), %ecx
	movl	%edi, %eax
	jmp	.L32
.L53:
	movl	%edx, %ecx
.L32:
	movl	$0, %edx
	divl	%ecx
	movl	%ecx, %eax
	testl	%edx, %edx
	jne	.L53
	jmp	.L30
.L55:
	movl	%edx, %ecx
.L34:
	movl	$0, %edx
	divl	%ecx
	movl	%ecx, %eax
	testl	%edx, %edx
	jne	.L55
	movl	%ecx, -60(%ebp)
	cmpl	%esi, %edi
	ja	.L56
	movl	%edi, %ecx
	movl	%esi, %eax
	jmp	.L36
.L56:
	movl	%esi, %ecx
	movl	%edi, %eax
	jmp	.L36
.L57:
	movl	%edx, %ecx
.L36:
	movl	$0, %edx
	divl	%ecx
	movl	%ecx, %eax
	testl	%edx, %edx
	jne	.L57
	movl	%ebx, %eax
	movl	$0, %edx
	divl	-60(%ebp)
	movl	%eax, %ebx
	movl	%esi, %eax
	movl	$0, %edx
	divl	%ecx
	imull	%eax, %ebx
	movl	%edi, %eax
	movl	$0, %edx
	divl	%ecx
	movl	%eax, %esi
	movl	-64(%ebp), %eax
	movl	$0, %edx
	divl	-60(%ebp)
	imull	%eax, %esi
	jmp	.L19
.L9:
	subl	$4, %esp
	movsbl	%al, %eax
	pushl	%eax
	pushl	$.LC7
	pushl	stderr
	call	fprintf
	addl	$16, %esp
	movl	$-3, %eax
	jmp	.L1
.L63:
	subl	$8, %esp
	pushl	%esi
	pushl	$.LC10
	call	printf
	addl	$16, %esp
	jmp	.L37
	.cfi_endproc
.LFE36:
	.size	main, .-main
	.ident	"GCC: (GNU) 8.1.1 20180626"
	.section	.note.GNU-stack,"",@progbits
