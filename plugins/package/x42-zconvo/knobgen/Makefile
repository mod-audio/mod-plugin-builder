CFLAGS+=`pkg-config --cflags cairo` -Wall
LOADLIBES+=`pkg-config --libs cairo` -lm

all: knob

knob: knob.c

clean:
	rm -f knob knob.png

.PHONY: clean
