    .globl __start
    .text

__start:
    li a0, 5   
    ecall
    jal T          
    mv a1, a0       
    li a0, 1      
    ecall
    li a0, 10        
    ecall

T:
    addi sp, sp, -16  
    sw   ra, 12(sp)   
    sw   s0, 8(sp)    

    li   t0, 2
    blt  a0, t0, T_base  

    mv   s0, a0       
    addi a0, a0, -1   
    jal  T            
    sw   a0, 0(sp)    
    addi a0, s0, -2   
    jal  T            
    lw   t1, 0(sp)    
    slli t1, t1, 1    
    add  a0, t1, a0  
    j    T_end

T_base:

T_end:
    lw   ra, 12(sp)
    lw   s0, 8(sp)   
    addi sp, sp, 16   
    ret               
