.file	"pm_ev_grupos_6_estudiantes.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
    # Initialize registers x1 to x31
	li	x1, 101
	li	x2, 102
	li	x3, 103
	li	x4, 104
	li	x5, 105
	li	x6, 106
	li	x7, 107
	li	x8, 108
	li	x9, 109
	li	x10, 110
	li	x11, 111
	li	x12, 112
	li	x13, 113
	li	x14, 114
	li	x15, 115
	li	x16, 116
	li	x17, 117
	li	x18, 118
	li	x19, 119
	li	x20, 120
	li	x21, 121
	li	x22, 122
	li	x23, 123
	li	x24, 124
	li	x25, 125
	li	x26, 126
	li	x27, 127
	li	x28, 128
	li	x29, 129
	li	x30, 130
	li	x31, 131

    # Original program starts here
	addi	sp, sp, -32
	sw	s0, 28(sp)
	addi	s0, sp, 32
	li	a5, 49152
	addi	a5, a5, 2015
	sw	a5, -28(s0)
	li	a5, 99
	sb	a5, -29(s0)
	li	a5, 33
	sw	a5, -20(s0)
	sw	zero, -24(s0)
	j	.L2
.L5:
	lw	a5, -24(s0)
	bne	a5, zero, .L3
	li	a5, 98
	sb	a5, -29(s0)
	j	.L4
.L3:
	lw	a5, -20(s0)
	slli	a5, a5, 1
	sw	a5, -20(s0)
	lw	a5, -20(s0)
	andi	a5, a5, 15
	sw	a5, -20(s0)
.L4:
	lw	a5, -24(s0)
	addi	a5, a5, 1
	sw	a5, -24(s0)
.L2:
	lw	a4, -24(s0)
	li	a5, 1
	ble	a4, a5, .L5
	li	a5, 0
	mv	a0, a5
	lw	s0, 28(sp)
	addi	sp, sp, 32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
