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
	cp -r modules ~/.dblocks_modules
	install -m 0755 dwmblocks $(DESTDIR)$(PREFIX)/bin/dwmblocks
	/bin/sh -c "if [ ! -d \".dblocks_modules\" ];then echo \"export PATH=\"~/.dblocks_modules/:$PATH\"\" >> ~/.bashrc; source ~/.bashrc fi"
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dwmblocks
