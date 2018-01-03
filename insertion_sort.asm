;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Created by Trent Bitterman on October 20, 2017
;
; Start of reserved section - Do not change anything here

                .ORIG x3000
                BR Main

; Stack base
Stack           .FILL x4000

; Entry point
Main            LD   R6, Stack         ; Stack initialization
                LD   R5, Stack

                LEA  R0, Array         ; Load the address of the array to be sorted
                LD   R1, Count         ; Load the number of items in array

                ADD  R6, R6, #-1       ; Push address of array onto the stack
                STR  R0, R6, #0
                ADD  R6, R6, #-1       ; Push count onto stack
                STR  R1, R6, #0
                JSR  InsertionSort     ; Call InsertionSort
                ADD  R6, R6, #1        ; Remove parameter from stack
Finish          HALT

; End of reserved section
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Array definition

Count           .FILL #110

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
                .FILL #76
                .FILL #60
                .FILL #90
                .FILL #34
                .FILL #18
                .FILL #84
                .FILL #16
                .FILL #54
                .FILL #83
                .FILL #79
                .FILL #89
                .FILL #38
                .FILL #32
                .FILL #7
                .FILL #82
                .FILL #32
                .FILL #36
                .FILL #53
                .FILL #34
                .FILL #21
                .FILL #100
                .FILL #94
                .FILL #89
                .FILL #14
                .FILL #76
                .FILL #86
                .FILL #43
                .FILL #81
                .FILL #43
                .FILL #28
                .FILL #86
                .FILL #84
                .FILL #84
                .FILL #95
                .FILL #35
                .FILL #77
                .FILL #96
                .FILL #89
                .FILL #76
                .FILL #22
                .FILL #75
                .FILL #19
                .FILL #13
                .FILL #30
                .FILL #30
                .FILL #17
                .FILL #30
                .FILL #4
                .FILL #99
                .FILL #62
                .FILL #4
                .FILL #27
                .FILL #30
                .FILL #26
                .FILL #70
                .FILL #9
                .FILL #22
                .FILL #15
                .FILL #92
                .FILL #10
                .FILL #100
                .FILL #71
                .FILL #97
                .FILL #17
                .FILL #17
                .FILL #79
                .FILL #80
                .FILL #36
                .FILL #45
                .FILL #95
                .FILL #61
                .FILL #38
                .FILL #84
                .FILL #6
                .FILL #68
                .FILL #87
                .FILL #5
                .FILL #95
                .FILL #87
                .FILL #80
                .FILL #33
                .FILL #2
                .FILL #53
                .FILL #51
                .FILL #24
                .FILL #47
                .FILL #20
                .FILL #10
                .FILL #80
                .FILL #82
                .FILL #89
                .FILL #87
                .FILL #52
                .FILL #89
                .FILL #17
                .FILL #85
                .FILL #55
                .FILL #86
                .FILL #42
                .FILL #36

; End of Array definition
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start of insertion sort function

InsertionSort

                ADD  R6, R6, #-1        ; Store return address
                STR  R7, R6, #0
                ADD  R6, R6, #-1        ; Store frame pointer
                STR  R5, R6, #0
                ADD  R5, R6, #0         ; Set up new frame pointer
                LDR  R0, R5, #3         ; Load array address into R0
                LDR  R1, R5, #2         ; Load array length into R1

                .ZERO R2                ; Zero out R2
                ADD  R2, R2, #1         ; Initialize i to 1
WhileI          NOT  R3, R2             ; Two's comp i
                ADD  R3, R3, #1         ;
                ADD  R4, R1, R3         ; Subtract i from count
                BRnz ExitWhileI         ; Exit while loop (array is sorted)
                .ZERO R3                ; Zero out R3 to hold j
                ADD  R3, R2, #0         ; Copy i to j
WhileJ          .SETCC R3               ; Set condition code for j
                BRnz ExitWhileJ         ; Exit inner loop
                ADD  R4, R3, #-1        ; Find j - 1
                ADD  R4, R0, R4         ; Find addr of A[j-1]
                LDR  R1, R4, #0         ; Load value at A[j-1]
                ADD  R5, R0, R3         ; Find addr of A[j]
                LDR  R7, R5, #0         ; Load value at A[j]
                NOT  R7, R7             ; Two's comp A[j]
                ADD  R7, R7, #1         ;
                ADD  R7, R1, R7         ; A[j-1] - A[j]
                BRnz ExitWhileJ         ; Exit inner loop
                LDR  R7, R5, #0         ; Load value at A[j] again
                STR  R7, R4, #0         ; Swap values at A[j] and A[j-1]
                STR  R1, R5, #0         ;
                ADD  R3, R3, #-1        ; Decrement j
                LD   R1, Count          ; Put count back in R1
                BR   WhileJ             ; Continue j loop

ExitWhileJ      ADD  R2, R2, #1         ; Increment i by 1
                LD   R1, Count          ; Put count back in R1
                BR   WhileI             ; Continue I loop

ExitWhileI      LDR  R5, R6, #0         ; Restore R5
                ADD  R6, R6, #1
                LDR  R7, R6, #0         ; Restore R7
                ADD  R6, R6, #1
                RET

; End of insertion sort definition
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                .END
