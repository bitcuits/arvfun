
MAIN=blink
#MAIN?=fast_pwm

all: upload


$(MAIN).o: $(MAIN).c
	avr-gcc -Os -DF_CPU=16000000UL -mmcu=atmega328p -c -o $(MAIN).o $(MAIN).c

$(MAIN): $(MAIN).o 
	avr-gcc -mmcu=atmega328p  $(MAIN).o -o $(MAIN)

$(MAIN).hex: $(MAIN)
	avr-objcopy -O ihex -R .eeprom $(MAIN) $(MAIN).hex

build: $(MAIN).hex

upload: $(MAIN).hex
	avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyUSB0 -b 115200 -U flash:w:$(MAIN).hex

clean:
	rm -f $(MAIN).o $(MAIN).hex $(MAIN)


 

