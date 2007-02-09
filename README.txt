# $Id$
#

To modify the web pages:

-) edit the .incl or .shtml files

-) run 'make' to generate the .html files

-) run weblint on the html files and preview them to make sure they're ok

-) check in the .shtml files

-) run make again

-) check in the .html files



-----------------------

updating for a new snapshot

add pcb-yyyymmdd with manuals
edit manual.shtml
edit index.shtml
edit news.shtml

for the news, try

awk '/Release/{r++} r==2{exit} {gsub(/</, "\&lt;"); gsub(/>/, "\&gt;"); gsub(/^-/, "</li>\n<li>"); print}' ../pcb/NEWS

