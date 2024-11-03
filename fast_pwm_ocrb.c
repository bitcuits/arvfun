#ifndef F_CPU
#define F_CPU 8000000UL
#endif

#include <avr/io.h>


int main()
 { 
   DDRD |= (1<<PD5);    //Fast PWM output at OC0B pin

   OCR0A = 200;	// Top Value of 200(must be equal or greater than Duty Cycle)
   OCR0B = 191;	// Duty cycle of 75%
	TCCR0A |= (1<<COM0B1) | (1<<WGM01) | (1<<WGM00);	//Non-Inverting Fast PWM mode 7
	TCCR0B |= (1<<WGM02) | (1<<CS00);	//No-Prescalar

   while (1);

   return 0;
 }
