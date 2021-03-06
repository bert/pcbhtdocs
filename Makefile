## Top level makefile for building the PCB web pages
##

srcdir=	.
top_srcdir=	.
AWK?=	awk

.PHONY: default
default: all

# the include= is a ':' seperated search path for SSI directives
SHTML_INCLUDE_PATH= $(srcdir)

SHTML_IN=	\
	bugs.shtml \
	contributing.shtml \
	faq.shtml \
	index.shtml \
	links.shtml \
	manual.shtml \
	news.shtml \
	obtaining.shtml

INCL_FILES=\
	left_column.incl \
	main_footer.incl \
	page_start.incl \
	${BUILT_INCL_FILES}

HTML_OUT=	${SHTML_IN:.shtml=.html}

# add the dependency on the .incl files
${HTML_OUT} : ${INCL_FILES}

# the include_= is a ':' seperated search path for SSI directives
SHTML2HTML=	${AWK} -f $(top_srcdir)/utils/shtml2html include_=$(SHTML_INCLUDE_PATH)

# All the new suffix rules

.SUFFIXES : .shtml .html

.shtml.html :
	$(SHTML2HTML) $< > $@

.PHONY: show-var
show-var:
	@echo ${${VARNAME}}

.PHONY: clean
clean:
	rm -f *~ ${HTML_OUT}

.PHONY: all
all: ${HTML_OUT} favicon.ico


favicon.ico: favicon.xpm
	xpmtoppm favicon.xpm | ppmtowinicon > $@

.PHONY: update-man
update-man:
	cp ../pcb/doc/pcb.html pcb-cvs/
	cp ../pcb/doc/pcb.pdf pcb-cvs/
	cp ../pcb/doc/pcb.ps pcb-cvs/
	cp ../pcb/doc/*.png pcb-cvs/
	wc -c pcb-cvs/pcb.html | awk '{print $$1 / 1024}'
	wc -c pcb-cvs/pcb.pdf | awk '{print $$1 / 1024}'
	wc -c pcb-cvs/pcb.ps | awk '{print $$1 / (1024*1024)}'

