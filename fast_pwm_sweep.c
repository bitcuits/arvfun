#ifndef F_CPU
#define F_CPU 8000000UL
#endif

#include <avr/io.h>
#include <stdint.h>

#define SWEEP (50000)
int main(){ 
    uint8_t from, to, pwm;
    uint16_t count;
    from =48; to=191;
    DDRD |= (1<<PD6);    //Fast PWM output at OC0A pin

   //OCR0A = 191;	// Duty cycle of 75%
	TCCR0A |= (1<<COM0A1) | (1<<WGM01) | (1<<WGM00);	//Non-Inverting Fast PWM mode 3 using OCR A unit
	TCCR0B |= (1<<CS00);	//No-Prescalar

    pwm=from;
     
    while (1) {
        
        // Duty cycle of 75%
        while (pwm < to) {
            for(count=0; count < SWEEP; count++) {
                OCR0A = pwm;	// Duty cycle of 75%
            
            }
            pwm++;
        }
        while (pwm > from) {
            for(count=0; count < SWEEP; count++) {
                OCR0A = pwm;	// Duty cycle of 75%
            
            }
            pwm--;
        }
    }

   return 0;
 }
