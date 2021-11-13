; Printing "Hello World!!!" using Interrupt 10h and Subfunction 0Eh


ORG 100h

MOV AH, 0Eh   

 
MOV AL, 72    

INT 10h 

MOV AL, 101 
INT 10h   

MOV AL, 108  
INT 10h

MOV AL, 108
INT 10h   

MOV AL, 111 
INT 10h 

MOV AL, 32
INT 10h

MOV AL, 87  
INT 10h

MOV AL, 111
INT 10h

MOV AL, 114
INT 10h

MOV AL, 108
INT 10h    

MOV AL, 100
INT 10h  

MOV AL, 33
INT 10h

MOV AL, 33
INT 10h

MOV AL, 33
INT 10h  


RET

END
