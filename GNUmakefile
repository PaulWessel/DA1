#
#       Makefile for Data Analysis Text Book 1
#
# Updated July, 2020
# Note: With SVG no longer being supported by gs it is unlikely
# there will ever be a epub version of this book.

# LaTeX command
#PDFLATEX=pdflatex --interaction=batchmode
PDFLATEX=pdflatex
ECONVERT=/Applications/calibre.app/Contents/MacOS/ebook-convert
EARGS=--base-font-size 10 --margin-left 0 --margin-right 0 --margin-top 0 --margin-bottom 0 --language en --no-default-epub-cover --authors "Paul Wessel"
AARGS=--base-font-size 10 --margin-left 0 --margin-right 0 --margin-top 0 --margin-bottom 0 --language en --authors "Paul Wessel"
%FIGWIDTH=	3.83i
FIGWIDTH=	6i
help::
		@grep '^#!' GNUmakefile | cut -c3-
#!-------------------- MAKE HELP FOR DABOOK 1 --------------------
#!
#!
#!make <target>, where <target> can be:
#!
#!book          : Build PDF for book 1
#!book+         : Build PDF for book 1 with Answer section
#!ebook         : Build EPUB for book 1
#!spotless      : Clean up and remove created files of all types
#!ascii         : Check for non-ASCII characters in the tex files
#!data          : Make the zip file with problem set data
#!

#---------------------------------------------------------------------------
# BOOK 1:
#---------------------------------------------------------------------------
FIG1=	Fig1_3D.csh			Fig1_correlations.csh \
	Fig1_dataclasses.csh 		Fig1_smoothing.csh \
	Fig1_3D_misfit.csh		Fig1_Draper.csh \
	Fig1_AC.csh			Fig1_die_probability.csh \
	Fig1_AD.csh			Fig1_digline.csh \
	Fig1_AL.csh			Fig1_dir1.csh \
	Fig1_dir2.csh 			Fig1_dir3.csh \
	Fig1_dir4.csh 			Fig1_dotproduct.csh \
	Fig1_dotvector.csh 		Fig1_earthfilter.csh \
	Fig1_AM.csh			Fig1_normal_tdist.csh \
	Fig1_Autocorrelation.csh	Fig1_filter1.csh \
	Fig1_CCLag.csh			Fig1_filter2.csh \
	Fig1_filter3.csh 		Fig1_GenLS.csh \
	Fig1_filter4.csh 		Fig1_series.csh \
	Fig1_KS.csh			Fig1_fossil_site.csh \
	Fig1_Kelvin.csh			Fig1_func_uncertainty.csh \
	Fig1_L2_error.csh		Fig1_fundamental.csh \
	Fig1_LMS.csh			Fig1_grav_model.csh \
	Fig1_LMS_bestslope.csh		Fig1_kurtosis.csh \
	Fig1_LMS_geometry.csh		Fig1_leverage.csh \
	Fig1_LMS_regress.csh		Fig1_linefit_x.csh \
	Fig1_LS_breakdown.csh		Fig1_CanadaGold.csh \
	Fig1_LS_pitfalls1.csh		Fig1_lithology.csh \
	Fig1_LS_pitfalls2.csh		Fig1_make_histogram.csh \
	Fig1_Lag.csh			Fig1_MA_misfit.csh	 \
	Fig1_Markov.csh			Fig1_RMA_misfit.csh \
	Fig1_matprod1.csh 		Fig1_F_dist.csh \
	Fig1_Rayleigh_bars.csh		Fig1_mmm.csh \
	Fig1_Rayleigh_one_BW.csh	Fig1_normal_pdf.csh \
	Fig1_Rayleigh_scatter.csh	Fig1_normal_tails.csh \
	Fig1_Rayleigh_two_BW.csh	Fig1_nyquist1.csh \
	Fig1_Run.csh			Fig1_nyquist2.csh \
	Fig1_Venn.csh			Fig1_onecos.csh \
	Fig1_Whitewater.csh		Fig1_outcrop.csh \
	Fig1_acc_prec.csh		Fig1_phase.csh \
	Fig1_aliasing.csh		Fig1_sampl1.csh \
	Fig1_aliasing2.csh		Fig1_sampl2.csh \
	Fig1_astronomy.csh		Fig1_sampl3.csh \
	Fig1_blackbox.csh		Fig1_sampl4.csh \
	Fig1_boxwhisker.csh		Fig1_sampl5.csh \
	Fig1_breakdown.csh		Fig1_sampl6.csh \
	Fig1_chi2_dist.csh		Fig1_sampl7.csh \
	Fig1_choices.csh		Fig1_scatter.csh \
	Fig1_cont_pdf.csh		Fig1_sincos.csh \
	Fig1_contamination.csh		Fig1_skewness.csh \
	Fig1_conv1.csh			Fig1_trunc1.csh \
	Fig1_conv2.csh			Fig1_trunc2.csh \
	Fig1_conv3.csh			Fig1_trunc3.csh \
	Fig1_conv4.csh			Fig1_Fisher.csh \
	Fig1_conv5.csh			Fig1_type1_error.csh \
	Fig1_conv6.csh			Fig1_type2_error.csh \
	Fig1_conv7.csh			Fig1_whitenoise.csh \
	Fig1_conv8.csh			Fig1_y_and_ortho_error.csh \
	Fig1_periodogram.csh		Fig1_binom_dist.csh \
	Fig1_poisson.csh		Fig1_lognormal.csh \
	Fig1_coin.csh			Fig1_dice.csh \
	Fig1_MarkovProblemSet1.csh	Fig1_MarkovProblemSet2.csh \
	Fig1_multregress.csh 		Fig1_crossassoc.csh \
	Fig1_Cover.csh			Fig1_HypothesisChart.csh \
	Fig1_FourierFit.csh		Fig1_ortho.csh \
	Fig1_vonMises.csh		Fig1_GenLSW.csh	\
	Fig1_App_Normal.csh		Fig1_App_Student_t.csh \
	Fig1_App_F.csh			Fig1_App_Chisquare.csh	\
	Fig1_Answer_tires.csh		Fig1_Answer_tapwater.csh \
	Fig1_Answer_holes.csh		Fig1_Answer_twosamples.csh \
	Fig1_Answer_tcorr.csh		Fig1_Answer_linefit.csh \
	Fig1_Answer_heatflow.csh	Fig1_Answer_beststeploc.csh \
	Fig1_Answer_sulfur.csh		Fig1_Answer_conspiracy.csh \
	Fig1_Answer_NSF.csh		Fig1_Answer_Aso.csh \
	Fig1_Answer_brains.csh		Fig1_Answer_magKS.csh \
	Fig1_Answer_permKS.csh		Fig1_Answer_GK2007KS.csh \
	Fig1_Answer_COD.csh		Fig1_Answer_c2407.csh \
	Fig1_Answer_Athy1.csh 		Fig1_Answer_Athy2.csh \
	Fig1_Answer_HawaiiAge.csh	Fig1_Answer_subsidence_a.csh \
	Fig1_Answer_subsidence_c.csh	Fig1_Answer_cavecreek.csh \
	Fig1_Answer_Billings.csh	Fig1_Answer_sspots.csh \
	Fig1_Answer_columbia.csh	Fig1_Answer_HonHil.csh \
	Fig1_Answer_CO2_a.csh		Fig1_Answer_CO2_b.csh \
	Fig1_Answer_noisy_a.csh		Fig1_Answer_noisy_b.csh \
	Fig1_Answer_noisy_c.csh		Fig1_Answer_noisy_dft.csh \
	Fig1_Answer_noisy_dy.csh	Fig1_Answer_vostok_a.csh \
	Fig1_Answer_vostok_b.csh	Fig1_Answer_seismic.csh \
	Fig1_Answer_quakeKS.csh		Fig1_Answer_drops.csh \
	Fig1_Answer_HogNeck.csh		Fig1_Answer_vostok_c.csh \
	Fig1_Answer_gbasin_a.csh	Fig1_Answer_gbasin_b.csh \
	Fig1_Answer_gbasin_c.csh	Fig1_Euler_stamps.csh \
	Fig1_spectratypes.csh		\
	Fig1_taper.csh			Fig1_zeropad.csh \
	Fig1_FilterWidth.csh		Fig1_gfilt_time.csh \
	Fig1_BWfilter.csh		Fig1_Wienerfilter.csh \
	Fig1_MA_filterspike.csh		Fig1_median_filterspike.csh \
	Fig1_filter_steps1d.csh		Fig1_medsearch.csh \
	Fig1_low_high_filter.csh	Fig1_band_filter.csh \
	Fig1_sinc.csh			Fig1_delta.csh \
	Fig1_spike.csh			Fig1_scaletheorem.csh

STMP1= $(FIG1:.csh=.svg)
SVG1= $(addprefix svg/, $(STMP1))
PTMP1= $(FIG1:.csh=.pdf)
PDF1= $(addprefix pdf/, $(PTMP1))
GTMP1= $(FIG1:.csh=.png)
PNG1= $(addprefix png/, $(GTMP1))

TEX1=	DA1_Chap1.tex		DA1_Chap4.tex		DA1_Preface.tex \
	DA1_Chap2.tex		DA1_Chap5.tex		DA1_book.tex \
	DA1_Chap3.tex		DA1_Chap6.tex		DA1_Chap7.tex \
	DA1_Chap8.tex		DA1_Chap9.tex		DA1_cover.tex \
	DA_book.ist		DA1_Version.tex		$(TAB1)

APP1=	DA1_Table_Chisquare.sh	DA1_Table_F.sh		DA1_Table_Student_t.sh \
	DA1_Table_KS.sh		DA1_Table_U.sh		DA1_Table_Spearman.sh  \
	DA1_Table_kappa2.sh	DA1_Table_R2mean.sh	DA1_Table_kappa3.sh \
	DA1_Table_R3mean.sh	DA1_Table_Normal.sh

XTMP1= $(APP1:.sh=.tex)
TAB1= $(addprefix CriticalTables/, $(XTMP1))

DA1_Version.tex:  .FORCE
	echo "\\def \DAversion {1}" > DA1_Version.tex
	echo "\\def \DAday {`date +%d`}" >> DA1_Version.tex
	echo "\\def \DAmonth {`date +%B`}" >> DA1_Version.tex
	echo "\\def \DAyear {`date +%Y`}" >> DA1_Version.tex

.FORCE:

pdf/%.pdf: scripts/%.ps
	gmt psconvert -A0.05i+sm$(FIGWIDTH)+p0.5p -P -Tf scripts/$*.ps -Dpdf

#svg/%.svg: scripts/%.ps
#	gmt psconvert -A0.05i+sm$(FIGWIDTH)+p0.5p+gwhite -P -Ts scripts/$*.ps -Dsvg

svg/%.svg: pdf/%.pdf
	pdf2svg pdf/$*.pdf svg/$*.svg

png/%.png: scripts/%.ps
	gmt psconvert -A0.05i+sm$(FIGWIDTH)+p0.5p+gwhite -E100 -P -Tg scripts/$*.ps -Dpng

scripts/%.ps: scripts/%.csh
	(cd scripts; csh $*.csh; rm -f gmt.conf gmt.history)

CriticalTables/%.tex: CriticalTables/%.sh
	(cd CriticalTables; bash $*.sh; rm -f gmt.history)

pdir:
	mkdir -p pdf

sdir:
	mkdir -p svg

ndir:
	mkdir -p png

book:	book1
book+:	book1+
book1:	DA1_book.pdf
book1+:	DA1_book+.pdf
ebook:	DA1_book.epub

do_svg: sdir $(SVG1)
do_pdf: pdir $(PDF1)
do_table: $(TAB1)

# Make EPUB via XML->XHTML->EPUB
DA1_book.epub:	DA1_book.xhtml
	# Convert to epub3 format
	/Applications/calibre.app/Contents/MacOS/ebook-convert DA1_book.xhtml DA1_book.epub $(EARGS)
	#/Applications/calibre.app/Contents/MacOS/ebook-convert DA1_book_svg.xhtml DA1_book.epub $(EARGS)
	#/Applications/calibre.app/Contents/MacOS/ebook-convert DA1_book_png.xhtml DA1_book_png.azw3 $(AARGS)

DA1_book.xhtml: sdir pdir $(PDF1) $(SVG1) DA1_book.xml
	# Use --noplane1 so MathML uses attributes like boldtype instead of binary Unicode Plane 1 stuff
	# Use --graphicimages to ensure calculation of svg image sizes which are then included in the tags
	latexmlpost --noplane1 --graphicimages -dest=DA1_book.xhtml DA1_book.xml
	#latexmlpost --noplane1 -dest=DA1_book_png.xhtml DA1_book.xml
	# Determine all the PDF figures in the original Latex and make a list of their names without extension
	#echo Fig1_cover > f.lis
	#grep -H PSfig DA1_Chap?.tex | tr ':{}' '   ' | awk '{print $$3}' >> f.lis
	# Find all the x###.svg files just created but sort them.  Since ### varies in width we do it this way:
	# ls x*.png | awk -F. '{print substr ($$1,2)}' | sort -n | awk -F. '{printf "x%s.png\n", $$1}' > x.lis
	# Replace the x###.png image references with svg/<figname>.svg instead
	#paste x.lis f.lis | awk '{printf "s|%s|svg/%s.svg|g\n", $$1, $$2}' > fix.lis
	#sed -f fix.lis DA1_book_png.xhtml > DA1_book.xhtml
	#rm -f x.lis f.lis fix.lis

DA1_book.xml: $(TEX1)
	# Plain conversion of tex to xml - no figures etc are touched.
	latexml --destination=DA1_book.xml DA1_book.tex

DA1_pngbook.xhtml: ndir $(PDF1) $(PNG1) DA1_pngbook.xml
	# Use --noplane1 so MathML uses attributes like boldtype instead of binary Unicode Plane 1 stuff
	latexmlpost --noplane1 --graphicimages --mathimages --verbose -dest=DA1_pngbook.xhtml DA1_pngbook.xml

DA1_pngbook.xml: $(TEX1)
	# Plain conversion of tex to xml - no figures etc are touched.
	latexml --destination=DA1_pngbook.xml DA1_book.tex

DA1.epub: $(TEX1) $(SVG1)
	# Full conversion of tex to epub.
	latexmlc --noplane1 --graphicimages --destination=DA1.epub DA1_book.tex

DA1_book.pdf:	pdir $(PDF1) $(TEX1)
	\rm -f DA1_*.{aux,idx,ilg,ind,log,lof,lot,toc,out,dvi}
	$(PDFLATEX) "\def\mypdfbook{1} \input{DA1_book}"
	$(PDFLATEX) "\def\mypdfbook{1} \input{DA1_book}"
	makeindex -s DA_book.ist DA1_book.idx
	$(PDFLATEX) "\def\mypdfbook{1} \input{DA1_book}"
	$(PDFLATEX) "\def\mypdfbook{1} \input{DA1_book}"
	\rm -f DA1_*.{aux,idx,ilg,ind,log,lof,lot,toc,out,dvi}

DA1_book+.pdf:	pdir $(PDF1) $(TEX1)
	\rm -f DA1_*.{aux,idx,ilg,ind,log,lof,lot,toc,out,dvi}
	$(PDFLATEX) "\def\mypdfbook{1} \def\mypdfanswer{1} \input{DA1_book}"
	$(PDFLATEX) "\def\mypdfbook{1} \def\mypdfanswer{1} \input{DA1_book}"
	makeindex -s DA_book.ist DA1_book.idx
	$(PDFLATEX) "\def\mypdfbook{1} \def\mypdfanswer{1} \input{DA1_book}"
	$(PDFLATEX) "\def\mypdfbook{1} \def\mypdfanswer{1} \input{DA1_book}"
	\rm -f DA1_*.{aux,idx,ilg,ind,log,lof,lot,toc,out,dvi}
	mv DA1_book.pdf DA1_book+.pdf

ascii: $(TEX1)
	gcc checkfornonascii.c -o checkfornonascii
	for file in $(TEX1) ; do\
		echo $$file; \
		checkfornonascii < $$file; \
	done
	rm -f checkfornonascii

data:
	zip -r -9 -l -q DA1-data.zip problems/*.txt
	chmod og+r DA1-data.zip
	scp DA1-data.zip imina:/export/imina2/httpd/htdocs/pwessel/DA

clean_table:
	rm -r CriticalTables/*.tex

clean:
	rm -f DA?_*.{aux,idx,ilg,ind,log,lof,lot,toc,out,dvi} DA1_Version.tex x*.png x*.svg

spotless:	clean clean_table
	rm -rf pdf svg .DS_Store
	rm -f scripts/*.ps scripts/gmt.conf scripts/gmt.history gmt.history *.pdf
	rm -f DA?_book.xml DA?_book.xhtml DA?_book.epub LaTeXML.* ltx-book.css
