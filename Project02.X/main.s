#include <xc.inc>

Countl equ 08h

psect   barfunc,local,class=CODE,delta=2 ; Assuming PIC10/12/16

global _bar
_bar:
    bsf STATUS, 5        ; Set bit 5 of STATUS register
    movlw 01h            ; Load literal value 01h into W register
    movwf TRISA          ; Move contents of W register into TRISA register
    bcf STATUS, 5        ; Clear bit 5 of STATUS register

    clrf PORTA           ; Clear PORTA initially

start:
    btfss PORTA, 0       ; Test bit 0 of PORTA (button pressed)
    goto button_not_pressed ; If bit 0 is not set, check for button release

    ; Button is pressed, turn on LED
    bsf PORTA, 1         ; Set bit 1 of PORTA (LED on)
    call delay           ; Call the delay subroutine
    goto start           ; Go back to start

button_not_pressed:
    ; Button is released, turn off LED
    bcf PORTA, 1         ; Clear bit 1 of PORTA (LED off)
    call delay           ; Call the delay subroutine
    goto start           ; Go back to start

delay:
    decfsz Countl, f     ; Decrement Countl and skip if zero
    goto delay           ; If Countl is not zero, go back to delay
    return               ; Return from delay subroutine

end