	.arch armv8-a
	.file	"decomment.c"
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"Error: line %i: unterminated comment\n"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB0:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	mov	w0, 1
	str	w0, [sp, 28]
	mov	w0, 1
	str	w0, [sp, 24]
	str	wzr, [sp, 20]
	b	.L2
.L13:
	ldr	w0, [sp, 16]
	cmp	w0, 10
	bne	.L3
	ldr	w0, [sp, 28]
	add	w0, w0, 1
	str	w0, [sp, 28]
.L3:
	ldr	w0, [sp, 20]
	cmp	w0, 2
	beq	.L4
	ldr	w0, [sp, 20]
	cmp	w0, 3
	beq	.L4
	ldr	w0, [sp, 28]
	str	w0, [sp, 24]
.L4:
	ldr	w0, [sp, 20]
	cmp	w0, 7
	beq	.L5
	ldr	w0, [sp, 20]
	cmp	w0, 7
	bhi	.L2
	ldr	w0, [sp, 20]
	cmp	w0, 6
	beq	.L6
	ldr	w0, [sp, 20]
	cmp	w0, 6
	bhi	.L2
	ldr	w0, [sp, 20]
	cmp	w0, 5
	beq	.L7
	ldr	w0, [sp, 20]
	cmp	w0, 5
	bhi	.L2
	ldr	w0, [sp, 20]
	cmp	w0, 4
	beq	.L8
	ldr	w0, [sp, 20]
	cmp	w0, 4
	bhi	.L2
	ldr	w0, [sp, 20]
	cmp	w0, 3
	beq	.L9
	ldr	w0, [sp, 20]
	cmp	w0, 3
	bhi	.L2
	ldr	w0, [sp, 20]
	cmp	w0, 2
	beq	.L10
	ldr	w0, [sp, 20]
	cmp	w0, 2
	bhi	.L2
	ldr	w0, [sp, 20]
	cmp	w0, 0
	beq	.L11
	ldr	w0, [sp, 20]
	cmp	w0, 1
	beq	.L12
	b	.L2
.L11:
	ldr	w0, [sp, 16]
	bl	handleNormal
	str	w0, [sp, 20]
	b	.L2
.L12:
	ldr	w0, [sp, 16]
	bl	handleAfterSlash
	str	w0, [sp, 20]
	b	.L2
.L10:
	ldr	w0, [sp, 16]
	bl	handleInComment
	str	w0, [sp, 20]
	b	.L2
.L9:
	ldr	w0, [sp, 16]
	bl	handleAfterStar
	str	w0, [sp, 20]
	b	.L2
.L8:
	ldr	w0, [sp, 16]
	bl	handleInString
	str	w0, [sp, 20]
	b	.L2
.L6:
	ldr	w0, [sp, 16]
	bl	handleBackslashString
	str	w0, [sp, 20]
	b	.L2
.L7:
	ldr	w0, [sp, 16]
	bl	handleInChar
	str	w0, [sp, 20]
	b	.L2
.L5:
	ldr	w0, [sp, 16]
	bl	handleBackslashChar
	str	w0, [sp, 20]
	nop
.L2:
	bl	getchar
	str	w0, [sp, 16]
	ldr	w0, [sp, 16]
	cmn	w0, #1
	bne	.L13
	ldr	w0, [sp, 20]
	cmp	w0, 1
	bne	.L14
	mov	w0, 47
	bl	putchar
.L14:
	ldr	w0, [sp, 20]
	cmp	w0, 2
	beq	.L15
	ldr	w0, [sp, 20]
	cmp	w0, 3
	bne	.L16
.L15:
	adrp	x0, stderr
	add	x0, x0, :lo12:stderr
	ldr	x3, [x0]
	ldr	w2, [sp, 24]
	adrp	x0, .LC0
	add	x1, x0, :lo12:.LC0
	mov	x0, x3
	bl	fprintf
	mov	w0, 1
	b	.L17
.L16:
	mov	w0, 0
.L17:
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.align	2
	.global	handleNormal
	.type	handleNormal, %function
handleNormal:
.LFB1:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	w0, [sp, 28]
	ldr	w0, [sp, 28]
	cmp	w0, 47
	bne	.L19
	mov	w0, 1
	str	w0, [sp, 44]
	b	.L20
.L19:
	ldr	w0, [sp, 28]
	cmp	w0, 34
	bne	.L21
	mov	w0, 4
	str	w0, [sp, 44]
	ldr	w0, [sp, 28]
	bl	putchar
	b	.L20
.L21:
	ldr	w0, [sp, 28]
	cmp	w0, 39
	bne	.L22
	mov	w0, 5
	str	w0, [sp, 44]
	ldr	w0, [sp, 28]
	bl	putchar
	b	.L20
.L22:
	str	wzr, [sp, 44]
	ldr	w0, [sp, 28]
	bl	putchar
.L20:
	ldr	w0, [sp, 44]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE1:
	.size	handleNormal, .-handleNormal
	.align	2
	.global	handleAfterSlash
	.type	handleAfterSlash, %function
handleAfterSlash:
.LFB2:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	w0, [sp, 28]
	ldr	w0, [sp, 28]
	cmp	w0, 42
	bne	.L25
	mov	w0, 2
	str	w0, [sp, 44]
	mov	w0, 32
	bl	putchar
	b	.L26
.L25:
	mov	w0, 47
	bl	putchar
	ldr	w0, [sp, 28]
	bl	handleNormal
	str	w0, [sp, 44]
.L26:
	ldr	w0, [sp, 44]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE2:
	.size	handleAfterSlash, .-handleAfterSlash
	.align	2
	.global	handleInComment
	.type	handleInComment, %function
handleInComment:
.LFB3:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	w0, [sp, 28]
	ldr	w0, [sp, 28]
	cmp	w0, 42
	bne	.L29
	mov	w0, 3
	str	w0, [sp, 44]
	b	.L30
.L29:
	ldr	w0, [sp, 28]
	cmp	w0, 10
	bne	.L31
	mov	w0, 2
	str	w0, [sp, 44]
	mov	w0, 10
	bl	putchar
	b	.L30
.L31:
	mov	w0, 2
	str	w0, [sp, 44]
.L30:
	ldr	w0, [sp, 44]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE3:
	.size	handleInComment, .-handleInComment
	.align	2
	.global	handleAfterStar
	.type	handleAfterStar, %function
handleAfterStar:
.LFB4:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	w0, [sp, 28]
	ldr	w0, [sp, 28]
	cmp	w0, 47
	bne	.L34
	str	wzr, [sp, 44]
	b	.L35
.L34:
	ldr	w0, [sp, 28]
	bl	handleInComment
	str	w0, [sp, 44]
.L35:
	ldr	w0, [sp, 44]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE4:
	.size	handleAfterStar, .-handleAfterStar
	.align	2
	.global	handleInString
	.type	handleInString, %function
handleInString:
.LFB5:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	w0, [sp, 28]
	ldr	w0, [sp, 28]
	cmp	w0, 34
	bne	.L38
	str	wzr, [sp, 44]
	ldr	w0, [sp, 28]
	bl	putchar
	b	.L39
.L38:
	ldr	w0, [sp, 28]
	cmp	w0, 92
	bne	.L40
	mov	w0, 6
	str	w0, [sp, 44]
	ldr	w0, [sp, 28]
	bl	putchar
	b	.L39
.L40:
	mov	w0, 4
	str	w0, [sp, 44]
	ldr	w0, [sp, 28]
	bl	putchar
.L39:
	ldr	w0, [sp, 44]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5:
	.size	handleInString, .-handleInString
	.align	2
	.global	handleBackslashString
	.type	handleBackslashString, %function
handleBackslashString:
.LFB6:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	w0, [sp, 28]
	mov	w0, 4
	str	w0, [sp, 44]
	ldr	w0, [sp, 28]
	bl	putchar
	ldr	w0, [sp, 44]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE6:
	.size	handleBackslashString, .-handleBackslashString
	.align	2
	.global	handleInChar
	.type	handleInChar, %function
handleInChar:
.LFB7:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	w0, [sp, 28]
	ldr	w0, [sp, 28]
	cmp	w0, 39
	bne	.L45
	str	wzr, [sp, 44]
	ldr	w0, [sp, 28]
	bl	putchar
	b	.L46
.L45:
	ldr	w0, [sp, 28]
	cmp	w0, 92
	bne	.L47
	mov	w0, 7
	str	w0, [sp, 44]
	ldr	w0, [sp, 28]
	bl	putchar
	b	.L46
.L47:
	mov	w0, 5
	str	w0, [sp, 44]
	ldr	w0, [sp, 28]
	bl	putchar
.L46:
	ldr	w0, [sp, 44]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE7:
	.size	handleInChar, .-handleInChar
	.align	2
	.global	handleBackslashChar
	.type	handleBackslashChar, %function
handleBackslashChar:
.LFB8:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	w0, [sp, 28]
	mov	w0, 5
	str	w0, [sp, 44]
	ldr	w0, [sp, 28]
	bl	putchar
	ldr	w0, [sp, 44]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE8:
	.size	handleBackslashChar, .-handleBackslashChar
	.ident	"GCC: (GNU) 11.4.1 20231218 (Red Hat 11.4.1-3)"
	.section	.note.GNU-stack,"",@progbits
