
#!/bin/sh

## update cv: change to CV dir, and then run script:
cd ~/Dropbox/CV/

./updatecv.sh

## return to home page directory:
cd /Users/shravanvasishth/Git/vasishth.github.io/

## change to main bib directory to update articles:
cd ~/Dropbox/Bibliography/
~/bin/bib2bib -ob vasishtharticles.bib -c 'author : "Vasishth"' -c '$type ="Article" or $type="ARTICLE" or $type="article" or $type="INCOLLECTION"' bibcleaned.bib

~/bin/bib2bib -ob vasishthunpub.bib -c 'author : "Vasishth"' -c '$type="UNPUBLISHED" or $type="unpublished"' bibcleaned.bib

~/bin/bib2bib -oc vasishthinproc -ob vasishthinproc.bib -c 'author : "Vasishth"' -c '$type="INPROCEEDINGS" or $type="inproceedings"' -c 'year>2016' bibcleaned.bib

cp vasishtharticles.bib /Users/shravanvasishth/Git/vasishth.github.io/update/
cp vasishthunpub.bib /Users/shravanvasishth/Git/vasishth.github.io/update/
cp vasishthinproc.bib /Users/shravanvasishth/Git/vasishth.github.io/update/

cd /Users/shravanvasishth/Git/vasishth.github.io/update/

#~/bin/bibtex2html -s dsgplain2  --nobibsource -nf pdf "pdf" -nf code "code+data" -nokeys -dl -a vasishth.bib

export TMPDIR=.

~/bin/bibtex2html -s dsgplain2 -nokeywords  --nobibsource -nf pdf "pdf" -nf code "code" -dl -a -noabstract vasishtharticles.bib
~/bin/bibtex2html -s dsgplain2 -nokeywords  --nobibsource -nf pdf "pdf" -dl -a -noabstract vasishthunpub.bib
~/bin/bibtex2html -s dsgplain2 -nokeywords  --nobibsource               -dl -a -noabstract vasishthinproc.bib

##strip header junk from bib html files:
tail -n +16 vasishtharticles.html > tmp.html
tail -n +16 vasishthunpub.html > tmpunpub.html
tail -n +16 vasishthinproc.html > tmpinproc.html


## strip last few lines:
sed '$d' tmp.html | sed '$d' | sed '$d' | sed '$d' > tmp2.html
sed '$d' tmpunpub.html | sed '$d' | sed '$d' | sed '$d' > tmpunpub2.html
sed '$d' tmpinproc.html | sed '$d' | sed '$d' | sed '$d' > tmpinproc2.html

rm tmp.html
rm tmpunpub.html
rm tmpinproc.html

cat tmp2.html dl.txt > tmp3.html
cat unpubheader.txt tmpunpub2.html dl.txt > tmpunpub3.html
cat inprocheader.txt tmpinproc2.html dl.txt > tmpinproc3.html

mv tmp3.html vasishtharticles.html
mv tmpunpub3.html vasishthunpub.html
mv tmpinproc3.html vasishthinproc.html

rm tmp2.html
rm tmpunpub2.html
rm tmpinproc2.html

## move to main web page directory:
cd ../

cat header2.html update/vasishtharticles.html update/vasishthunpub.html update/vasishthinproc.html  footer2.html > publications.html

##commit index file:
git commit -m "updated index file" index.html

##commit publications file:
git commit -m "updated pubs" publications.html

##commit cv
git commit -m "updated cv" cv/vasishthcv4.pdf

git push
