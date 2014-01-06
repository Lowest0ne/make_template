CPPFLAGS+= -std=c++11 -Wall -Wextra -pedantic -Werror
LDFLAGS+=

sources=$(wildcard src/*.cpp src/functions/*.cpp)
objects=$(sources:%.cpp=%.o)
depends=$(sources:%.cpp=%.d)

exec=prog

all: $(deps) $(exec)

deps: $(depends)

$(exec):$(objects)
	$(CXX) -o $@ $(objects) $(LDFLAGS)

%.d: %.cpp
	@set -e; rm -f $@; \
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

-include $(sources:.cpp=.d)

.PHONY: clean
clean:
	rm $(depends) $(objects) $(exec)
