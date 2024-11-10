module usart_print;
import avr.util.delay;
import avr.io;
enum FOSC=16_000_000UL;
enum BAUD=9600;
enum UBRR=ubyte(FOSC/16/BAUD-1);
enum PERIOD=1000000UL;

void USART_init(uint ubrr)
{
    // Setting Baud rate
    UBRR0H = cast(ubyte)(ubrr >> 8);
    UBRR0L = cast(ubyte)ubrr;

    //Enable receiver and transmitter
    UCSR0B = (1 << RXEN0) | (1 << TXEN0);

    //Set frame format: 8data, 2stop bits
    UCSR0C = (1 << USBS0) | (1 << UCSZ00) | (1 << UCSZ01);

    return;
}

void USART_Transmit(const char data)
{
    //while(!(UCSR0A & (1  << UDRE0))) {};

    UDR0 = data;

    return;
}

void print_serial(const(char)* data)
{ 
    for(;*data != '\0';data++) {
        USART_Transmit(*data);
    }
    
    return;
}
@safe
struct USART {
    static void baud(const uint baudrate) {
        const ubrr = FOSC/16/baudrate-1;
        // Setting Baud rate
        UBRR0H = cast(ubyte)(ubrr >> 8);
        UBRR0L = cast(ubyte)(ubrr);
        // Enable receiver and transmitter  
        UCSR0B = (1 << RXEN0) | (1 << TXEN0);
        // Set frame format: 8data 2stop bits
        UCSR0C = (1<< USBS0) | (1 << UCSZ00) | (1 << UCSZ01); 
    }
    static void put( char ch)  {
        while(!(UCSR0A & (1 << UDRE0))) {};
        UDR0 = ch;
    }
    //version(none)
    static void print(const(char[]) str) @trusted {
        
        for(ushort i=0; i<cast(ushort)str.length; i++) {
            put(*(str.ptr+i));
        }
    }

    static void println(const(char[]) str)  {
        print(str);
        put('\n');
    }
}

extern(C) void main()
{
    USART.baud=9600;
    //usart.baud = 9600;
    ulong count;
    while(1) {
       USART.println("Hello D");
        for(count=0; count < PERIOD; count++) {
            PORTB = 0;
        }
    }
}
