## $Id$
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
	faq.shtml \
	index.shtml \
	links.shtml \
	manual.shtml \
	news.shtml 

INCL_FILES=\
	left_column.incl \
	main_footer.incl \
	page_start.incl \
	${BUILT_INCL_FILES}

HTML_OUT=	${SHTML_IN:.shtml=.html}

# add the dependency on the .incl files
${HTML_OUT} : ${INCL_FILES}

# the include= is a ':' seperated search path for SSI directives
SHTML2HTML=	${AWK} -f $(top_srcdir)/utils/shtml2html include=$(SHTML_INCLUDE_PATH)

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
update-man: pcb.html pcb-cvs.pdf pcb-cvs.ps

pcb.html: ../pcb/doc/pcb.html
	cp -p ../pcb/doc/pcb.html $@

pcb-cvs.pdf: ../pcb/doc/pcb.pdf
	cp -p ../pcb/doc/pcb.pdf $@

pcb-cvs.ps: ../pcb/doc/pcb.ps
	cp -p ../pcb/doc/pcb.ps $@


