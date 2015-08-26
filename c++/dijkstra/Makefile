CPP=g++
CPPFLAGS=-Wall -I.
DEPS=
OBJ=main.o

%: %.cpp $(DEPS)
	$(CPP) $(CPPFLAGS) -c -o $@ $< 
hw:$(OBJ)
	$(CPP) $(CPPFLAGS) -o $@ $^

