SOURCES = main.cpp
OBJS = $(SOURCES:%.cpp=%.o)
CC   = g++
LD   = g++
CFLAGS =-std=c++11 -Wall -lm
TARGETS = proj1
.PHONY: all clean 

all: $(TARGETS)

$(TARGETS):
	$(LD) $(CFLAGS) $^ -o $@ $(LDFLAGS)

main.o: main.cpp
proj1: main.o

%.o:
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	@echo Cleaning...
	rm -f $(OBJS) $(TARGETS)
