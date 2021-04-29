.global lab4
.syntax unified

#define X1 #18
#define X2 #-9
#define X3 #23
#define X4 #11

#define ZACHETKA_STARSHI #0x80480000
#define ZACHETKA #0b10000000010010

lab4:
	push {lr}
	bl task1
	bl task2
	pop {pc}

task1:
	push {lr}
	mov r0, X1
	mov r1, #0

	mov r2, X2
	mov r3, #0xFFFFFFFF

	mov r4, X3
	mov r5, #0

	mov r6, X4
	mov r7, #0

	// Calculation: 16 * [(X1 - 1) & X2] - (X3 + X4) / 4

	// X1 - 1
	sub r0, #1
	sbc r1, #1

	// (X1 - 1) & X2
	and r0, r2
	and r1, r3

	// 16 * [(X1 - 1) & X2]
	lsl r0, #4
	lsl r1, #4

	// X3 + X4
	add r4, r6
	adc r5, r7

	// (X3 + X4) / 4
	asr r4, #2
	lsr r5, #2

	// 16 * [(X1 - 1) & X2] - (X3 + X4) / 4
	sub r0, r4
	sbc r1, r5

	bl result_correction
	pop {pc}
	
// Result correction
result_correction:
	push {lr}
	bvc step2
	lsr r0, #1
	lsr r1, #1
step2:
	orr r0, #0
	bne step4
	orr r1, #0
	bne step4
	ldr r7, =ZACHETKA_STARSHI
	mov r0, r7
step4:
	ldr r7, =ZACHETKA
    add r1, r7
	and r5, r1, #0xc0000000
	beq step7
	eor r5, #0xc0000000
	beq step7
	lsr r0, #1
	lsr r1, #1
step7:
	bvs end_correction
	push {r0}
	push {r1}
	pop {r1}
	pop {r0}

end_correction:
	pop {pc}

task2:
	push {lr}

	mov r1, #25
	mov r2, #5

program_a:
	// 1: r0 = r1 + r2
	add r0, r1, r2
	
	// 2: r0 = r1 * r2
	mul r0, r1, r2
	
jump3:
	// 3: r0 = r1 - r2
	sub r0, r1, r2
	
	// 4: jump1
	beq jump1
	
	// 6: r0 = r1 * r2
	mul r0, r1, r2
	
	b jump2
jump1:
	// 5: r0 = r0 + 33
	add r0, #33
	
	// 7: r1 = r1 - 33
	sub r1, #33
jump2:
	// 8: jump3
	bls jump3
	
	// 9: r0 = r0 & r1
	and r0, r1
	pop {pc}

program_b:
	push {lr}
jump5:
	// 10: r2 = r2 + 100
	add r2, #100
	
	// 11: jump4
	bpl jump4
	
	bl program_c
	
	// 12: r1 = r1 ^ r2 
	eor r1, r2
jump4:
	// 13: jump5
	beq jump5

	// 14: r0 = r1 * r2
	mul r0, r1, r2
	
	// 15: r0 = r1 - r2
	sub r0, r1, r2
	
	pop {pc}

program_c:
	push {lr}
	
	// 17: r0 = r1 + 33
	adds r0, r1, 33
	
	// 18: r0 = r2 / r1
	udiv r0, r2, r1
	
	pop {pc}
