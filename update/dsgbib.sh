#!/bin/sh

bibtex2html -s dsgplain -both -nokeys -nf extended "Extended version" -nf doc ".doc" -nf ppt ".ppt" -nf poster "Poster" -nf EMW-nytt "EMW-nytt" -dl -a publications.bib
awk "/<dl>/, /<\/dl>/" publications.html | sed -f sed_script > /public/www/theory/dsg/publications/publications.html
awk "/<dl>/, /<\/dl>/" publications-abstracts.html | sed -e 's/<blockquote><font size="-1">/<blockquote style="font-size: smaller;">/' -e 's/<\/font><\/blockquote>/<\/blockquote>/' -e 's/<P>/<br><br>/' -f sed_script > /public/www/theory/dsg/publications/abstracts-include.html
grep -v OPT publications-bib.html > /public/www/theory/dsg/publications/publications-bib.html
s/.*<dl>/<dl>/
s/<\/dl>.*/<\/dl>/
s/<dd>/<dd style="margin-left: 0;">/
s/<em>/<i>/g
s/<\/em>/<\/i>/g
s/Robert Suzic/Robert Suzi\&#263;/g
s/``/\&#8220;/g
s/''/\&#8221;/g
s/'/\&#8217;/g
