	.text
	.globl	local
	.globl	global
	.data
	.align	2
	.type	local, @object
	.size	local, 4
local:
	.word	10
	.type	global, @object
	.size	global, 4
global:
	.word	20
	.globl	tls
	.section	.tbss,"awT",@nobits
	.align	2
	.type	tls, @object
	.size	tls, 4
tls:
	.space	4
	.section	.rodata
	.align	3
.LC0:
	.ascii	"local %d,\000"
	.align	3
.LC1:
	.ascii	" global %d\012\000"
	.text
	.align	2
	.globl	f1
	.type	f1, @function
f1:
.LFB0 = .
	.cfi_startproc
	addi.d	$r3,$r3,-16
	.cfi_def_cfa_offset 16
	st.d	$r1,$r3,8
	stptr.d	$r22,$r3,0
	.cfi_offset 1, -8
	.cfi_offset 22, -16
	addi.d	$r22,$r3,16
	.cfi_def_cfa 22, 0

	.fill 0x2000,4,0x03400000	

.Lm1:
	pcaddu12i	$r12,%pcadd_hi20(local)
	ld.w	$r12,$r12,%pcadd_lo12(.Lm1)

	or	$r5,$r12,$r0
.Lm2:
	pcaddu12i	$r12,%pcadd_hi20(.LC0)
	addi.d	$r4,$r12,%pcadd_lo12(.Lm2)

	pcaddu12i	$r12,%call32(printf)
	jirl	$ra,$r12,0

.Lm3:
	pcaddu12i	$r12,%pcadd_got_hi20(global)
	ld.d	$r12,$r12,%pcadd_lo12(.Lm3)

	ldptr.w	$r12,$r12,0
	or	$r5,$r12,$r0
.Lm4:
	pcaddu12i	$r12,%pcadd_hi20(.LC1)
	addi.d	$r4,$r12,%pcadd_lo12(.Lm4)

	pcaddu12i	$r12,%call32(printf)
	jirl	$ra,$r12,0

	nop
	ld.d	$r1,$r3,8
	.cfi_restore 1
	ldptr.d	$r22,$r3,0
	.cfi_restore 22
	addi.d	$r3,$r3,16
	.cfi_def_cfa_register 3
	jr	$r1
	.cfi_endproc
.LFE0:
	.size	f1, .-f1
	.align	2
	.globl	main
	.type	main, @function
main:
.LFB1 = .
	.cfi_startproc
	addi.d	$r3,$r3,-16
	.cfi_def_cfa_offset 16
	st.d	$r1,$r3,8
	stptr.d	$r22,$r3,0
	.cfi_offset 1, -8
	.cfi_offset 22, -16
	addi.d	$r22,$r3,16
	.cfi_def_cfa 22, 0
	pcaddu12i $r12,%call32(f1)
	jirl	  $ra,$r12,0
	pcaddu12i $r12,%call32(f2)
	jirl	  $ra,$r12,0

	or	$r12,$r0,$r0
	or	$r4,$r12,$r0
	ld.d	$r1,$r3,8
	.cfi_restore 1
	ldptr.d	$r22,$r3,0
	.cfi_restore 22
	addi.d	$r3,$r3,16
	.cfi_def_cfa_register 3
	jr	$r1
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.section	.rodata
	.align	3
.LC2:
	.ascii	"desc %d,\000"
	.align	3
.LC3:
	.ascii	" ie %d\012\000"
	.text
	.align	2
	.globl	f2
	.type	f2, @function
f2:
.LFB2 = .
	.cfi_startproc
	addi.d	$r3,$r3,-16
	.cfi_def_cfa_offset 16
	st.d	$r1,$r3,8
	stptr.d	$r22,$r3,0
	.cfi_offset 1, -8
	.cfi_offset 22, -16
	addi.d	$r22,$r3,16
	.cfi_def_cfa 22, 0

#	.fill 0x2000,4,0x03400000	

.Lm5:
	pcaddu12i	$r4,%pcadd_desc_hi20(tls)
	addi.d	$r4,$r4,%pcadd_lo12(.Lm5)
	ld.d	$r1,$r4,%desc_ld(.Lm5)
	jirl	$r1,$r1,%desc_call(.Lm5)

	add.d	$r12,$r4,$r2
	addi.w	$r13,$r0,100			# 0x64
	stptr.w	$r13,$r12,0
.Lm6:
	pcaddu12i	$r4,%pcadd_desc_hi20(tls)
	addi.d	$r4,$r4,%pcadd_lo12(.Lm6)
	ld.d	$r1,$r4,%desc_ld(.Lm6)
	jirl	$r1,$r1,%desc_call(.Lm6)

	add.d	$r12,$r4,$r2
	ldptr.w	$r12,$r12,0
	or	$r5,$r12,$r0
.Lm7:
	pcaddu12i	$r12,%pcadd_hi20(.LC2)
	addi.d	$r4,$r12,%pcadd_lo12(.Lm7)

	pcaddu12i	$r12,%call32(printf)
	jirl	$ra,$r12,0

.Lm8:
	pcaddu12i	$r12,%pcadd_ie_hi20(tls)
	ld.d	$r12,$r12,%pcadd_lo12(.Lm8)

	add.d	$r12,$r12,$r2
	addi.w	$r13,$r0,200			# 0xc8
	stptr.w	$r13,$r12,0
.Lm9:
	pcaddu12i	$r12,%pcadd_ie_hi20(tls)
	ld.d	$r12,$r12,%pcadd_lo12(.Lm9)

	add.d	$r12,$r12,$r2
	ldptr.w	$r12,$r12,0
	or	$r5,$r12,$r0
.Lm10:
	pcaddu12i	$r12,%pcadd_hi20(.LC3)
	addi.d	$r4,$r12,%pcadd_lo12(.Lm10)

	pcaddu12i	$r12,%call32(printf)
	jirl	$ra,$r12,0

	nop
	ld.d	$r1,$r3,8
	.cfi_restore 1
	ldptr.d	$r22,$r3,0
	.cfi_restore 22
	addi.d	$r3,$r3,16
	.cfi_def_cfa_register 3
	jr	$r1
	.cfi_endproc
.LFE2:
	.size	f2, .-f2
