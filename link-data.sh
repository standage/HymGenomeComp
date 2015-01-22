#!/usr/bin/env bash

DATA=/DATA/GROUP/prj/Pd/ILOCI/NCBI-Input
AGN=/home/standage/Software/AEGeAn
BIN=$AGN/bin

# Symlinks to genomic sequences
ln -s $DATA/Ad/ado_ref_Apis_dorsata_1.3_chrUn.fa Ador.gdna.fa
ln -s $DATA/Af/afl_ref_Aflo_1.0_chrUn.fa         Aflo.gdna.fa
ln -s $DATA/Am/Amel.gdna.fa                      Amel.gdna.fa
ln -s $DATA/Bi/bim_ref_BIMP_2.0_chrUn.fa         Bimp.gdna.fa
ln -s $DATA/Bt/Bter.gdna.fa                      Bter.gdna.fa
ln -s $DATA/Dm/Dmel.gdna.fa                      Dmel.gdna.fa
ln -s $DATA/Hs/HSgdna                            Hsal.gdna.fa
ln -s $DATA/Mr/mro_ref_MROT_1.0_chrUn.fa         Mrot.gdna.fa
ln -s $DATA/Nv/Nvit.gdna.fa                      Nvit.gdna.fa
ln -s $DATA/Si/SIgdna                            Sinv.gdna.fa
ln -s $DATA/Tc/Tcas.gdna.fa                      Tcas.gdna.fa

# Symlinks to annotations
ln -s $DATA/Ad/ref_Apis_dorsata_1.3_top_level.gff3 Ador.gff3
ln -s $DATA/Af/ref_Aflo_1.0_top_level.gff3         Aflo.gff3
ln -s $DATA/Am/ref_Amel_4.5_top_level.gff3         Amel.gff3
ln -s $DATA/Bi/ref_BIMP_2.0_top_level.gff3         Bimp.gff3
ln -s $DATA/Bt/ref_Bter_1.0_top_level.gff3         Bter.gff3
ln -s $DATA/Dm/Dmel.gff3                           Dmel.gff3
ln -s $DATA/Hs/HSgdna.gff3                         Hsal.gff3
ln -s $DATA/Mr/ref_MROT_1.0_top_level.gff3         Mrot.gff3
ln -s $DATA/Nv/ref_Nvit_2.0_top_level.gff3         Nvit.gff3
ln -s $DATA/Si/Sinv.toplevel.gff3                  Sinv.gff3
ln -s $DATA/Tc/ref_Primary_Assembly_top_level.gff3 Tcas.gff3

# Symlinks to Pdom data
ln -s /DATA/GROUP/prj/Pd/ASSEMBLY/pdom-scaffolds-unmasked-r1.2.fa Pdom.gdna.fa
./fix-regions.py Pdom.gdna.fa < /DATA/GROUP/prj/Pd/ANNOTATION/r1.2/pdom-annot-r1.2.gff3 > Pdom.gff3
