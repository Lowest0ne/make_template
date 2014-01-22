sources=$(wildcard   \
  src/*.cpp          \
)
depends=$(sources:%.cpp=%.d)
objects=$(sources:%.cpp=%.o)
exec=prog

CXXFLAGS+=-std=c++11 -Wall -Wextra -pedantic -Werror
LDFLAGS+=

debug:CXXFLAGS+=-g -O2
debug:all

release:CXXFLAGS+=-O6
release:all

profile:CXXFLAGS+=-pg -O6
profile:LDFLAGS+=-pg
profile:all

all: $(depends) $(exec)

$(exec):$(objects)
	$(CXX) -o $@ $^ $(LDFLAGS)

%.d:%.cpp
	@$(CXX) -std=c++11 -MM $< |\
	sed "s,\(^.*\.o\),$(@D)/\1 $@,g" >$@

-include $(depends)

.PHONY: clean
clean:
	rm $(depends) $(objects) $(exec)
