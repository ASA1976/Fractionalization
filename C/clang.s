	.text
	.file	"proof.c"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushl	%ebp
	pushl	%ebx
	pushl	%edi
	pushl	%esi
	subl	$40, %esp
	pushl	$10
	calll	putchar
	addl	$4, %esp
	pushl	$.L.str.1
	calll	puts
	addl	$4, %esp
	pushl	$.L.str.2
	calll	puts
	addl	$4, %esp
	pushl	$.L.str.3
	calll	puts
	addl	$4, %esp
	pushl	$10
	calll	putchar
	addl	$16, %esp
	leal	20(%esp), %eax
	leal	12(%esp), %ecx
	subl	$8, %esp
	leal	16(%esp), %edx
	leal	11(%esp), %esi
	leal	24(%esp), %edi
	pushl	%ecx
	pushl	%edx
	pushl	%esi
	pushl	%eax
	pushl	%edi
	pushl	$.L.str.4
	calll	__isoc99_scanf
	addl	$32, %esp
	cmpl	$4, %eax
	jle	.LBB0_33
# %bb.1:
	movl	20(%esp), %esi
	testl	%esi, %esi
	je	.LBB0_34
# %bb.2:
	movl	12(%esp), %ecx
	testl	%ecx, %ecx
	je	.LBB0_34
# %bb.3:
	movsbl	3(%esp), %eax
	leal	-42(%eax), %edx
	cmpl	$5, %edx
	ja	.LBB0_35
# %bb.4:
	jmpl	*.LJTI0_0(,%edx,4)
.LBB0_5:
	movl	16(%esp), %eax
	movl	%ecx, %ebp
	cmpl	%ecx, %eax
	movl	%eax, %edx
	movl	%eax, 4(%esp)           # 4-byte Spill
	cmoval	%ecx, %edx
	cmoval	%eax, %ebp
	.p2align	4, 0x90
.LBB0_6:                                # =>This Inner Loop Header: Depth=1
	movl	%ebp, %eax
	movl	%edx, %ebp
	xorl	%edx, %edx
	divl	%ebp
	testl	%edx, %edx
	jne	.LBB0_6
# %bb.7:
	movl	8(%esp), %edi
	movl	%esi, %edx
	cmpl	%edi, %esi
	movl	%edi, %ebx
	cmoval	%edi, %edx
	cmoval	%esi, %ebx
	.p2align	4, 0x90
.LBB0_8:                                # =>This Inner Loop Header: Depth=1
	movl	%ebx, %eax
	movl	%edx, %ebx
	xorl	%edx, %edx
	divl	%ebx
	testl	%edx, %edx
	jne	.LBB0_8
# %bb.9:
	movl	4(%esp), %eax           # 4-byte Reload
	xorl	%edx, %edx
	divl	%ebp
	movl	%eax, 4(%esp)           # 4-byte Spill
	xorl	%edx, %edx
	movl	%edi, %eax
	divl	%ebx
	movl	%eax, %edi
	xorl	%edx, %edx
	movl	%esi, %eax
	imull	4(%esp), %edi           # 4-byte Folded Reload
	divl	%ebx
	movl	%eax, %ebx
	xorl	%edx, %edx
	movl	%ecx, %eax
	divl	%ebp
	movl	%eax, %esi
	imull	%ebx, %esi
	jmp	.LBB0_29
.LBB0_10:
	cmpl	%ecx, %esi
	movl	%esi, %edx
	movl	%ecx, %ebx
	cmoval	%ecx, %edx
	cmoval	%esi, %ebx
	.p2align	4, 0x90
.LBB0_11:                               # =>This Inner Loop Header: Depth=1
	movl	%ebx, %eax
	movl	%edx, %ebx
	xorl	%edx, %edx
	divl	%ebx
	testl	%edx, %edx
	jne	.LBB0_11
# %bb.12:
	cmpl	%ecx, %esi
	movl	%ecx, %eax
	movl	%esi, %ebp
	cmoval	%esi, %eax
	cmoval	%ecx, %ebp
	xorl	%edx, %edx
	xorl	%edi, %edi
	divl	%ebx
	movl	%eax, %ebx
	xorl	%edx, %edx
	imull	%ebp, %ebx
	movl	%ebx, %eax
	divl	%esi
	movl	%eax, %esi
	xorl	%edx, %edx
	movl	%ebx, %eax
	imull	16(%esp), %esi
	divl	%ecx
	movl	%eax, %ecx
	imull	8(%esp), %ecx
	addl	%esi, %ecx
	je	.LBB0_28
# %bb.13:
	cmpl	%ebx, %ecx
	movl	%ecx, %edx
	movl	%ebx, %esi
	cmoval	%ebx, %edx
	cmoval	%ecx, %esi
	.p2align	4, 0x90
.LBB0_14:                               # =>This Inner Loop Header: Depth=1
	movl	%esi, %eax
	movl	%edx, %esi
	xorl	%edx, %edx
	divl	%esi
	testl	%edx, %edx
	jne	.LBB0_14
# %bb.15:
	xorl	%edx, %edx
	movl	%ecx, %eax
	divl	%esi
	movl	%eax, %edi
	xorl	%edx, %edx
	movl	%ebx, %eax
	divl	%esi
	movl	%eax, %esi
	jmp	.LBB0_29
.LBB0_16:
	cmpl	%ecx, %esi
	movl	%esi, %edx
	movl	%ecx, %ebx
	cmoval	%ecx, %edx
	cmoval	%esi, %ebx
	.p2align	4, 0x90
.LBB0_17:                               # =>This Inner Loop Header: Depth=1
	movl	%ebx, %eax
	movl	%edx, %ebx
	xorl	%edx, %edx
	divl	%ebx
	testl	%edx, %edx
	jne	.LBB0_17
# %bb.18:
	cmpl	%ecx, %esi
	movl	%ecx, %eax
	movl	%esi, %ebp
	cmoval	%esi, %eax
	cmoval	%ecx, %ebp
	xorl	%edx, %edx
	xorl	%edi, %edi
	divl	%ebx
	movl	%eax, %ebx
	xorl	%edx, %edx
	imull	%ebp, %ebx
	movl	%ebx, %eax
	divl	%esi
	movl	%eax, %esi
	xorl	%edx, %edx
	movl	%ebx, %eax
	imull	16(%esp), %esi
	divl	%ecx
	imull	8(%esp), %eax
	subl	%eax, %esi
	je	.LBB0_28
# %bb.19:
	cmpl	%ebx, %esi
	movl	%esi, %edx
	movl	%ebx, %ecx
	cmoval	%ebx, %edx
	cmoval	%esi, %ecx
	.p2align	4, 0x90
.LBB0_20:                               # =>This Inner Loop Header: Depth=1
	movl	%ecx, %eax
	movl	%edx, %ecx
	xorl	%edx, %edx
	divl	%ecx
	testl	%edx, %edx
	jne	.LBB0_20
# %bb.21:
	xorl	%edx, %edx
	movl	%esi, %eax
	divl	%ecx
	movl	%eax, %edi
	xorl	%edx, %edx
	movl	%ebx, %eax
	divl	%ecx
	movl	%eax, %esi
	jmp	.LBB0_29
.LBB0_22:
	movl	16(%esp), %edi
	movl	8(%esp), %ebx
	cmpl	%ebx, %edi
	movl	%edi, %edx
	movl	%ebx, 4(%esp)           # 4-byte Spill
	cmoval	%ebx, %edx
	cmoval	%edi, %ebx
	.p2align	4, 0x90
.LBB0_23:                               # =>This Inner Loop Header: Depth=1
	movl	%ebx, %eax
	movl	%edx, %ebx
	xorl	%edx, %edx
	divl	%ebx
	testl	%edx, %edx
	jne	.LBB0_23
# %bb.24:
	cmpl	%ecx, %esi
	movl	%esi, %edx
	movl	%ecx, %ebp
	cmoval	%ecx, %edx
	cmoval	%esi, %ebp
	.p2align	4, 0x90
.LBB0_25:                               # =>This Inner Loop Header: Depth=1
	movl	%ebp, %eax
	movl	%edx, %ebp
	xorl	%edx, %edx
	divl	%ebp
	testl	%edx, %edx
	jne	.LBB0_25
# %bb.26:
	xorl	%edx, %edx
	movl	%edi, %eax
	divl	%ebx
	movl	%eax, 24(%esp)          # 4-byte Spill
	xorl	%edx, %edx
	movl	%ecx, %eax
	divl	%ebp
	movl	%eax, %edi
	xorl	%edx, %edx
	movl	%esi, %eax
	imull	24(%esp), %edi          # 4-byte Folded Reload
	divl	%ebp
	movl	%eax, %ecx
	movl	4(%esp), %eax           # 4-byte Reload
	xorl	%edx, %edx
	divl	%ebx
	movl	%eax, %esi
	imull	%ecx, %esi
	jmp	.LBB0_29
.LBB0_28:
	movl	$1, %esi
.LBB0_29:
	subl	$12, %esp
	pushl	$.L.str.8
	calll	printf
	addl	$8, %esp
	pushl	%edi
	pushl	$.L.str.9
	calll	printf
	addl	$16, %esp
	cmpl	$1, %esi
	je	.LBB0_31
# %bb.30:
	subl	$8, %esp
	pushl	%esi
	pushl	$.L.str.10
	calll	printf
	addl	$16, %esp
.LBB0_31:
	subl	$12, %esp
	pushl	$10
	calll	putchar
	addl	$16, %esp
	xorl	%eax, %eax
.LBB0_32:
	addl	$28, %esp
	popl	%esi
	popl	%edi
	popl	%ebx
	popl	%ebp
	retl
.LBB0_33:
	pushl	stderr
	pushl	$1
	pushl	$27
	pushl	$.L.str.5
	calll	fwrite
	addl	$16, %esp
	movl	$-1, %eax
	jmp	.LBB0_32
.LBB0_34:
	pushl	stderr
	pushl	$1
	pushl	$26
	pushl	$.L.str.6
	calll	fwrite
	addl	$16, %esp
	movl	$-2, %eax
	jmp	.LBB0_32
.LBB0_35:
	subl	$4, %esp
	pushl	%eax
	pushl	$.L.str.7
	pushl	stderr
	calll	fprintf
	addl	$16, %esp
	movl	$-3, %eax
	jmp	.LBB0_32
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.section	.rodata,"a",@progbits
	.p2align	2
.LJTI0_0:
	.long	.LBB0_5
	.long	.LBB0_10
	.long	.LBB0_35
	.long	.LBB0_16
	.long	.LBB0_35
	.long	.LBB0_22
                                        # -- End function
	.type	.L.str.1,@object        # @.str.1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1:
	.asciz	"numerator/denominator operation numerator/denominator"
	.size	.L.str.1, 54

	.type	.L.str.2,@object        # @.str.2
.L.str.2:
	.asciz	"operation: + - * /"
	.size	.L.str.2, 19

	.type	.L.str.3,@object        # @.str.3
.L.str.3:
	.asciz	"example: 1/2 * 2/3"
	.size	.L.str.3, 19

	.type	.L.str.4,@object        # @.str.4
.L.str.4:
	.asciz	"%u / %u %c %u / %u"
	.size	.L.str.4, 19

	.type	.L.str.5,@object        # @.str.5
.L.str.5:
	.asciz	"Unable to parse expression\n"
	.size	.L.str.5, 28

	.type	.L.str.6,@object        # @.str.6
.L.str.6:
	.asciz	"Denominator must not be 0\n"
	.size	.L.str.6, 27

	.type	.L.str.7,@object        # @.str.7
.L.str.7:
	.asciz	"Unknown operation '%c'\n"
	.size	.L.str.7, 24

	.type	.L.str.8,@object        # @.str.8
.L.str.8:
	.asciz	" = "
	.size	.L.str.8, 4

	.type	.L.str.9,@object        # @.str.9
.L.str.9:
	.asciz	"%u"
	.size	.L.str.9, 3

	.type	.L.str.10,@object       # @.str.10
.L.str.10:
	.asciz	"/%u"
	.size	.L.str.10, 4


	.ident	"clang version 6.0.1 (tags/RELEASE_601/final)"
	.section	".note.GNU-stack","",@progbits
