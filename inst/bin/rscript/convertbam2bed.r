
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error

if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)>1) {

  input.bamfile.dir=args[1]
  output.bedfile.dir=args[2]
}

cat(input.bamfile.dir,"\t",output.bedfile.dir,"\n")

library(ThreeUTR)

res <- convertbam2bed(input.bamfile.dir,output.bedfile.dir)
