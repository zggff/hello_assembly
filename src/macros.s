.ifndef	__macros__
.set	__macros__,	0

.macro syscall syscall X0 
	mov 	X16, \syscall
	svc 	#0x80
.endm

.macro syscall1 syscall X0 
	mov 	X0, \X0
	mov 	X16, \syscall
	svc 	#0x80
.endm

.macro syscall2 syscall X0 X1 
	mov 	X0, \X0
	mov 	X1, \X1
	mov 	X16, \syscall
	svc 	#0x80
.endm

.macro syscall3 syscall X0 X1 X2
	mov 	X0, \X0
	mov 	X1, \X1
	mov 	X2, \X2
	mov 	X16, \syscall
	svc 	#0x80 
.endm

.macro get_adress register label
	adrp 	\register, 	\label@PAGE
	add		\register,	\register,	\label@PAGEOFF
.endm

.endif