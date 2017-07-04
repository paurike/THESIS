#Directories
PWD=$(shell pwd)
TEX=$(PWD)/tex
OUTPUT=$(PWD)/output
IGNORE_MISSING_IMAGES=echo R | 

#Main files
MAINTEX=ThesisSkeleton.tex
JOBNAME=Thesis
DVI=Thesis.dvi
PDF=$(JOBNAME).pdf
#for bibtex
AUX=$(JOBNAME).aux
#BST=h-physrev3.bst
#for glossaries
GLOS=$(JOBNAME)

#PRECOMMAND = $(IGNORE_MISSING_IMAGES)
PDFVIEW=acroread 
ALL_TEX=$(shell ls $(TEX)/*.tex)


all :
	make dvi
	make dvi

dvi :   $(ALL_TEX)
	echo Compiling Latex
	#cd $(TEX) && $(PRECOMMAND) pdflatex -jobname=$(JOBNAME) -output-directory=$(OUTPUT) $(MAINTEX) $(PDF)
	#rm $(OUTPUT)/$(BIB).bib
	mkdir -p $(OUTPUT)
	ln -sf $(TEX)/ThesisSkeleton.bib $(OUTPUT)
	#-ln -s $(TEX)/$(BST) $(OUTPUT)
	#cd $(OUTPUT) && makeglossaries $(GLOS)
	#cd $(TEX) && $(PRECOMMAND) pdflatex -jobname=$(JOBNAME) -output-directory=$(OUTPUT) $(MAINTEX) $(PDF)
	cd $(TEX) && $(PRECOMMAND) pdflatex -shell-escape -jobname=$(JOBNAME) -output-directory=$(OUTPUT) $(MAINTEX) $(PDF)
	cd $(OUTPUT) && bibtex $(JOBNAME)
	cd $(TEX) && $(PRECOMMAND) pdflatex -shell-escape -jobname=$(JOBNAME) -output-directory=$(OUTPUT) $(MAINTEX) $(PDF)

show :
	$(PDFVIEW) $(OUTPUT)/$(PDF)

clean : 
	rm $(OUTPUT)/*.aux $(OUTPUT)/*.lof $(OUTPUT)/*.lot $(OUTPUT)/*.toc $(OUTPUT)/*.log $(OUTPUT)/*.bib $(OUTPUT)/*.bst $(OUTPUT)/*.bbl $(OUTPUT)/*.blg
	rm $(OUTPUT)/*.t1 $(OUTPUT)/*.1 $(TEX)/*.1

#wordcount :
#	cd wordCount && ./mywordcount.sh $(TEX) && root -l -b -q makePlot.C++ && cd ..
#	scp wordCount/wordcount.png eprexa:/home/drh/public_web/files/thesis/wordCount.png
