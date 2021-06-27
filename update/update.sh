
#!/bin/sh

## update cv: change to CV dir, and then run script:
cd ~/Dropbox/CV/

./updatecv.sh

cp vasishthcv4.pdf /Users/shravanvasishth/Git/vasishth.github.io/CV/

## return to home page directory:
cd /Users/shravanvasishth/Git/vasishth.github.io/

git commit -m "add updated cv" cv/vasishthcv4.pdf

## change to main bib directory to update articles:
cd ~/Dropbox/Bibliography/
bib2bib -ob vasishtharticles.bib -sr 'year' -c 'author : "Vasishth"' -c '$type ="Article" or $type="ARTICLE" or $type="article"' bibcleaned.bib

bib2bib -ob vasishthunpub.bib -c 'author : "Vasishth"' -c '$type="UNPUBLISHED" or $type="unpublished"' bibcleaned.bib

bib2bib -oc vasishthinproc -ob vasishthinproc.bib -c 'author : "Vasishth"' -c '$type="INPROCEEDINGS" or $type="inproceedings"' -c 'year>2019' bibcleaned.bib

bib2bib -oc books -ob books.bib -c 'author : "Vasishth"' -c '$type="BOOK" or $type="book" or $type="Book"'  bibcleaned.bib

cp vasishtharticles.bib /Users/shravanvasishth/Git/vasishth.github.io/update/
cp vasishthunpub.bib /Users/shravanvasishth/Git/vasishth.github.io/update/
cp vasishthinproc.bib /Users/shravanvasishth/Git/vasishth.github.io/update/
cp books.bib /Users/shravanvasishth/Git/vasishth.github.io/update/

cd /Users/shravanvasishth/Git/vasishth.github.io/update/

#~/bin/bibtex2html -s dsgplain2  --nobibsource -nf pdf "pdf" -nf code "code+data" -nokeys -dl -a vasishth.bib

export TMPDIR=.

bibtex2html -s dsgplain2 -nokeywords  --nobibsource -nf pdf "pdf" -nf code "code" -dl -a -noabstract vasishtharticles.bib
bibtex2html -s dsgplain2 -nokeywords  --nobibsource -nf pdf "pdf" -dl -a -noabstract vasishthunpub.bib
bibtex2html -s dsgplain2 -nokeywords  --nobibsource               -dl -a -noabstract vasishthinproc.bib
bibtex2html -s dsgplain2 -nokeywords  --nobibsource               -dl -a -noabstract books.bib

##strip header junk from bib html files:
tail -n +16 vasishtharticles.html > tmp.html
tail -n +16 vasishthunpub.html > tmpunpub.html
tail -n +16 vasishthinproc.html > tmpinproc.html
tail -n +16 books.html > tmpbooks.html


## strip last few lines:
sed '$d' tmp.html | sed '$d' | sed '$d' | sed '$d' > tmp2.html
sed '$d' tmpunpub.html | sed '$d' | sed '$d' | sed '$d' > tmpunpub2.html
sed '$d' tmpinproc.html | sed '$d' | sed '$d' | sed '$d' > tmpinproc2.html
sed '$d' tmpbooks.html | sed '$d' | sed '$d' | sed '$d' > tmpbooks2.html

rm tmp.html
rm tmpunpub.html
rm tmpinproc.html
rm tmpbooks.html


cat tmp2.html dl.txt > tmp3.html
cat unpubheader.txt tmpunpub2.html dl.txt > tmpunpub3.html
cat inprocheader.txt tmpinproc2.html dl.txt > tmpinproc3.html
cat booksheader.txt tmpbooks2.html dl.txt > tmpbooks3.html

mv tmp3.html vasishtharticles.html
mv tmpunpub3.html vasishthunpub.html
mv tmpinproc3.html vasishthinproc.html
mv tmpbooks3.html books.html

rm tmp2.html
rm tmpunpub2.html
rm tmpinproc2.html
rm tmpbooks2.html


## move to main web page directory:
cd ../

cat header2.html update/vasishtharticles.html update/vasishthunpub.html update/vasishthinproc.html update/books.html footer2.html > publications.html

##commit index file:
git commit -m "updated index file" index.html

##commit publications file:
git commit -m "updated pubs" publications.html

##commit cv
git commit -m "updated cv" cv/vasishthcv4.pdf

git push
