PREFIX ?= /usr/local
CC ?= cc
LDFLAGS = -lX11

output: dwmblocks.c blocks.def.h blocks.h
	${CC}  dwmblocks.c $(LDFLAGS) -o dwmblocks
blocks.h:
	cp blocks.def.h $@


clean:
	rm -f *.o *.gch dwmblocks blocks.h
install: output
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	if [ ! -d /opt/dblocks_modules ];then mkdir /opt/dblocks_modules; fi
	cp -r modules/* /opt/dblocks_modules/
	install -m 0755 dwmblocks $(DESTDIR)$(PREFIX)/bin/dwmblocks
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dwmblocks
	rm -r /opt/dblocks_modules 2> /dev/null