module usart_print;
import avr.util.delay;
import avr.io;
enum FOSC=16_000_000UL;
enum BAUD=9600;
enum UBRR=ubyte(FOSC/16/BAUD-1);
enum PERIOD=1000000UL;
import avr.util.delay;

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


struct Formater(ushort size) {
    import std.traits;
    enum symbols="0123456789abcdef";
    char[size] buffer;
    ushort put(T)(T x, ushort index=0, const ubyte base=10) if(isIntegral!T) {
        auto buf=buffer.ptr;
        const sym=symbols.ptr;
        ushort convert(ushort i) {
            if (index < size) {
                const cifra=sym[x % base];
                x/=base;
                if (x == 0) {
                    return i+1;
                }
                buf[i]=cifra;
                return convert(i+ushort(1));
            }
            return i;
        }
        return convert(index);
    }

    const(char[]) get(const ushort len) const {
        Array!char result;
        if (len < size) {
            result.ptr=cast(char*)buffer.ptr;
            result.len = len;
            return result.array;
        }
        return "Buffer overflow-";
    }
    
}

alias Delay = FrequencyDelay!(1 * MHz);

union Array(T) {
    struct {
        T* ptr;
        ushort len;
    }
    T[] array;
}
extern(C) void main()
{
    USART.baud=9600;
    Formater!(20) format;

    ushort count;
    while(1) {
       USART.print("Hello D ");
       const index=format.put(count);
        
        for(ushort i=0; i<index; i++) {
            USART.put(format.buffer.ptr[i]);
        }
        USART.println("");
        //        USART.println(format.get(index));
       Delay.delayMsecs!(1000);
    count++;
   }
}
