
#include <stdint.h>
#include <avr/io.h>
#include <util/delay.h>
#define BLINK_DELAY_MS (500)

int main() {
    DDRB |=0b00100111;
    while (1) {
	    PORTB |=0b00100001;
            _delay_ms(BLINK_DELAY_MS);
	    PORTB &= ~0b00100001;
	    PORTB |=0b00100011;
	    _delay_ms(BLINK_DELAY_MS);
	    PORTB &= ~0b00100011;
 	    PORTB |=0b00100010;
	    _delay_ms(BLINK_DELAY_MS);
	    PORTB &= ~0b00100010;
    	    PORTB |=0b00100100;
	    _delay_ms(BLINK_DELAY_MS);
	    PORTB &= ~0b00100100;
     }
}
