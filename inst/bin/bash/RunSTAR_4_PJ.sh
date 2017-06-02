#STAR --runMode genomeGenerate --genomeDir /media/aiminyan/DATA/STAR_mm10/ --genomeFastaFiles /home/aiminyan/Mus_musculus/UCSC/mm10/Sequence/WholeGenomeFasta/genome.fa --runThreadN 16
#STAR --runMode genomeGenerate --genomeDir /media/DATA/hg38/Homo_sapiens/UCSC/hg38/Sequence/STARIndex --genomeFastaFiles /media/DATA/hg38/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa --runThreadN 16
#/nethome/axy148/Homo_sapiens/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa
STAR --genomeDir /media/aiminyan/DATA/STAR_mm10/ --readFilesIn /media/H_driver/PJ/Undetermined_S0_L001_R1_001.fastq.gz /media/H_driver/PJ/Undetermined_S0_L001_R2_001.fastq.gz --runThreadN 16 --outSAMtype BAM SortedByCoordinate