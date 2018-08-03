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
	jle	.L57
	movl	-36(%ebp), %ecx
	testl	%ecx, %ecx
	je	.L4
	movl	-28(%ebp), %ebx
	testl	%ebx, %ebx
	je	.L4
	movb	-41(%ebp), %al
	cmpb	$43, %al
	je	.L6
	jle	.L58
	cmpb	$45, %al
	je	.L10
	cmpb	$47, %al
	jne	.L9
	movl	-40(%ebp), %esi
	movl	-32(%ebp), %eax
	movl	%eax, -64(%ebp)
	movl	%esi, %edi
	cmpl	%eax, %esi
	jbe	.L34
	movl	-64(%ebp), %edi
	movl	%esi, %eax
	jmp	.L34
.L57:
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
.L58:
	cmpb	$42, %al
	jne	.L9
	movl	-40(%ebp), %esi
	movl	$1, -60(%ebp)
	testl	%esi, %esi
	je	.L27
	cmpl	%esi, %ebx
	jb	.L47
	movl	%esi, %edi
	movl	%ebx, %eax
	jmp	.L29
.L6:
	cmpl	%ebx, %ecx
	ja	.L38
	movl	%ecx, %esi
	movl	%ebx, %eax
	jmp	.L13
.L38:
	movl	%ebx, %esi
	movl	%ecx, %eax
	jmp	.L13
.L39:
	movl	%edx, %esi
.L13:
	movl	$0, %edx
	divl	%esi
	movl	%esi, %eax
	testl	%edx, %edx
	jne	.L39
	cmpl	%ebx, %ecx
	ja	.L59
	movl	%ebx, %eax
	movl	$0, %edx
	divl	%esi
	imull	%ecx, %eax
	movl	%eax, %edi
.L15:
	movl	%edi, %eax
	movl	$0, %edx
	divl	%ecx
	imull	-40(%ebp), %eax
	movl	%eax, %ecx
	movl	%edi, %eax
	movl	$0, %edx
	divl	%ebx
	imull	-32(%ebp), %eax
	addl	%eax, %ecx
	movl	%ecx, %esi
	je	.L16
	movl	%edi, %eax
	cmpl	%ecx, %edi
	jnb	.L18
	movl	%edi, %ecx
	movl	%esi, %eax
	jmp	.L18
.L59:
	movl	%ecx, %eax
	movl	$0, %edx
	divl	%esi
	imull	%ebx, %eax
	movl	%eax, %edi
	jmp	.L15
.L41:
	movl	%edx, %ecx
.L18:
	movl	$0, %edx
	divl	%ecx
	movl	%ecx, %eax
	testl	%edx, %edx
	jne	.L41
	movl	%esi, %eax
	movl	$0, %edx
	divl	%ecx
	movl	%eax, %esi
	movl	%edi, %eax
	movl	$0, %edx
	divl	%ecx
	movl	%eax, %edi
	jmp	.L19
.L10:
	cmpl	%ebx, %ecx
	ja	.L42
	movl	%ecx, %esi
	movl	%ebx, %eax
	jmp	.L21
.L42:
	movl	%ebx, %esi
	movl	%ecx, %eax
	jmp	.L21
.L43:
	movl	%edx, %esi
.L21:
	movl	$0, %edx
	divl	%esi
	movl	%esi, %eax
	testl	%edx, %edx
	jne	.L43
	cmpl	%ebx, %ecx
	ja	.L60
	movl	%ebx, %eax
	movl	$0, %edx
	divl	%esi
	imull	%ecx, %eax
	movl	%eax, %edi
.L23:
	movl	%edi, %eax
	movl	$0, %edx
	divl	%ecx
	movl	%eax, %esi
	imull	-40(%ebp), %esi
	movl	%edi, %eax
	movl	$0, %edx
	divl	%ebx
	imull	-32(%ebp), %eax
	subl	%eax, %esi
	je	.L24
	cmpl	%esi, %edi
	jb	.L44
	movl	%esi, %ecx
	movl	%edi, %eax
	jmp	.L26
.L60:
	movl	%ecx, %eax
	movl	$0, %edx
	divl	%esi
	imull	%ebx, %eax
	movl	%eax, %edi
	jmp	.L23
.L44:
	movl	%edi, %ecx
	movl	%esi, %eax
	jmp	.L26
.L45:
	movl	%edx, %ecx
.L26:
	movl	$0, %edx
	divl	%ecx
	movl	%ecx, %eax
	testl	%edx, %edx
	jne	.L45
	movl	%esi, %eax
	movl	$0, %edx
	divl	%ecx
	movl	%eax, %esi
	movl	%edi, %eax
	movl	$0, %edx
	divl	%ecx
	movl	%eax, %edi
	jmp	.L19
.L47:
	movl	%ebx, %edi
	movl	%esi, %eax
	jmp	.L29
.L48:
	movl	%edx, %edi
.L29:
	movl	$0, %edx
	divl	%edi
	movl	%edi, %eax
	testl	%edx, %edx
	jne	.L48
	movl	%edi, -60(%ebp)
.L27:
	movl	-32(%ebp), %eax
	movl	%eax, -64(%ebp)
	movl	$1, %edi
	testl	%eax, %eax
	je	.L30
	movl	%ecx, %edi
	cmpl	%eax, %ecx
	jbe	.L32
	movl	-64(%ebp), %edi
	movl	%ecx, %eax
	jmp	.L32
.L51:
	movl	%edx, %edi
.L32:
	movl	$0, %edx
	divl	%edi
	movl	%edi, %eax
	testl	%edx, %edx
	jne	.L51
.L30:
	movl	%esi, %eax
	movl	$0, %edx
	divl	-60(%ebp)
	movl	%eax, %esi
	movl	-64(%ebp), %eax
	movl	$0, %edx
	divl	%edi
	imull	%eax, %esi
	movl	%ecx, %eax
	movl	$0, %edx
	divl	%edi
	movl	%eax, %ecx
	movl	%ebx, %eax
	movl	$0, %edx
	divl	-60(%ebp)
	movl	%eax, %edi
	imull	%ecx, %edi
.L19:
	subl	$12, %esp
	pushl	$.LC8
	call	printf
	addl	$8, %esp
	pushl	%esi
	pushl	$.LC9
	call	printf
	addl	$16, %esp
	cmpl	$1, %edi
	je	.L37
	subl	$8, %esp
	pushl	%edi
	pushl	$.LC10
	call	printf
	addl	$16, %esp
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
.L53:
	.cfi_restore_state
	movl	%edx, %edi
.L34:
	movl	$0, %edx
	divl	%edi
	movl	%edi, %eax
	testl	%edx, %edx
	jne	.L53
	movl	%edi, -60(%ebp)
	cmpl	%ebx, %ecx
	ja	.L54
	movl	%ecx, %edi
	movl	%ebx, %eax
	jmp	.L36
.L54:
	movl	%ebx, %edi
	movl	%ecx, %eax
	jmp	.L36
.L55:
	movl	%edx, %edi
.L36:
	movl	$0, %edx
	divl	%edi
	movl	%edi, %eax
	testl	%edx, %edx
	jne	.L55
	movl	%esi, %eax
	movl	$0, %edx
	divl	-60(%ebp)
	movl	%eax, %esi
	movl	%ebx, %eax
	movl	$0, %edx
	divl	%edi
	imull	%eax, %esi
	movl	%ecx, %eax
	movl	$0, %edx
	divl	%edi
	movl	%eax, %ecx
	movl	-64(%ebp), %eax
	movl	$0, %edx
	divl	-60(%ebp)
	movl	%eax, %edi
	imull	%ecx, %edi
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
.L16:
	subl	$12, %esp
	pushl	$.LC8
	call	printf
	addl	$8, %esp
	pushl	$0
	pushl	$.LC9
	call	printf
	addl	$16, %esp
	jmp	.L37
.L24:
	subl	$12, %esp
	pushl	$.LC8
	call	printf
	addl	$8, %esp
	pushl	$0
	pushl	$.LC9
	call	printf
	addl	$16, %esp
	jmp	.L37
	.cfi_endproc
.LFE37:
	.size	main, .-main
	.ident	"GCC: (GNU) 8.1.1 20180626"
	.section	.note.GNU-stack,"",@progbits
