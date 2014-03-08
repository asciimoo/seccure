CFLAGS = -ggdb -O0 -Wall # -D NOBEEP

default: binaries # doc

binaries: seccure

doc: seccure.1 seccure.1.html

install: default
	install -m0755 seccure $(DESTDIR)/usr/bin
	install -m0644 seccure.1 $(DESTDIR)/usr/share/man/man1

clean:
	rm -f *.o *~ seccure # seccure.1 seccure.1.html

rebuild: clean default

seccure: seccure.o numtheory.o ecc.o serialize.o protocol.o curves.o aes256ctr.o
	$(CC) $(CFLAGS) -ggdb -O0 -o seccure -lgcrypt seccure.o numtheory.o ecc.o \
	curves.o serialize.o protocol.o aes256ctr.o
#strip seccure

seccure.o: seccure.c
	$(CC) $(CFLAGS) -c seccure.c

numtheory.o: numtheory.c numtheory.h
	$(CC) $(CFLAGS) -c numtheory.c

ecc.o: ecc.c ecc.h
	$(CC) $(CFLAGS) -c ecc.c

curves.o: curves.c curves.h
	$(CC) $(CFLAGS) -c curves.c

serialize.o: serialize.c serialize.h
	$(CC) $(CFLAGS) -c serialize.c

protocol.o: protocol.c protocol.h
	$(CC) $(CFLAGS) -c protocol.c

aes256ctr.o: aes256ctr.c aes256ctr.h
	$(CC) $(CFLAGS) -c aes256ctr.c

seccure.1: seccure.manpage.xml
	xmltoman seccure.manpage.xml > seccure.1

seccure.1.html: seccure.manpage.xml
	xmlmantohtml seccure.manpage.xml > seccure.1.html
