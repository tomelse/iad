#
#  Makefile by Scott Prahl, Aug 2017
#

VERSION = 3-12-0

#Base directory for installation
DESTDIR=/usr/local

#typical install hierarchy
BIN_INSTALL=$(DESTDIR)/bin
LIB_INSTALL=$(DESTDIR)/lib
INC_INSTALL=$(DESTDIR)/include

#Library extension
#LIB_EXT = .dylib		#MacOS X shared lib
LIB_EXT = .so			#linux shared lib
#LIB_EXT = .a			#static lib

# default executable name
IAD_EXECUTABLE = ./iad

#Mathematica install requires binaries to be installed and then the
#files stored in the right place
MMA_INSTALL=/Users/prahl/Library/Mathematica/Applications/Optics

TAR=gnutar

CFLAGS = 
CFLAGS = -dynamic -fno-common -Wall -ansi  #Needed flags for MacOS X to build .dylib
LOCAL_LIBRARIES = -lm

IAD_OBJ = src/iad_util.o  src/iad_calc.o src/iad_find.o src/iad_pub.o  src/iad_io.o 

AD_OBJ	= src/nr_zbrak.o  src/ad_bound.o src/ad_doubl.o src/ad_frsnl.o src/ad_globl.o src/ad_matrx.o \
		  src/ad_phase.o  src/ad_prime.o src/ad_radau.o src/ad_start.o src/ad_cone.o  src/ad_layers.o
		  
NR_OBJ	= src/nr_amoeb.o  src/nr_amotr.o src/nr_brent.o src/nr_gaulg.o src/nr_mnbrk.o src/nr_rtsaf.o\
		  src/nr_util.o   src/nr_hj.o

MAIN = Makefile INSTALL.md README.md License

DOCS =	doc/CHANGELOG        doc/ToDo.md	        doc/manual.tex      \
		doc/ad_src.pdf       doc/iad_src.pdf	       doc/manual.pdf      \
		doc/ch3RTcorr.pdf    doc/ch3spheremeas.pdf     doc/ch3spheresR.pdf \
		doc/ch3spheresT.pdf  doc/ch3Doublespheres.pdf  doc/colltrans.pdf   \
		doc/lightloss.pdf    doc/niek_graph.pdf        doc/glass-slide.pdf \
		doc/cmdexe.png       doc/valid.png	      doc/dual8.png \
        doc/dual90.png       doc/iad.bib

TEST =	\
		test/Makefile       test/basic-A.rxt    test/basic-B.rxt      test/basic-C.rxt    test/basic-D.rxt\
		test/double.rxt     test/example2.rxt   test/il-A.rxt         test/il-B.rxt       test/il-C.rxt\
		test/ink-A.rxt      test/ink-B.rxt      test/ink-C.rxt        test/kenlee-A.rxt   test/kenlee-B.rxt\
		test/kenlee-C.rxt   test/newton.rxt     test/royston2.rxt     test/royston3-A.rxt test/royston3-B.rxt\
		test/royston3-C.rxt test/royston3-D.rxt test/royston3-E.rxt   test/royston9-A.rxt test/royston9-B.rxt\
		test/royston9-C.rxt test/royston9-D.rxt test/royston_ink1.rxt test/sample-A.rxt   test/sample-B.rxt\
		test/sample-C.rxt   test/sample-D.rxt   test/sample-E.rxt     test/sample-F.rxt   test/sample-G.rxt\
		test/sevick-A.rxt   test/sevick-B.rxt   test/terse-A.rxt      test/terse-B.rxt    test/tio2_vis.rxt\
		test/uterus.rxt     test/valid.bat      test/vio-A.rxt        test/vio-B.rxt      test/x_bad_data.rxt\
		test/ville1.rxt     test/fairway-A.rxt  test/fairway-B.rxt    test/fairway-C.rxt  test/fairway-D.rxt\
		test/fairway-E.rxt  test/basic-E.rxt
		
		
MMA =  mma/AD.m mma/AD.tm mma/Makefile

WSRC =	src/ad.w			src/ad_frsnl.w		 src/ad_prime.w	  src/iad_io.w \
		src/ad_globl.w	    src/ad_radau.w	     src/iad_main.w \
		src/ad_bound.w		src/ad_layers.w		 src/ad_start.w	  src/iad_main_mus.w \
		src/ad_chapter.w	src/ad_layers_test.w src/iad.w		  src/iad_pub.w \
		src/ad_cone.w		src/ad_main.w		 src/iad_calc.w	  src/iad_type.w \
		src/ad_cone_test.w	src/ad_matrx.w		 src/iad_util.w	  src/ad_oblique_test.w\
		src/ad_doubl.w		src/ad_phase.w		 src/iad_find.w

NRSRC = src/nr_amoeb.c		src/nr_amotr.h		 src/nr_gaulg.c	  src/nr_mnbrk.h  src/nr_util.c	   src/nr_zbrak.h \
		src/nr_amoeb.h		src/nr_brent.c		 src/nr_gaulg.h	  src/nr_rtsaf.c  src/nr_util.h \
		src/nr_amotr.c		src/nr_brent.h		 src/nr_mnbrk.c	  src/nr_rtsaf.h  src/nr_zbrak.c \
		src/mygetopt.c		src/mygetopt.h		 src/version.h	  src/mc_lost.c	  src/mc_lost.h	  \
		src/nr_hj.c         src/nr_hj.h	   src/nr_zbrent.h  src/nr_zbrent.c

CSRC  = src/ad_frsnl.c		src/ad_globl.c		 src/ad_matrx.c	  src/ad_start.c  src/iad_calc.c   src/iad_io.c	  \
		src/iad_main.c		src/ad_doubl.c	     src/iad_util.c   src/ad_radau.c  src/iad_pub.c \
		src/ad_prime.c		src/iad_find.c		 src/ad_phase.c	  src/ad_bound.c  src/ad_cone.c \
		src/ad_layers.c		src/version.c 
 
HSRC  = src/ad_bound.h		src/ad_globl.h		 src/ad_phase.h	  src/ad_start.h   src/iad_io.h	   src/iad_type.h \
		src/ad_doubl.h		src/ad_main.h		 src/ad_prime.h	  src/iad_calc.h   src/iad_util.h \
		src/ad_frsnl.h		src/ad_matrx.h		 src/ad_radau.h	  src/iad_find.h   src/iad_pub.h  \
		src/ad_cone_ez.h	src/ad_layers.h      src/ad_cone.h 
 

OSRC  = src/system.bux src/ad.bux src/iad.bux src/cobweb.pl src/version.pl src/Makefile src/toDOS.pl

#tricky perl script that avoids variable names
#there must be a better way to do this name mangling!
#this is necessary because you can only have one period in a zip archive name

#VERSION := $(shell echo $(VERSION) | perl -pe 's/\./-/g; print "xp-version-"')

all :  ad iad
	
check :
	cd test ; make

doc docs: ad_doc iad_doc manual_doc

lib :
	cd src ; make libiad.h
	cp src/libiad.h .
	cd src ; make libiad$(LIB_EXT)
	cp src/libiad$(LIB_EXT) .
	
mma: mma/AD.m mma/AD.exe

mma/AD.exe:
	make install-lib
	cd mma ; make
	
install: ad iad
	mkdir -p $(BIN_INSTALL)
	rm -f $(BIN_INSTALL)/ad
	cp ad  $(BIN_INSTALL)
	rm -f $(BIN_INSTALL)/iad
	cp -f iad $(BIN_INSTALL)

install-lib: lib libiad$(LIB_EXT) libiad.h
	mkdir -p $(LIB_INSTALL)
	mkdir -p $(INC_INSTALL)
	cp libiad.h $(INC_INSTALL)
	cp libiad$(LIB_EXT) $(LIB_INSTALL)
	
install-mma: mma/AD.m mma/AD.exe
	make install-lib
	mkdir -p $(MMA_INSTALL)
	mkdir -p $(MMA_INSTALL)/External
	cp mma/AD.m $(MMA_INSTALL)
	cp mma/AD.exe $(MMA_INSTALL)/External
	
install-all:
	make install
	make install-lib
	make install-mma

dists: dist windist

dist: 
	touch src/version.h
	cd src && ./version.pl
	make doc
	make clean
	make
	cd src ; make tidy
	mkdir -p	   iad-$(VERSION)
	mkdir -p	   iad-$(VERSION)/doc
	mkdir -p	   iad-$(VERSION)/test
	mkdir -p	   iad-$(VERSION)/src
	mkdir -p	   iad-$(VERSION)/mma
	ln $(MAIN)	   iad-$(VERSION)
	ln $(DOCS)	   iad-$(VERSION)/doc
	ln $(TEST)	   iad-$(VERSION)/test
	ln $(WSRC)	   iad-$(VERSION)/src
	ln $(HSRC)	   iad-$(VERSION)/src
	ln $(CSRC)	   iad-$(VERSION)/src
	ln $(NRSRC)	   iad-$(VERSION)/src
	ln $(OSRC)	   iad-$(VERSION)/src
	ln $(MMA)	   iad-$(VERSION)/mma
#	$(TAR) cvf - iad-$(VERSION) | gzip > iad-$(VERSION).tar.gz
	zip -r iad-$(VERSION) iad-$(VERSION)
	rm -rf iad-$(VERSION)
	cp iad-$(VERSION).zip iad-latest.zip

windist: ad.exe iad.exe libiad.dll
	make doc
	cd src ; make tidy
	mkdir -p	    iad-win-$(VERSION)
	mkdir -p	    iad-win-$(VERSION)/doc
	mkdir -p	    iad-win-$(VERSION)/test
	mkdir -p	    iad-win-$(VERSION)/src
	ln ad.exe	   iad-win-$(VERSION)
	ln iad.exe         iad-win-$(VERSION)
	ln libiad.dll      iad-win-$(VERSION)
	ln $(MAIN)         iad-win-$(VERSION)
	ln $(DOCS)         iad-win-$(VERSION)/doc
	ln $(TEST)         iad-win-$(VERSION)/test
	ln $(WSRC)         iad-win-$(VERSION)/src
	ln $(HSRC)         iad-win-$(VERSION)/src
	ln $(CSRC)         iad-win-$(VERSION)/src
	ln $(NRSRC)        iad-win-$(VERSION)/src
	ln $(OSRC)         iad-win-$(VERSION)/src
	src/toDOS.pl       iad-win-$(VERSION)/src/*.c
	src/toDOS.pl       iad-win-$(VERSION)/src/*.h
	src/toDOS.pl       iad-win-$(VERSION)/test/*.rxt
	src/toDOS.pl       iad-win-$(VERSION)/test/valid.bat
	rm iad-win-$(VERSION)/src/*.bak 
	rm iad-win-$(VERSION)/test/*.bak
	zip -r iad-win-$(VERSION) iad-win-$(VERSION)
	rm -rf iad-win-$(VERSION)
	cp iad-win-$(VERSION).zip iad-win-latest.zip

ad: $(WSRC) $(NRSRC)
	touch src/*.c src/*.h
	cd src ; make ad
	cp src/ad ad$(BINARY_EXTENSION)

iad: $(WSRC) $(NRSRC)
	touch src/*.c src/*.h
	cd src ; make iad
	cp src/iad iad$(BINARY_EXTENSION)

ad.exe: $(WSRC) $(NRSRC)
	cd src ; make clean
	cd src ; make CC="i686-w64-mingw32-gcc -DBUILDING_EXAMPLE_DLL" ad
	mv src/ad.exe ad.exe
	cd src ; make clean
    
iad.exe: $(WSRC) $(NRSRC)
	cd src ; make clean
	cd src ; make CC="i686-w64-mingw32-gcc -DBUILDING_EXAMPLE_DLL" iad
	mv src/iad.exe iad.exe
	cd src ; make clean

libiad.dll: $(WSRC) $(NRSRC)
	cd src ; make clean
	cd src ; make CC="i686-w64-mingw32-gcc -DBUILDING_EXAMPLE_DLL" libiad.dll
	mv src/libiad.dll .
	cd src ; make clean

ad_debug: $(WSRC) $(NRSRC)
	cd src ; make ad_debug
	cp src/ad ad$(BINARY_EXTENSION)

iad_debug: $(WSRC) $(NRSRC)
	cd src ; make iad_debug
	cp src/iad iad$(BINARY_EXTENSION)

layer_test: $(WSRC) $(NRSRC)
	cd src ; make layer_test
	src/layer_test$(BINARY_EXTENSION)

ad_doc: 
	perl -pi -e 's/\\def\\adversion.*/\\def\\adversion{$(VERSION)}/' src/ad.w
	cd src ; make ad_doc

iad_doc:
	perl -pi -e 's/\\def\\iadversion.*/\\def\\iadversion{$(VERSION)}/' src/iad.w
	cd src ; make iad_doc

manual_doc doc/manual.pdf: doc/manual.tex 
	cd doc ; pdflatex manual
	cd doc ; bibtex manual
	cd doc ; pdflatex manual
	cd doc ; pdflatex manual
	
clean:
	rm -f ad iad *.pdf libiad.a libiad.so libiad.dylib libiad.h src/lib_iad.h src/lib_ad.h
	rm -f src/*.o test/*.abg
	rm -f texexec.tmp texexec.tui mpgraph.mp mprun.mp texexec-mpgraph.mp texexec.tex
	rm -f src/*.aux src/*.dvi src/*.idx src/*.ref src/*.sref src/*.tex src/*.toc src/*.log src/*.scn
	rm -f iad.exe ad.exe src/iad.exe src/ad.exe
	rm -f libiad.dll src/libiad.dll
	rm -f src/layer_test
	
realclean:
	make clean
	cd src ; make realclean
	rm -f mpgraph.mp texexec-mpgraph.mp texexec.tmp
	rm -f ad iad libiad.h libiad$(LIB_EXT)
	rm -f doc/manual.pdf doc/manual.bbl doc/manual.blg doc/manual.out doc/manual.toc 
	rm -f doc/manual.aux doc/manual.log
	cd mma	; make clean
	cd test ; make clean
	rm -f $(CSRC) $(HSRC)

tidy:
	cd src ; make tidy

shorttest:
	@echo "********* Basic tests ***********"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0
	@echo "EXPECT	   0.0000	   0.0000	   0.0000	   0.0000	   1.0000	   0.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 1
	@echo "EXPECT	   1.0000	   0.9975	   0.0000	   0.0000	   0.0000	   1.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   0.1217	   1.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4671	   3.9307	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.002
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4346	   3.9791	   0.3116"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.049787
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.6221	   3.9698	  -0.6695"
	@echo "********* Specify sample index ************"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -n 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   0.0407	   1.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -n 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.2283	   5.6944	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.002 -n 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.2274	   5.6964	   0.0354"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.045884 -n 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4361	   4.5201	  -0.7630"
	@echo "********* Specify slide index ************"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -n 1.4 -N 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   0.0501	   1.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -n 1.4 -N 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.2596	   5.2724	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.002 -n 1.4 -N 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.2564	   5.2748	   0.1021"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.045884 -n 1.4 -N 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4663	   4.4382	  -0.7532"
	@echo "********* One slide on top ************"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -n 1.4 -N 1.5 -G t
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   0.0501	   1.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -n 1.4 -N 1.5 -G t
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.2608	   5.3013	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.002 -n 1.4 -N 1.5 -G t
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.2577	   5.3037	   0.0991"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.045884 -n 1.4 -N 1.5 -G t
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4688	   4.4589	  -0.7536"
	@echo "********* One slide on bottom ************"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -n 1.4 -N 1.5 -G b
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   0.0487	   1.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -n 1.4 -N 1.5 -G b
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.2564	   5.3589	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.002 -n 1.4 -N 1.5 -G b
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.2536	   5.3618	   0.0898"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.045884 -n 1.4 -N 1.5 -G b
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4800	   4.4960	  -0.7760"
	@echo "********* Absorbing Slide Tests ***********"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.0000000 -t 0.135335 -E 0.5
	@echo "EXPECT	   0.0000	   0.0000	   0.1353	   0.1353	   1.0000	   0.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.0249268 -t 0.155858 -E 0.5
	@echo "EXPECT	   0.0249	   0.0251	   0.1559	   0.1331	   0.5000	   0.5000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.0520462 -t 0.134587 -E 0.5 -n 1.5 -N 1.5
	@echo "EXPECT	   0.0520	   0.0520	   0.1346	   0.1346	   0.5018	   0.4981	   0.0000"
	@echo "********* Constrain g ************"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.4        -g 0.9
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   0.0101	   0.1000	   0.9000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -g 0.9
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4000	   4.0750	   0.9000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4        -g 0.9 -n 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   0.0040	   0.1000	   0.9000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -g 0.9 -n 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.2192	   5.6242	   0.9000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4        -g 0.9 -n 1.4 -N 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   0.0048	   0.1000	   0.9000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -g 0.9 -n 1.4 -N 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.2464	   5.2219	   0.9000"
	@echo "********* Constrain a ************"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.4        -a 0.9
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   0.1111	   0.9316	   0.0684"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -a 0.9
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4608	   3.9379	   0.0505"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -a 0.9 -n 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.3298	   4.8687	  -0.6404"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -a 0.9 -n 1.4 -N 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.3396	   4.7810	  -0.5644"
	@echo "********* Constrain b ************"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -b 3
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.6221	   3.9698	  -0.6694"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -b 3 -n 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4361	   4.5203	  -0.7631"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -b 3 -n 1.4 -N 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4642	   4.4406	  -0.7512"
	@echo "********* Constrain mu_s ************"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.4        -F 30
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   3.6512	  30.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -F 30
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4015	   4.0691	   0.8644"
	$(IAD_EXECUTABLE) -V 0 -r 0.4        -F 30 -n 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   1.2216	  30.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -F 30 -n 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.2193	   5.6405	   0.8120"
	$(IAD_EXECUTABLE) -V 0 -r 0.4        -F 30 -n 1.4 -N 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   1.5044	  30.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -F 30 -n 1.4 -N 1.5
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.2467	   5.2304	   0.8257"
	@echo "********* Constrain mu_a ************"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.3        -A 0.6
	@echo "EXPECT	   0.3000	   0.3000	   0.0000	   0.0000	   0.6000	   2.6427	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.3 -t 0.1 -A 0.6
	@echo "EXPECT	   0.3000	   0.3000	   0.1000	   0.1000	   0.6000	   3.0846	   0.4187"
	$(IAD_EXECUTABLE) -V 0 -r 0.3        -A 0.6 -n 1.5
	@echo "EXPECT	   0.3000	   0.3000	   0.0000	   0.0000	   0.6000	   7.2956	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.3 -t 0.1 -A 0.6 -n 1.5
	@echo "EXPECT	   0.3000	   0.3000	   0.1000	   0.1000	   0.6000	   3.4619	  -0.6482"
	$(IAD_EXECUTABLE) -V 0 -r 0.3        -A 0.6 -n 1.4 -N 1.5
	@echo "EXPECT	   0.3000	   0.3000	   0.0000	   0.0000	   0.6000	   5.9837	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.3 -t 0.1 -A 0.6 -n 1.4 -N 1.5
	@echo "EXPECT	   0.3000	   0.3000	   0.1000	   0.1000	   0.6000	   3.4104	  -0.5899"
	@echo "********* Constrain mu_a and g************"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.3        -A 0.6 -g 0.6
	@echo "EXPECT	   0.3000	   0.3000	   0.0000	   0.0000	   0.6000	   3.1693	   0.6000"
	$(IAD_EXECUTABLE) -V 0 -r 0.3        -A 0.6 -g 0.6 -n 1.5
	@echo "EXPECT	   0.3000	   0.3000	   0.0000	   0.0000	   0.6000	   7.7464	   0.6000"
	$(IAD_EXECUTABLE) -V 0 -r 0.3        -A 0.6 -g 0.6 -n 1.4 -N 1.5
	@echo "EXPECT	   0.3000	   0.3000	   0.0000	   0.0000	   0.6000	   6.4312	   0.6000"
	@echo "********* Constrain mu_s and g************"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.3        -F 2.0 -g 0.5
	@echo "EXPECT	   0.3000	   0.3000	   0.0000	   0.0000	   0.1939	   1.0000	   0.5000"
	$(IAD_EXECUTABLE) -V 0 -r 0.3        -F 2.0 -g 0.5 -n 1.5
	@echo "EXPECT	   0.3000	   0.3000	   0.0000	   0.0000	   0.0778	   1.0000	   0.5000"
	$(IAD_EXECUTABLE) -V 0 -r 0.3        -F 2.0 -g 0.5 -n 1.4 -N 1.5
	@echo "EXPECT	   0.3000	   0.3000	   0.0000	   0.0000	   0.0939	   1.0000	   0.5000"
	@echo "********* Basic One Sphere tests ***********"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.4	   	    -S 1
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   0.1217	   1.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1	       -S 1
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4671	   3.9307	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.002     -S 1
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4346	   3.9791	   0.3116"
	$(IAD_EXECUTABLE) -V 0 -r 0.2 -t 0.2 -u 0.0049787 -S 1
	@echo "EXPECT	   0.2000	   0.2000	   0.2000	   0.2000	   0.5704	   1.6886	   0.6432"
	@echo "******** Basic 10,000 photon tests *********"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.4	   	    -S 1 -p 10000
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   0.1217	   1.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1	       -S 1 -p 10000
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4671	   3.9307	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.002     -S 1 -p 10000
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4346	   3.9791	   0.3116"
	$(IAD_EXECUTABLE) -V 0 -r 0.2 -t 0.2 -u 0.0049787 -S 1 -p 10000
	@echo "EXPECT	   0.2000	   0.2000	   0.2000	   0.2000	   0.5704	   1.6886	   0.6432"
	@echo "******** Basic timed photon tests *********"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.4	   	    -S 1 -p -500
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   0.1217	   1.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1	       -S 1 -p -500
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4671	   3.9307	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.002     -S 1 -p -500
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4346	   3.9791	   0.3116"
	$(IAD_EXECUTABLE) -V 0 -r 0.2 -t 0.2 -u 0.0049787 -S 1 -p -500
	@echo "EXPECT	   0.2000	   0.2000	   0.2000	   0.2000	   0.5704	   1.6886	   0.6432"
	@echo "********* More One Sphere tests ***********"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.4	   	    -S 1 -1 '200 13 13 0'
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   0.1217	   1.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1	       -S 1 -1 '200 13 13 0'
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4671	   3.9307	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.002     -S 1 -1 '200 13 13 0'
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4346	   3.9791	   0.3116"
	$(IAD_EXECUTABLE) -V 0 -r 0.2 -t 0.2 -u 0.0049787 -S 1 -1 '200 13 13 0'
	@echo "EXPECT	   0.2000	   0.2000	   0.2000	   0.2000	   0.5704	   1.6886	   0.6432"
	@echo "********* Basic Two Sphere tests ***********"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.4	   	    -S 2
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   0.1217	   1.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1	       -S 2
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4671	   3.9307	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.002     -S 2
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4346	   3.9791	   0.3116"
	$(IAD_EXECUTABLE) -V 0 -r 0.2 -t 0.1 -u 0.0049787 -S 2
	@echo "EXPECT	   0.2000	   0.2000	   0.1000	   0.1000	   0.8339	   2.2615	   0.4939"
	@echo "********* More Two Sphere tests ***********"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.4	   	    -S 2 -1 '200 13 13 0' -2 '200 13 13 0'
	@echo "EXPECT	   0.4000	   0.4000	   0.0000	   0.0000	   0.1217	   1.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1	       -S 2 -1 '200 13 13 0' -2 '200 13 13 0'
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4671	   3.9307	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.1 -u 0.002     -S 2 -1 '200 13 13 0' -2 '200 13 13 0'
	@echo "EXPECT	   0.4000	   0.4000	   0.1000	   0.1000	   0.4346	   3.9791	   0.3116"
	$(IAD_EXECUTABLE) -V 0 -r 0.2 -t 0.1 -u 0.0049787 -S 2 -1 '200 13 13 0' -2 '200 13 13 0'
	@echo "EXPECT	   0.2000	   0.2000	   0.1000	   0.1000	   0.8339	   2.2615	   0.4939"
	@echo "********* Oblique tests ***********"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -i 60 -r 0.00000 -t 0.13691
	@echo "EXPECT	   0.0000	   0.0000	   0.1369	   0.1369	   0.9941	   0.0000	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -i 60 -r 0.14932 -t 0.23181
	@echo "EXPECT	   0.1493	   0.1493	   0.2318	   0.2318	   0.4980	   0.4966	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -i 60 -r 0.61996 -t 0.30605
	@echo "EXPECT	   0.6200	   0.6199	   0.3060	   0.3060	   0.0382	   2.0176	   0.0000"
	@echo "********* Different Tstd and Rstd ***********"
	@echo "	     Meas R	   Calc R	   Meas T	   Calc T	     mu_a	    mu_s'	        g"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.005  -d 1 -M 0  -S 1 -1 '200 13 13 0' -T 0.5
	@echo "EXPECT	   0.4000	   0.4000	   0.0050	   0.0050	   1.0739	   8.8255	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.4 -t 0.005  -d 1 -M 0  -S 1 -1 '200 13 13 0'
	@echo "EXPECT	   0.4000	   0.4000	   0.0050	   0.0050	   1.0739	   8.8255	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.2 -t 0.01   -d 1 -M 0  -S 1 -1 '200 13 13 0' -R 0.5
	@echo "EXPECT	   0.2000	   0.2000	   0.0100	   0.0100	   1.8796	   4.1017	   0.0000"
	$(IAD_EXECUTABLE) -V 0 -r 0.2 -t 0.01   -d 1 -M 0  -S 1 -1 '200 13 13 0'
	@echo "EXPECT	   0.2000	   0.2000	   0.0100	   0.0100	   1.8796	   4.1017	   0.0000"

longtest:
	cd test ; make 

wintest: ad.exe iad.exe
	make IAD_EXECUTABLE='wine ./iad.exe' shorttest
	cd test ; make IAD_EXECUTABLE='wine ../iad.exe'

help::
	@echo;\
	echo "Targets available for this Makefile:";\
	echo "ad	    compile forward Adding-Doubling program";\
	echo "iad	   compile inverse Adding-Doubling program";\
	echo "clean        remove most generated objects";\
	echo "docs         generate TEX out of all files";\
	echo "dist         gzipped tarball of all files";\
	echo "install      install ad and iad programs";\
	echo "install-lib  install interface and library programs";\
	echo "install-mma  install Mathematica files";\
	echo "install-all  install all the above";\
	echo "lib	   create library binary and interface files";\
	echo "longtest     run iad program on a bunch of test files";\
	echo "mma	   binary AD files for Mathematica";\
	echo "realclean    remove all generated objects";\
	echo "shorttest    test iad program from command line";\
	echo "tidy         generate .c and .h files";\
	echo "win	   generate ad.exe and iad.exe using MingGW-w64";\
	echo "windist      create a windows distribution";\
	echo "wintest      execute command-line and file tests in wine"

.SECONDARY: $(HSRC) $(CSRC)

.PHONY : clean realclean dists dist docs test check lib mma install install-all \
		iad_doc ad_doc manual_doc new_version tidy win windist wintest
		
