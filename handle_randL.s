.global handle_randL
.extern handle_randXpos

handle_randL:
movi sp, 0x00800000
call random
	subi sp,sp,36
	stw ra,32(sp)         
	stw r23,28(sp)
	stw r22,24(sp)
	stw r21,20(sp)
	stw r20,16(sp)
	stw r19,12(sp)
	stw r18,8(sp)
	stw r17,4(sp)
	stw r16,0(sp)             
		

addi r17, r2, 0x40	# offset between 1-26 and asciis

updateFlag:
	# loop through memory to find the correct letter
	movia r18, array_size
	ldw r19, 0(r18)
	andi r19, r19, 0xff # mask out last 2 bytes which is letter identifier
	movi r20, 0x5a #ascii for Z

loop_mem:
	bgt r19, r20, exit	# condition to break: loop through all letters
	addi r18, r18, 0x04
	ldw r19, 0(r18)
	andi r19, r19, 0xff
	bne r19, r17, loop_mem
	ldw r19, 0(r18)
	ori r19, r19, 0x10000000 # update valid byte
	mov r2, r19	# pass parameter

	###caller save reg###
		subi sp,sp,32
		stwio r8,0(sp)
		stwio r9,4(sp)
		stwio r10,8(sp)
		stwio r11,12(sp)
		stwio r12,16(sp)
		stwio r13,20(sp)
		stwio r14,24(sp)
		stwio r15,28(sp)
	call handle_randXpos
		#restore caller save reg
		ldwio r8,0(sp)
		ldwio r9,4(sp)
		ldwio r10,8(sp)
		ldwio r11,12(sp)
		ldwio r12,16(sp)
		ldwio r13,20(sp)
		ldwio r14,24(sp)
		ldwio r15,28(sp)
		addi sp,sp,32

	stw r2, 0(r18)

exit:
			#CALEE RESTORE
	ldw ra,32(sp)
	ldw r23,28(sp)       
	ldw r22,24(sp)
	ldw r21,20(sp)
	ldw r20,16(sp)
	ldw r19,12(sp)
	ldw r18,8(sp)
	ldw r17,4(sp)
	ldw r16,0(sp)
	addi sp,sp,36  

ret
