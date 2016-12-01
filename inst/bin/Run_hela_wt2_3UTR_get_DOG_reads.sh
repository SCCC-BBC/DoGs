#For each gene, find the reads that fall in the 4500bp region of downstream of each gene
bedtools window -a /media/H_driver/2016/Ramin_azhang/Annotation/hg19_gene.bed -b "/media/H_driver/2016/Ramin_azhang/for_bioinfo_core/RNA_seq/Results4NewData/""hela_wt2".rm.exon.intron.hg19.bed -l 0 -r 4500 -sw   > "/media/H_driver/2016/Ramin_azhang/for_bioinfo_core/RNA_seq/Results4NewData/""hela_wt2".gene.downstream.a.as.gene.strand.based.hg19.bed

#For each gene, find the reads that fall in the 4500bp region of upstream of each gene
bedtools window -a /media/H_driver/2016/Ramin_azhang/Annotation/hg19_gene.bed -b "/media/H_driver/2016/Ramin_azhang/for_bioinfo_core/RNA_seq/Results4NewData/""hela_wt2".rm.exon.intron.hg19.bed -l 4500 -r 0 -sw   > "/media/H_driver/2016/Ramin_azhang/for_bioinfo_core/RNA_seq/Results4NewData/""hela_wt2".gene.upstream.a.as.gene.strand.based.hg19.bed

#For each gene, find the reads that fall in the 4500bp region of upstream and downstream of each gene
bedtools window -l 0 -r 4500 -a "/media/H_driver/2016/Ramin_azhang/for_bioinfo_core/RNA_seq/Results4NewData/""hela_wt2".rm.exon.intron.hg19.bed -b /media/H_driver/2016/Ramin_azhang/Annotation/hg19_gene.bed -sw > "/media/H_driver/2016/Ramin_azhang/for_bioinfo_core/RNA_seq/Results4NewData/""hela_wt2".gene.upstream.and.downstream.hg19.strand.based.bed

