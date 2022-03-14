# hello - example program using Suckless packaging style
# see LICENSE file for copyright and license details.
.POSIX:

include config.mk

SRC = hello.c
OBJ = $(SRC:.c=.o)

all: options hello

options:
	@echo hello build options:
	@echo "CFLAGS  = $(STCFLAGS)"
	@echo "LDFLAGS = $(STLDFLAGS)"
	@echo "CC      = $(CC)"

config.h:
	cp config.def.h config.h

.c.o:
	$(CC) $(STCFLAGS) -c $<

hello.o: config.h

$(OBJ): config.h config.mk

hello: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)

hello.1: hello.1.md
	pandoc --standalone --to man hello.1.md -o hello.1

clean:
	rm -f hello $(OBJ) hello-$(VERSION).tar.gz

dist: clean
	mkdir -p hello-$(VERSION)
	cp -R LICENSE Makefile README config.mk\
		config.def.h hello.1 $(SRC)\
		hello-$(VERSION)
	tar -cf - hello-$(VERSION) | gzip > hello-$(VERSION).tar.gz
	rm -rf hello-$(VERSION)

install: hello
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f hello $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/hello
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" <hello.1 >$(DESTDIR)$(MANPREFIX)/man1/hello.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/hello.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/hello
	rm -f $(DESTDIR)$(MANPREFIX)/man1/hello.1

.PHONY: all options clean dist install uninstall
