#!/bin/sh

## change to main bib directory to update articles:
cd ~/Dropbox/Bibliography/
~/bin/bib2bib -ob vasishtharticles.bib -c 'author : "Vasishth"' -c '$type=="ARTICLE" or $type="article"' bibcleaned.bib
#bib2bib -oc vasishthunpub -ob vasishthunpub.bib -c 'author : "Vasishth"'-c '$type="UNPUBLISHED" or $type="unpublished"' bibcleaned.bib
#bib2bib -oc vasishthinproc -ob vasishthinproc.bib -c 'author : "Vasishth"' -c '$type="INPROCEEDINGS" or $type="inproceedings"' bibcleaned.bib

cp vasishtharticles.bib ~/Dropbox/WebPage2014/bib/
cd ~/Dropbox/WebPage2014/bib/

#~/bin/bibtex2html -s dsgplain2  --nobibsource -nf pdf "pdf" -nf code "code+data" -nokeys -dl -a vasishth.bib

export TMPDIR=.

~/bin/bibtex2html -s dsgplain2 -nokeywords  --nobibsource -nf pdf "pdf" -dl -a vasishtharticles.bib
##strip header junk from bib html files:
tail -n +16 vasishtharticles.html > tmp.html
## strip last few lines:
sed '$d' tmp.html | sed '$d' | sed '$d' | sed '$d' > tmp2.html

rm tmp.html
cat tmp2.html dl.txt > tmp3.html
mv tmp3.html vasishtharticles.html
rm tmp2.html


##assemble html:

## move to main WebPage2014 directory:
cd ../

cat header.html bib/vasishtharticles.html footer.html > index.html

##upload index file:
scp index.html vasishth@helios.ling.uni-potsdam.de:/projects/webprivate/vasishth/www/

