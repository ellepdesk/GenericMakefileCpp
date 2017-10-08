# Include local configuration
-include project.mk

# Set default extention to cpp
CPP_EXT ?= cpp

# Declaration of variables
C++ ?= clang++
C++_FLAGS ?= -Wall -Wextra -std=c++14 -g
LIBRARIES ?=

# File names
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

EXECUTABLE := $(current_dir)
SOURCES := $(wildcard *.$(CPP_EXT))
OBJECTS := $(SOURCES:.$(CPP_EXT)=.o)

.PHONY: all
all: $(EXECUTABLE)

# Main target
$(EXECUTABLE): $(OBJECTS) Makefile
	$(C++) $(C++_FLAGS) $(OBJECTS) $(LIBRARIES) -o $(EXECUTABLE)

# To obtain object files
%.o: %.$(CPP_EXT) Makefile
	$(C++) -c $(C++_FLAGS) $< -o $@

# To remove generated files
.PHONY: clean
clean:
	rm -f $(EXECUTABLE) $(OBJECTS)

# Run executable
.PHONY: run
run: $(EXECUTABLE)
	./$(EXECUTABLE)

# Debug executable
.PHONY: gdb
gdb: $(EXECUTABLE)
	gdb $(EXECUTABLE)
