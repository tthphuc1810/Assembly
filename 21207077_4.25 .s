#21207077_TranThienPhuc
#4.25
.text
.global _start
_start:
	movia r16, PhanDau
	movia r2, PhanNguyen
	movia r3, PhanThapPhan
	ldw r16, (r16)
	ldhu r4, (r2)
	ldhu r5, (r3)
	slli r4,r4,16
	or 	 r6,r4,r5
	movhi r8,0x8000
	movhi r22,0x8000
	movi  r23,-1
	for:
		#srli r8,r8,13
		#srli r22,r22,13
		and r9,r8,r6
		beq r9,r22,one
		srli r22,r22,1   
		srli r8,r8,1 
		br for
	one:
		movi  r22,8
		slli  r22,r22,12	#r22=0x8000
		addi  r8,r8,0xffffffff
		movi  r9,8
		slli  r9,r9,12   # r9=0x8000
		andhi  r14,r6,0xffff 
		beq r14,r0,benphai
	bentrai:
	nhan:#tìm số mũ bên trái
		and  r9,r9,r8
		bne	  r9,r22,thoat
		slli r9,r9,1
		slli r22,r22,1
		addi r23,r23,1
		br		nhan
	benphai: #tìm số mũ bên phải
		movi r23,0
	tinhsomu:
		and  r15,r9,r8
		bne	 r15,r0,thoat
		srli r9,r9,1
		subi r23,r23,1
		br	 tinhsomu
	thoat:
		addi r23,r23,127 
		movi r9,1
		movi r15,1
	saudauphay:
		mov  r10,r6
		and  r10,r10,r9
		beq  r10,r9,dem1
		srli r6,r6,1
		srli r8,r8,1
		br	 saudauphay
	dem1:
		movi r10,1
		movi r11,0
	dem:
		and  r9,r9,r8   
		bne  r9,r15,t1
		slli r9,r9,1
		slli r15,r15,1
		slli r10,r10,1
		addi r10,r10,1
		addi r11,r11,1
		br	dem
	t1:
		and  r6,r6,r8
		movi r8,32
		sub  r11,r8,r11
		subi r11,r11,9
		sll  r6,r6,r11
		slli r23,r23,23
		slli r16,r16,31
		add  r16,r16,r6
		add  r16,r16,r23
	
	STOP: 
                br STOP
.data
PhanDau: .word 0x0
PhanNguyen: .hword 0x0004
PhanThapPhan: .hword 0x4000
KetQua: .word 0
.end	