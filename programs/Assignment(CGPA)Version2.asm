; CSC 234 Assignment
; Name: ADEOTI WARITH ADETAYO
; Matric No.: 214851
; Computer Science, 200lv
; November 31, 2021

;               A Program to Calculate CGPA



ORG 100h

INCLUDE "emu8086.inc"

; Printing My name and Matric Number
PUTC 9    ; Printing a tab character
PUTC 9
PUTC 9
PRINT "CGPA OF ADEOTI WARITH ADETAYO"
PUTC 10   ; Printing a newline character
PUTC 13   ; Printing a carriage return character
PUTC 9
PUTC 9
PUTC 9 
PRINT "MATRIC NO.: 214851"
PUTC 10
PUTC 10
PUTC 10
PUTC 13
;End of Info Printing


;Printing Header of a table
PRINT "COURSE"
PUTC 9
PRINT "UNIT" 
PUTC 9
PRINT "SCORE"
PUTC 9  
PRINT "GP"
PUTC 9
PRINT "WGP"
PUTC 10
PUTC 10
PUTC 13
;End of Header Printing


MOV CX, 15     ; 15 is the total number of courses offered
MOV BX, 0      ; For Indexing (Addressing)


calc2:
    MOV SI, [courses+BX]
    CALL PRINT_STRING       ; Printing course code
    PUTC 9
    
    MOV AX, [scores+BX]
    MOV DI, AX
         
    
    CALL getPoint           ; Calling the getPoint procedure
    
    MOV AX, [units+BX]
    ADD [total_units], AX
    CALL PRINT_NUM          ; Printing Unit
    PUTC 9
    
    MOV AX, DI
    CALL PRINT_NUM          ; Printing score
    PUTC 9 
    
    
    MOV AX, DX
    CALL PRINT_NUM          ; Printing Grade Point
    PUTC 9
    
    MOV AX, [units+BX]       
    MUL DX
    MOV [wgp+BX], AX
    CALL PRINT_NUM          ; Printing Weighted Grade Point 
    
    
    ADD [twgp], AX       
    
    
    PUTC 10
    PUTC 13

    ADD BX, 2    
    DEC CX
 
    
CMP CX, 0
 
JNE calc2                   ; Loop (by jumping to the label 'calc2') untill CX becomes 0




MOV AX, [twgp]

MOV [dividend], AX




MOV CX, [precision]
INC CX
MOV BX, 0

indecimal:                     ; Implementing a float division
    MOV DI, [total_units]    
    DIV DI
    
    
    
    MOV [quotient], AX
    MOV [cgpa+BX], AX
    
      
    MUL DI            
    
   
    MOV [remainder], AX
    MOV AX, [dividend]
    SUB AX, [remainder]
    

    MOV DX, 10
    MUL DX
   
    
        
    MOV [dividend], AX  

    
    ADD BX, 2
    DEC CX
     

CMP CX, 0           
    
JNE indecimal

PUTC 10
PUTC 13

CALL printCGPA                          ; Print the calculated CGPA             
          


                        

 
RET


;My Courses  CSC102 CSC103 GES101 GES107 GES108 MAT111 MAT121 MAT141 PHY102 PHY103 PHY104 PHY104 PHY105 PHY118 STA115 STA121
course1 dw "CSC102", 0
course2 dw "CSC103", 0
course3 dw "GES101", 0
course4 dw "GES107", 0
course5 dw "GES108", 0
course6 dw "MAT111", 0
course7 dw "MAT121", 0
course8 dw "MAT141", 0
course9 dw "PHY102", 0
course10 dw "PHY103", 0
course11 dw "PHY104", 0
course12 dw "PHY105", 0
course13 dw "PHY118", 0
course14 dw "STA115", 0
course15 dw "STA121", 0

courses: dw course1, course2, course3, course4, course5, course6, course7, course8, course9, course10, course11, course12, course13, course14, course15   

scores: dw 77, 76, 78, 82, 81, 85, 74, 91, 72, 66, 90, 78, 62, 62, 75
units: dw 4, 4, 3, 2, 2, 4, 4, 4, 3, 3, 3, 3, 3, 3, 3
wgp: dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

twgp dw 0               ; Variable to hold the totat wgp
total_units dw 0        ; Varible to hold the total units
remainder dw 0
quotient dw 0
dividend dw 0
precision dw 2          ; Decimal Precision (CGPA has precision of 2 decimal place)

cgpa: dw 0, 0, 0        ; An array variable to hold the cgpa digits

; NOTE: if precision is increased, increase the number
;       of elements in cgpa according 
 

; Definition of a procedure to get the grade point of scores
getPoint PROC
    
    CMP AX, 70
    JNL a
    
    CMP AX, 60
    JNL b
    
    CMP AX, 50
    JNL c
    
    CMP AX, 45
    JNL d    
    
    CMP AX, 45
    JL e
    
    
    a: MOV DX, 4
    JMP EXIT
    
    b: MOV DX, 3
    JMP EXIT
        
    c: MOV DX, 2
    JMP EXIT
    
    d: MOV DX, 1
    JMP EXIT
    
    e: MOV DX, 0     

    
EXIT: RET
getPoint ENDP
  
  
; A Procedure to print out the final results of the program (TWGP, TU and CGPA)  
printCGPA PROC
    PUTC 9
    PRINT "TOTAL WEIHGTED GRADE POINT: "
    MOV AX, [twgp]
    CALL PRINT_NUM
    PUTC 10
    PUTC 13
    
    PUTC 9
    PRINT "TOTAL UNITS: "    
    MOV AX, [total_units]
    CALL PRINT_NUM
    
    GOTOXY 50, 12
    PRINT "CGPA: "
    
    MOV BX, 0    
    
    MOV AX,[cgpa+BX]
    CALL PRINT_NUM    
    PUTC 46
    
    ADD BX, 2
    MOV CX, [precision]
    
    print:
        MOV AX, [cgpa+BX]      
        ADD BX, 2
        
        CALL PRINT_NUM
        
        
        DEC CX
    
    CMP CX, 0
    JNE print
    
     
RET
printCGPA ENDP



DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PRINT_STRING



END