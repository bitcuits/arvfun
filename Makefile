
MAIN=blink
#MAIN=hello_wold
#MAIN=usart
#MAIN?=fast_pwm
MAIN=usart_print
include platform.atmega328p.mk

BAUD_RATE=115200
UPLOAD_PORT=/dev/ttyUSB0
#UPLOAD_PORT=/dev/ttyACM0


DINC+=avrd/source
DINC+=avrd/src-devices

DFLAGS+=-betterC
DFLAGS+=-Oz

MTRIPLE=avr
LINKER=arv-gcc

all: upload


ifdef CLANG
$(MAIN).o: $(MAIN).c
	avr-gcc -Os -DF_CPU=16000000UL -mmcu=$(AVR_ARCH) -c -o $(MAIN).o $(MAIN).c

else
$(MAIN).o: $(MAIN).d
	ldc2 $(DFLAGS) $(addprefix -I,$(DINC)) --d-version=$(AVR_VERSION) -mtriple=avr -mcpu=$(AVR_ARCH) -Xcc=-mmcu=$(AVR_ARCH) -gcc=avr-gcc $(MAIN).d

endif



$(MAIN): $(MAIN).o 
	avr-gcc -mmcu=$(AVR_ARCH)  $(MAIN).o -o $(MAIN)

$(MAIN).hex: $(MAIN)
	avr-objcopy -O ihex -R .eeprom $(MAIN) $(MAIN).hex

build: $(MAIN).hex

upload: $(MAIN).hex
	avrdude -F -V -c arduino -p $(AVR_MCU) -P$(UPLOAD_PORT) -b $(BAUD_RATE) -U flash:w:$(MAIN).hex

clean:
	rm -f $(MAIN).o $(MAIN).hex $(MAIN)


 

