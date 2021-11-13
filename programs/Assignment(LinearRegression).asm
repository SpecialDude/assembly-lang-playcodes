 ; CSC 234 Assignment 2
 ; Name: ADEOTI WARITH ADETAYO
 ; Matric No: 214851
 ; Computer Science, 200lv
 ; November 11, 2021
 
 
 ;              A Linear Regression and Correlation Program
 

ORG 100h 

INCLUDE "emu8086.inc"


                  
PUTC 9
PUTC 9
PUTC 9
PRINT "LINEAR REGRESSION AND CORRELATION"
PUTC 10
PUTC 13
PUTC 9
PUTC 9
PUTC 9
PUTC 9
PRINT "By Adeoti Warith Adetayo (214851)"
PUTC 10
PUTC 13

PRINTN "DATA TO WORK WITH"

PRINT "X (Input Variable)"
PUTC 10
PUTC 13
PUTC 9




MOV CX, [data_size]
MOV SI, [x_data]

CALL PrintArray

PUTC 10
PUTC 13

PRINT "Y (Output Variable)"
PUTC 10
PUTC 13
PUTC 9


MOV CX, [data_size]
MOV SI, [y_data]
CALL PrintArray

PUTC 10
PUTC 10
PUTC 13
;Printing Header of a table
PRINT "X"
PUTC 9
PRINT "Y" 
PUTC 9
PRINT "XY"
PUTC 9  
PRINT "XSquared"
PUTC 9
PRINT "YSquared"
PUTC 10
PUTC 10
PUTC 13
;End of Header Printing


MOV BX, 0
MOV CX, [data_size]

data:
    MOV BP, [x_data+BX]
    MOV DI, [y_data+BX]
    
    MOV AX, BP
    ADD [sumX], AX    
    CALL PRINT_NUM
    PUTC 9
    
    MOV AX, DI
    ADD [sumY], AX    
    CALL PRINT_NUM
    PUTC 9
    
    MUL BP
    ADD [sumXY], AX
    CALL PRINT_NUM
    PUTC 9
    
    MOV AX, BP
    CALL Square
    ADD [sumXSquared], AX
    CALL PRINT_NUM
    PUTC 9
    PUTC 9
    
    MOV AX, DI
    CALL Square
    ADD [sumYSquared], AX
    CALL PRINT_NUM
    
    PUTC 10
    PUTC 13
    
    ADD BX, 2
    DEC CX
    
CMP CX, 0

JNZ data


PUTC 10
PUTC 10

PRINT "Data Size: "
MOV AX, [data_size]
CALL PRINT_NUM
PUTC 10
PUTC 13

PRINT "Sum of X: "
MOV AX, [sumX]
CALL PRINT_NUM
PUTC 10
PUTC 13

PRINT "Sum of Y: "
MOV AX, [sumY]
CALL PRINT_NUM
PUTC 10
PUTC 13

PRINT "Sum of XY: "
MOV AX, [sumXY]
CALL PRINT_NUM
PUTC 10
PUTC 13

PRINT "Sum of XSquare: "
MOV AX, [sumXSquared]
CALL PRINT_NUM
PUTC 10
PUTC 13

PRINT "Sum of YSquare: "
MOV AX, [sumYSquared]
CALL PRINT_NUM
PUTC 10
PUTC 13

PUTC 10
PRINTN "Calculating the regression coefficient..."
PUTC 9

; Formular:       N(sumXY) - (sumX)(sumY)
;                -------------------------
;                N(sumXSquared) - (sumX)^2

MOV AX, [data_size]
MOV BX, [sumXY]
MUL BX

MOV CX, AX

MOV AX, [sumX]
MOV BX, [sumY]
MUL BX

SUB CX, AX

MOV [numerator], CX     ; Numerator

MOV AX, [data_size]
MOV BX, [sumXSquared]
MUL BX

MOV BX, AX

MOV AX, [sumX]
CALL Square

SUB BX, AX      ; Denominator

MOV AX, [numerator] 


CALL Divide 



PRINT "= " 
CALL PrintAfterDivide


PUTC 10
PUTC 13
PRINTN "Calculating the correlation coefficient..."
PUTC 9

; Formular:                             N(sumXY) - (sumX)(sumY)
;                ----------------------------------------------------------------
;                sqrt( [N(sumXSquared) - (sumX)^2] x [N(sumYSquared) - (sumY)^2] )


; Calculating the Denominator
MOV AX, [sumXSquared]

MOV BX, [data_size]

MUL BX

MOV BX, AX

MOV AX, [sumX]

CALL Square

SUB BX, AX

MOV AX, BX

CALL Sqrt


MOV SI, AX


MOV AX, [sumYSquared]
MOV BX, [data_size]  
MUL BX               
MOV BX, AX           
MOV AX, [sumY]       
CALL Square          
SUB BX, AX
           
MOV AX, BX 

CALL sqrt


MUL SI

                           
MOV SI, AX
; END Calculating the Denominator



; Calculating the Numerator
MOV AX, [sumXY]
MOV BX, [data_size]
MUL BX

MOV DI, AX

MOV AX, [sumX]
MOV BX, [sumY]
MUL BX

SUB DI, AX
; END Calculating the Numerator


MOV AX, DI

MOV BX, SI  



CALL Divide     ;Dividing the numerator and the denominator

PRINT "= "

 
CALL PrintAfterDivide 

PUTC 10
PUTC 13
PUTC 9

CALL PrintCorrelationType



RET

 
x_data: dw 10, 20, 30, 40, 50, 50, 60, 80, 45, 100      ; Independent Variable
y_data: dw 43, 46, 90, 54, 89, 90, 67, 90, 67, 145      ; Dependent Variable

data_size dw 5

sumX dw 0
sumY dw 0
sumXY dw 0
sumXSquared dw 0
sumYSquared dw 0

numerator dw 0

precision dw 4
wquotient dw 0
dquotient dw 0
quotient dw 0
 
 
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PRINT_STRING


; A Procedure to Print Contents of an Array

PrintArray PROC
    MOV BX, 0
    
    PRINT "["    
    display:
        MOV AX, [SI+BX]
        CALL PRINT_NUM
        PRINT ", "
    
        ADD BX, 2
        DEC CX
    

    CMP CX, 1

    JNE display


    MOV AX, [SI+BX]
    CALL PRINT_NUM
    PRINTN "]"

RET
PrintArray ENDP  


; Procedure to get square root of a number

Sqrt PROC
    MOV CX, 0
    MOV BX, 0FFFFh
    
    repeat:
        ADD BX, 0002
        INC CX
    
        SUB AX, BX
    
    JGE repeat
    
    DEC CX
    
    MOV AX, CX
    
RET
Sqrt ENDP


; Procedure to square any number

Square PROC
    MUL AX
    
RET
Square ENDP


; Procedure to find the power of any number

Power PROC    
    
    CMP CX, 0
    JE one 
    
    MOV DI, AX
    MOV SI, CX
    MOV AX, 1
    
    multiply:
        MUL DI
        
        DEC CX
    
    CMP CX, 0
    
    JG multiply
    
    MOV CX, SI
    JMP exit
    
    one:
        MOV AX, 1
    
    

exit: RET
Power ENDP


Divide PROC
    MOV CX, [precision]
    
    MOV [dquotient], 0
    
    MOV BP, AX      ;dividend
    
    DIV BX          ;divisor
    
    MOV [wquotient], AX      ;qoutient
    
    MUL BX
    
    MOV SI, BP
    SUB SI, AX
        
    JZ final        
    
    
    decimal:
        MOV AX, SI
        
        MOV BP, 10
        
        MUL BP   
        
        
        MOV BP, AX      ;dividend
        
        DIV BX          ;divisor
        
         
                       
        
        MOV [quotient], AX      ;qoutient
        
        
        MOV AX, 10
        
        DEC CX
                
        CALL Power
        
        INC CX  
        
        
        
        MUL [quotient] 
        
        
        ADD [dquotient], AX
        
        
        MOV AX, [quotient]        
        
        MUL BX
        
        
        
        MOV SI, BP
        
        SUB SI, AX
        
        
        DEC CX
    
    
    
    CMP CX, 0
    JNZ decimal
    
        
    
    final:
        MOV BX, [dquotient]
        
        MOV AX, [wquotient]   
    
    
RET

Divide ENDP



PrintAfterDivide PROC
    CALL PRINT_NUM
    
    MOV DI, AX

    MOV AX, BX 

    PUTC 46

    CALL PRINT_NUM
    
    MOV AX, DI
RET
PrintAfterDivide ENDP



PrintCorrelationType PROC
    CMP AX, 0
    JE maybecore
    
    CMP AX, 1
    JE positive
    
    CMP AX, -1
    JE negative
    
    
    maybecore:
        CMP BX, 0
        JE nocore
        JMP strength

    
    
    nocore:
        PRINT "No Linear Correlation"
        JMP return
    
    negative:
        PRINT "Perfect Negative Linear Correlation"
        JMP return
        
    positive:
        PRINT "Perfect Positive Linear Correlation"
        JMP return
        
    
    strength:
        CMP BX, 5000
        JGE strong
        JLE weak
        
        strong:
            PRINT "Strong Linear Correlation"  
            JMP return
        
        weak:
            PRINT "Weak Linear Correlation"
            JMP return
        
        
return: RET
PrintCorrelationType ENDP


END