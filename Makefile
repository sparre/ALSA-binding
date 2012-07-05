include .config

PROJECT=alsa_binding
GENERATED_SOURCE_FILES=sound-constants.ads
GENERATED_EXECUTABLES=test_alsa_binding
EXECUTABLES=$(GENERATED_EXECUTABLES)
SCRIPT_SETTINGS=
PRECOMPILED_UNITS=

all: build

clean:
	rm -f *.o *.ali b~*.ads b~*.adb

build: style-check build-depends $(GENERATED_SOURCE_FILES) $(SCRIPT_SETTINGS) $(PRECOMPILED_UNITS) FORCE
	gnatmake $(shell echo $(GNATMAKE_ARGS)) -P $(PROJECT)

test: build
	@echo "Testing not implemented yet."

install: build
	mkdir -p "$(DESTDIR)$(PREFIX)/bin"
	if [ ! -z "$(EXECUTABLES)"     ]; then install --target "$(DESTDIR)$(PREFIX)/bin"             $(EXECUTABLES);     fi
	if [ ! -z "$(SCRIPT_SETTINGS)" ]; then install --target "$(DESTDIR)$(PREFIX)/bin" --mode=0644 $(SCRIPT_SETTINGS); fi

build-depends:
	@test "$(DISTRIBUTION)" = "Debian wheezy/sid" && ( dpkg -l libasound2-dev | grep '^ii  libasound2-dev ' 1>/dev/null || sudo apt-get install libasound2-dev ) || true
	@test "$(DISTRIBUTION)" = "Debian 6.0.1"      && ( dpkg -l libasound2-dev | grep '^ii  libasound2-dev ' 1>/dev/null || sudo apt-get install libasound2-dev ) || true
	@test "$(DISTRIBUTION)" = "Debian 6.0.4"      && ( dpkg -l libasound2-dev | grep '^ii  libasound2-dev ' 1>/dev/null || sudo apt-get install libasound2-dev ) || true
	@test "$(DISTRIBUTION)" = "Debian 6.0.5"      && ( dpkg -l libasound2-dev | grep '^ii  libasound2-dev ' 1>/dev/null || sudo apt-get install libasound2-dev ) || true
	@test "$(DISTRIBUTION)" = "Ubuntu 11.10"      && ( dpkg -l libasound2-dev | grep '^ii  libasound2-dev ' 1>/dev/null || sudo apt-get install libasound2-dev ) || true

style-check:
	@if egrep -l '	| $$' *.ad? | grep -v '^b[~]'; then echo "Please remove tabs and end-of-line spaces from the source files listed above."; false; fi

distclean: clean
	rm -f $(GENERATED_EXECUTABLES) $(GENERATED_SOURCE_FILES)
	rm -f .config .config.sh

generate_sound_constants: generate_sound_constants.c
	gnatgcc generate_sound_constants.c -lasound -o generate_sound_constants

sound-constants.ads: generate_sound_constants
	./generate_sound_constants > sound-constants.ads

.PHONY: FORCE
FORCE:

