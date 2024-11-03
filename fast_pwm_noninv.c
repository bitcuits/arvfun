#ifndef F_CPU
#define F_CPU 8000000UL
#endif

#include <avr/io.h>


int main()
 { 
   DDRD |= (1<<PD5);    //Fast PWM output at OC0B pin

   OCR0B = 191;	// Duty cycle of 75%
	TCCR0A |= (1<<COM0B1) | (1<<WGM01) | (1<<WGM00);	//Non-Inverting Fast PWM mode 3 using OCR B unit
	TCCR0B |= (1<<CS00);	//No-Prescalar

   while (1);

   return 0;
 }
