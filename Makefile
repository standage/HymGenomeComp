DATA=/DATA/GROUP/prj/Pd/ILOCI/NCBI-Input
AGN=/home/standage/Software/AEGeAn
BIN=$(AGN)/bin
TIDY=$(AGN)/data/scripts/tidy

SHELL := /usr/bin/bash

.PRECIOUS:		%.iloci.gff3

all:			Ador.iloci.fa Aflo.iloci.fa Amel.iloci.fa Bimp.iloci.fa \
			Bter.iloci.fa Dmel.iloci.fa Hsal.iloci.fa Mrot.iloci.fa \
			Nvit.iloci.fa Pdom.iloci.fa Sinv.iloci.fa Tcas.iloci.fa
			cat *.tidy.gff3 | $(AGN)/data/scripts/check-gff3

clean:			
			rm -f ????.gff3 *.gdna.fa *.log

cleanall:		clean
			rm -f *.iloci.gff3 *.iloci.fa

%.tidy.gff3:		%.gff3
			$(TIDY) < $< 2> $*.tidy.log \
			    | grep -v $$'\tmatch\t' \
			    | grep -v $$'\tcDNA_match\t' \
                            | grep -v NC_001566.1 | grep -v NC_014672.1 \
			    | grep -v '##species' \
                            | gt gff3 -sort -tidy -retainids > $@ 2> $@.log

%.iloci.gff3:		%.tidy.gff3
			$(BIN)/locuspocus --idformat='$*Ilocus%05lu' --verbose \
			    --delta=500 $< > $@ 2> $@.log

%.iloci.fa:		%.iloci.gff3 %.gdna.fa
			perl -ne 's/gi\|\d+\|(ref|gb)\|([^\|]+)\S+/$$2/; print' \
			    < $*.gdna.fa \
			    > $*.gdna.clean-defline.fa
			$(BIN)/xtractore --type=locus \
			    $< $*.gdna.clean-defline.fa > $@
			rm $*.gdna.clean-defline.fa
