.syntax unified
.cpu cortex-m4
.thumb

.equ A, 0
.equ B, 1
.equ C, 2
.equ X1, 0
.equ X2, 4
.equ NUM_ROOTS, 8
.equ SHIFT_AMOUNT, 16  
.equ ITERATIONS, 5

.section .text
.global quadratic_roots
.global sqrt

quadratic_roots:
    push {lr}

    ldrb r0, [r0, #A]
    cmp r0, #0
    beq linear_solution

    ldrb r1, [r0, #B]
    ldrb r2, [r0, #C]

    mov r3, #4
    mul r4, r0, r3
    mul r5, r1, r1
    sub r5, r5, #4
    cmp r5, #0
    blt no_real_roots

    bl sqrt
    mov r6, r0

    neg r1, r1
    add r7, r1, r6
    add r8, r1, r6

    mov r9, r4
    sdiv r10, r7, r9
    sdiv r11, r8, r9

    str r10, [r0, #X1]
    str r11, [r0, #X2]

    movs r12, #2
    str r12, [r0, #NUM_ROOTS]

done:
    pop {pc}

linear_solution:
    ldrb r1, [r0, #B]
    ldrb r2, [r0, #C]
    neg r2, r2
    sdiv r3, r2, r1
    str r3, [r0, #X1]

    movs r4, #1
    str r4, [r0, #NUM_ROOTS]

    b done

no_real_roots:
    movs r4, #0
    str r4, [r0, #NUM_ROOTS]
    b done

sqrt:
    push {lr}

    mov r2, #0           
    mov r3, #0           

sqrt_loop:
    lsl r2, r2, #2       
    add r2, r2, #1       
    add r3, r3, #1       
    cmp r3, #ITERATIONS
    bne sqrt_loop

    mov r0, r2         

    pop {pc}
.end
