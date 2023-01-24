# In-silico-PCR-for-Kpn-MLVA8Plus

This is the repository for creating the _in-silico_ PCR, as described in the original paper "Improvement and Validation of а Multi-Locus Variable Number of Tandem Repeats Analysis for _Klebsiella pneumoniae_, _Кlebsiella variicola_, and _Klebsiella quasipneumoniae_".

This script uses the Perl script from egonozer/in_silico_pcr (https://github.com/egonozer/in_silico_pcr.git)

It is used to create a tsv file with fragment size for each VNTR locus that MLVA8+ primers generate against _K.pneumoniae_, _K.variicola_, and _K.quasipneumoniae_.

Installation:
#git clone https://github.com/maddne/In-silico-PCR-for-Kpn-MLVA8Plus.git#
'''cd In-silico-PCR-for-Kpn-MLVA8Plus'''

Instructions:
1. Copy and paste your genomes in folder kpn_genomes.
2. Rename the genome files to end with .fna extension or change the extension in the script kpnmlva.sh
3. In terminal type '''bash kpnmlva.sh'''
4. Results will be in MLVA_Kpn_All.tsv

Currently, there are 4 genomes in the folder to test it out.
