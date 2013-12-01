VPATH=src
CPPFLAGS+= -std=c++11 -Wall -Wextra -pedantic
LDFLAGS+=

sources = $(wildcard src/*.cpp)
objects = $(patsubst %.cpp, %.o, $(sources))

exec = prog

$(exec): $(objects)
	$(CXX) -o $@ $^ $(LDFLAGS)

.PHONY: clean
clean:
	rm $(objects) $(exec)
