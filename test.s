.equ ADDR_VGA, 0x08000000
.equ ADDR_CHAR, 0x09000000
.equ JTAG_UART,0x10001000
.equ TIMER,0x10002000
.equ PERIOD,0X02FAF080   # about 5M cycles = 1 sec
.equ PS2_Controller,0x10000100
.equ PUSH_BUTTON, 0x10000050
.equ LEDR, 0x10000000

.section .data
.global .data
	.align 2
	#123
array_size:		.word 26
A:	 	.word 0x00000041
B:		.word 0x00000042
C:		.word 0x00000043
D:		.word 0x00000044
E:		.word 0x00000045
F:		.word 0x00000046
G:		.word 0x00000047
H:		.word 0x00000048
I:		.word 0x00000049
J:		.word 0x0000004a
K:		.word 0x0000004b
L:		.word 0x0000004c
M:		.word 0x0000004d
N:		.word 0x0000004e
O:		.word 0x0000004f
P:		.word 0x00000050
Q:		.word 0x00000051
R:		.word 0x00000052
S:		.word 0x00000053
T:		.word 0x00000054
U:		.word 0x00000055
V:		.word 0x00000056
W:		.word 0x00000057
X:		.word 0x00000058
Y:		.word 0x00000059
Z:		.word 0x0000005a		# 7th valid, 6th frist bit of x, 5-4th xpos, 3-2nd ypos, 1-0 char 

.section .text
.global main
main:
  call clear_screen
  #hahahohohahahahalala
  movia r8,ADDR_VGA
  movia r9, ADDR_CHAR
  #movui r10,0xffff  /* White pixel */
  movia r14,A
  ldwio r11,0(r14)
  #movi  r11, 0x41   /* ASCII for 'A' */
  #sthio r10,1032(r8) /* pixel (4,1) is x*2 + y*1024 so (8 + 1024 = 1032) draw a white dot on (4,1) */
  stbio r11,132(r9) /* character (4,1) is x + y*128 so (4 + 128 = 132) */
  movi r12,0x5a		# ASCII for 'Z'
  
  increchar:
	addi r14,r14,0x4			# increament letter
	ldwio r11,0(r14)
	addi r9,r9,130				# char buffer
	#sthio r10, 1032(r8)
	#stbio r11, 132(r9)
	call timer
	call clear_screen
	call clear_charscreen
	blt r11,r12,increchar
  	br loop_forever

	
	
	
	
	
	
	
	
	
	
	
	
	
	
loop_forever:
	br loop_forever
	
	
	
timer:
	subi sp,sp,32         
stw r23,28(sp)
stw r22,24(sp)
stw r21,20(sp)
stw r20,16(sp)
stw r19,12(sp)
stw r18,8(sp)
stw r17,4(sp)
stw r16,0(sp)             
	
	movia r18,TIMER
	movi r17,%lo(PERIOD)
	stwio r17,8(r18)		# low 16 bits
	movi r17,%hi(PERIOD)
	stwio r17,12(r18)
	stwio r0,0(r18)
	movi r17,0b110
	stwio r17,4(r18)
	POLL:
		ldwio r17,0(r18)
		andi r17,r17,0x1  
		beq r17,r0,POLL
	
		#CALEE RESTORE
ldw r23,28(sp)       
ldw r22,24(sp)
ldw r21,20(sp)
ldw r20,16(sp)
ldw r19,12(sp)
ldw r18,8(sp)
ldw r17,4(sp)
ldw r16,0(sp)
addi sp,sp,32      
	ret
	
 
