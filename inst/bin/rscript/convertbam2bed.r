
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error

if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)>1) {

  input.bamfile.dir=args[1]
  annotation.bed.file=args[2]
  ld=args[3]
  rd=args[4]
  output.count.file.dir=args[5]
}

#cat(input.bamfile.dir,"\t",output.bedfile.dir,"\n")

library(ChipSeq)
library(ThreeUTR)

#res1 <- convertbam2bed(input.bamfile.dir,output.bedfile.dir)

res <- getcounts(input.bamfile.dir,annotation.bed.file,ld,rd,output.count.file.dir)
