source_dirs := $(wildcard src/*)
build_dirs := $(source_dirs:src/%=build/%)

.PHONY: all clean

all: $(build_dirs)

build/%: src/%
	ponyc $< -o build

clean:
	rm -rf build
