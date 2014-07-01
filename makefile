sources=$(wildcard   \
  src/*.cpp          \
)
depends=$(sources:%.cpp=%.d)
objects=$(sources:%.cpp=%.o)
exec=prog

CXXFLAGS+=-std=c++11 -Wall -Wextra -pedantic
LDFLAGS+=

debug:CXXFLAGS+=-g -O2
debug:all

release:CXXFLAGS+=-O6
release:all

profile:CXXFLAGS+=-pg -O6
profile:LDFLAGS+=-pg
profile:all

glib_profile: CXXFLAGS+= -O6 -D_GLIBCXX_PROFILE
glib_profile: all

all: $(depends) $(exec)

$(exec):$(objects)
	$(CXX) -o $@ $^ $(LDFLAGS)

%.d:%.cpp
	@$(CXX) $(CXXFLAGS) -MM $< |\
	sed "s,\(^.*\.o\),$(@D)/\1 $@,g" >$@

-include $(depends)

.PHONY: clean
clean:
	rm $(depends) $(objects) $(exec)
