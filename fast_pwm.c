#ifndef F_CPU
#define F_CPU 8000000UL
#endif

#include <avr/io.h>


int main()
 { 
   DDRD |= (1<<PD6);    //Fast PWM output at OC0A pin

   OCR0A = 191;	// Duty cycle of 75%
	TCCR0A |= (1<<COM0A1) | (1<<WGM01) | (1<<WGM00);	//Non-Inverting Fast PWM mode 3 using OCR A unit
	TCCR0B |= (1<<CS00);	//No-Prescalar

   
    while (1);

   return 0;
 }
