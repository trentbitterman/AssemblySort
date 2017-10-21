;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start of reserved section - Do not change anything here

                .ORIG x3000
                BR Main

; Stack base
Stack           .FILL x4000

; Entry point
Main            LD    R6, Stack         ; Stack initialization
                LD    R5, Stack

                LEA   R0, Array         ; Load the address of the array to be sorted
                LEA   R1, Count         ; Load the number of items in array

                PUSH  R0                ; Push address of array onto the stack
                PUSH  R1                ; Push count onto stack
                JSR   InsertionSort     ; Call InsertionSort
                ADD R6, R6, #1          ; Remove parameter from stack
Finish          HALT

; End of reserved section
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Array definition

Count           .FILL #10

Array           .FILL #19
                .FILL #12
                .FILL #21
                .FILL #12
                .FILL #8
                .FILL #6
                .FILL #1
                .FILL #7
                .FILL #3
                .FILL #21
                .FILL #0
                .FILL #0
                .FILL #0
                .FILL #0
                .FILL #0

; End of Array definition
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start of insertion sort function

InsertionSort

                PUSH R7                 ; Store return address
                PUSH R5                 ; Store frame pointer
                ADD  R5, R6, #0         ; Set up new frame pointer
                LDR  R0, R5, #3         ; Load array address into R0
                LDR  R1, R5, #2         ; Load array length into R1

                .ZERO R2                ; Zero out R2
                ADD  R2, R2, #1         ; Initialize i to 1
WhileI          NOT  R3, R2             ; Two's comp i
                ADD  R3, R3, #1         ;
                ADD  R4, R1, R3         ; Subtract i from count
                BRnz ExitWhile          ; Exit while loop (array is sorted)
                .ZERO R3                ; Zero out R3 to hold j
                ADD  R3, R2, #0         ; Copy i to j
WhileJ          NOT  R4, R3             ; Two's comp j
                ADD  R4, R4, #1         ;
                ADD  R4, R3, R4         ; Subtract j from j
                BRnz ExitWhileJ         ; Exit inner loop
                ADD  R4, R3, #-1        ; Find j - 1
                ADD  R4, R0, R4         ; Find addr of A[j-1]
                LDR  R4, R4, #0         ; Load value at A[j-1]
                ADD  R5, R0, R3         ; Find addr of A[j]
                LDR  R5, R5, #0         ; Load value at A[j]
                NOT  R5, R5             ; Two's comp A[j]
                ADD  R5, R5, #1         ;
                ; TODO:
                ;  * Calculate A[j-1] - A[j]
                ;  * Maybe store some registers in mem to free them up


ExitWhileJ


ExitWhileI

