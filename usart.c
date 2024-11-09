#define FOSC 16000000UL
#define BAUD 9600
#define UBRR FOSC/16/BAUD-1
#define PERIOD (1000000)
#include <avr/io.h>
#include <stdint.h>

void USART_init(unsigned int ubrr)
{
    // Setting Baud rate
    UBRR0H = (unsigned char)(ubrr >> 8);
    UBRR0L = (unsigned char)ubrr;

    //Enable receiver and transmitter
    UCSR0B = (1 << RXEN0) | (1 << TXEN0);

    //Set frame format: 8data, 2stop bits
    UCSR0C = (1 << USBS0) | (1 << UCSZ00) | (1 << UCSZ01);

    return;
}

void USART_Transmit(unsigned char data)
{
    while(!(UCSR0A & (1  << UDRE0)));

    UDR0 = data;

    return;
}

void print_serial(char* data)
{ 
    for(;*data != '\0';data++) {
        USART_Transmit(*data);
    }
    
    return;
}

int main()
{
    USART_init(UBRR);
    uint32_t count;
    while(1) {
        print_serial("HE\n");
        for(count=0; count < PERIOD; count++) {
            PORTB = 0;
        }
    }
    return 0;
}
