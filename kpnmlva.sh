#!/usr/bin/bash env

ls -d kpn_genomes/*.fna > genomes.txt
cat genomes.txt | parallel -j 64 perl in_silico_PCR.pl -s {.}.fna -p ./K.p_mlva_primers/primerstable.txt -l 1000 -m -i -r '>' {.}.tsv

for i in kpn_genomes/*.tsv; do
    cat ${i%.*}.tsv | awk '{print $1,$4}' | sed 's/_amp_1//' > "${i%.*}"_tr.tsv

    awk '
    { 
        for (i=1; i<=NF; i++)  {
            a[NR,i] = $i
        }
    }
    NF>p { p = NF }
    END {    
        for(j=1; j<=p; j++) {
            str=a[1,j]
            for(i=2; i<=NR; i++){
                str=str"\t"a[i,j];
            }
            print str
        }
    }' "${i%.*}"_tr.tsv > "${i%.*}"_tr1.tsv
    k=$(echo  "${i%.*}" | cut -d "/" -f2)
    awk -v sample=${k%.*} 'BEGIN{FS=OFS="\t"} {$1="Length"}{$1=sample}1' "${i%.*}"_tr1.tsv > "${i%.*}"_tr2.tsv
    awk 'BEGIN{FS=OFS="\t"} {if (NR!=1) {print}}' "${i%.*}"_tr2.tsv > "${i%.*}"_tr3.tsv
    awk 'BEGIN{FS=OFS="\t"} {for (i=1; i<=NF; i++) if ($i ~ /^ *$/) $i="n/a"} 1' "${i%.*}"_tr3.tsv > "${i%.*}"_tr4.tsv
done

cat kpn_genomes/*_tr4.tsv >> kpn_genomes/MLVA_Kpn_All1.tsv

awk 'BEGIN{
print "Sample VNTR10 VNTR27 VNTR45 VNTR51 VNTR52 VNTR53 VNTR58 VNTR60"
}1' kpn_genomes/MLVA_Kpn_All1.tsv > kpn_genomes/MLVA_Kpn_All2.tsv

awk -v OFS='\t' 'NR == 1 { $1 = $1 } 1' kpn_genomes/MLVA_Kpn_All2.tsv > MLVA_Kpn_All.tsv

rm -rf kpn_genomes/*.tsv
rm -rf genomes.txt