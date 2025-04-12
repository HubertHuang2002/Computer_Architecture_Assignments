.globl __start

.rodata
    division_by_zero: .string "division by zero"

.text
__start:
    # Read first operand
    li a0, 5
    ecall
    mv s0, a0
    # Read operation
    li a0, 5
    ecall
    mv s1, a0
    # Read second operand
    li a0, 5
    ecall
    mv s2, a0

###################################
#  TODO: Develop your calculator  #
#                                 #
###################################
start_calc:
    li t0, 0
    beq s1, t0, OP_ADD
    li t0, 1
    beq s1, t0, OP_SUB
    li t0, 2
    beq s1, t0, OP_MUL
    li t0, 3
    beq s1, t0, OP_DIV
    li t0, 4
    beq s1, t0, OP_MIN
    li t0, 5
    beq s1, t0, OP_POW
    li t0, 6
    beq s1, t0, OP_FACT
    j done

OP_ADD:
    add s3, s0, s2
    j done

OP_SUB:
    sub s3, s0, s2
    j done

OP_MUL:
    mul s3, s0, s2
    j done

OP_DIV:
    beqz s2, division_by_zero_except
    div s3, s0, s2
    j done

OP_MIN:
    slt t1, s0, s2   
    beqz t1, MIN_ELSE
    mv s3, s0
    j done
MIN_ELSE:
    mv s3, s2
    j done

OP_POW:
    li s3, 1
    beqz s2, done
POW_LOOP:
    mul s3, s3, s0
    addi s2, s2, -1
    bgtz s2, POW_LOOP
    j done

OP_FACT:
    li s3, 1
    beqz s0, done
    mv t1, s0
FACT_LOOP:
    mul s3, s3, t1
    addi t1, t1, -1
    bgtz t1, FACT_LOOP
    j done

done:
    j output
###################################



output:
    # Output the result
    li a0, 1
    mv a1, s3
    ecall

exit:
    # Exit program(necessary)
    li a0, 10
    ecall

division_by_zero_except:
    li a0, 4
    la a1, division_by_zero
    ecall
    jal zero, exit
