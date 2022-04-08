.include "macros.s"
.include "globals.s"


.ifndef __print__
.set 	__print__, 0

.macro print_hex value
    mov     X0,     \value
    bl      _print_hex
.endm

.macro print_str str
    b 3f
    .align 4
    1:  .ascii "\str"
    2:
    .align 2
    3:
        adr X1, 1b
        syscall3 SYS_write, STDOUT, X1, 2b - 1b
        b 4f
    .align 4
    4:
.endm 

.text 
	.align 2
	.global print_hex
	print_hex:
		get_adress		X1,     hexstr
		add		X1, 	X1,	 	#17	
		mov		W5, 	#16
	1:
		and		W6,		W0,		#0x0F
		cmp 	W6, 	#10
		b.ge	2f
		add		W6, 	W6, 	#'0'
		b		3f
	2:
		add		W6, 	W6, 	#('A'-10)
	3:
		strb	W6, 	[X1]
		sub 	X1, 	X1, 	#1
		LSR		X0,		X0,		#4
		SUBS	W5,		W5,		#1
		b.ne 1b
		get_adress		X1,     hexstr
		syscall3 SYS_write, STDOUT, X1, hexstr_len
		br 		lr

.data
	hexstr:     .ascii  "0x0000000000000000\n"
	hexstr_len =. - hexstr

.endif
