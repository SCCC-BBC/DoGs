
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error

if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)>1) {

  input.fastq.files.dir=args[1]
  gene.model.file=args[2]
  genome.index=args[3]
}

#cat(input.bamfile.dir,"\t",output.bedfile.dir,"\n")

library(ChipSeq)
library(ThreeUTR)

ThreeUTR:::testAlignment(input.fastq.files.dir,gene.model.file,genome.index)

