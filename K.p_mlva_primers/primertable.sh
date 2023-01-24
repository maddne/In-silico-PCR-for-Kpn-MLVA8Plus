#!/usr/bin/bash env

for i in {2..32}; do
    rem=$(($i % 2))
    if [ "$rem" -ne "1" ]; then
        #echo "$i"
        for n in $(cat ~/tools/in_silico_pcr/K.p_mlva_primers/*.fasta | sed 's/'$'\r''//' | sed -n -e "$i"p); do
            echo $n >> ~/tools/in_silico_pcr/K.p_mlva_primers/primers.txt
        done
    fi
done

cat ~/tools/in_silico_pcr/K.p_mlva_primers/primers.txt | paste -sd '\t\n' > ~/tools/in_silico_pcr/K.p_mlva_primers/primers1.txt
parallel --link echo {1} {2} :::: ~/tools/in_silico_pcr/K.p_mlva_primers/primers1.txt ::: VNTR10 VNTR27 VNTR45 VNTR51 VNTR52 VNTR53 VNTR58 VNTR60 > ~/tools/in_silico_pcr/K.p_mlva_primers/primerstable.txt

cat ~/tools/in_silico_pcr/K.p_mlva_primers/primerstable.txt | sed 's/ /\t/' | sed 's/ /\t/' > primerstable.txt

rm -rf ~/tools/in_silico_pcr/K.p_mlva_primers/primerstable.txt
rm -rf ~/tools/in_silico_pcr/K.p_mlva_primers/primers.txt
rm -rf ~/tools/in_silico_pcr/K.p_mlva_primers/primers1.txt