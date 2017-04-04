#!/usr/bin/Rscript

#Usage:

#Rscript  Rscript ~/3UTR-Seq/inst/bin/GetCountUseBash.r

R_lib=.libPaths()[1]

cat("Do you want to get count?\n")

input<-file('stdin', 'r')
row <- readLines(input, n=1)

print(row)

if(row=="Yes") {

  cat("Do you have input bam file for control ?\n")

  input<-file('stdin', 'r')
  row <- readLines(input, n=1)

  if(row == "No"){

    cat("please define the input Bam file directory:\n")

    input<-file('stdin', 'r')
    input.file.dir <- readLines(input, n=1)

    #input.file.dir=row

    cat("please define the output file directory:\n")

    input<-file('stdin', 'r')
    output.file.dir <- readLines(input, n=1)

    #out.file.dir=row

    cat("please define genome name:\n")

    input<-file('stdin', 'r')
    genome <- readLines(input, n=1)

    cmd1="bsub -P bbc -J \"DogFT\" -o %J.DogFT.log -e %J.DogFT.err -W 72:00 -n 8 -q general -u aimin.yan@med.miami.edu"

    cmd2=paste0("sh ",R_lib,
                "/3UTR-Seq/bin/Run_hela_wt2_3UTR_get_read_counts_4_DoGs_only_general.sh",input.file.dir," ",output.file.dir," ",genome)

    system(paste0(cmd1," ",cmd2))

    #    cmd2=paste0()

    #    system(cmd2)

    cat("Finished peak calling, annotation, and coverage visualizatio...\n")

  }else if (row == "Yes"){

    cat("please define the sample information file:\n")

    input<-file('stdin', 'r')
    sample.info.file <- readLines(input, n=1)

    #input.file.dir=row

    cat("please define the Bam files information file:\n")

    input<-file('stdin', 'r')
    bam.info.file <- readLines(input, n=1)

    #out.file.dir=row

    cat("please define genome name:\n")

    input<-file('stdin', 'r')
    genome <- readLines(input, n=1)

    cmd1="bsub -P bbc -J \"InputCall\" -o %J.InputCall.log -e %J.InputCall.err -W 72:00 -n 8 -q general -u aimin.yan@med.miami.edu"
    cmd2=paste0("Rscript ",R_lib,"/ChipSeq/bin/UseInputCall.r ",sample.info.file," ",bam.info.file," ",genome)

    system(paste0(cmd1," ",cmd2))

  }

}else if( row =="No")
{

  cat("Do you want to perform peak merge, overlap, produing Venn diagram?\n")

  input<-file('stdin', 'r')
  row <- readLines(input, n=1)

  if(row=="Yes") {

    cat("please defne the input file for sample information:\n")

    input<-file('stdin', 'r')
    input.file.sample <- readLines(input, n=1)

    cat("Finished to get sample information\n")


    cat("please defne the input file directory for bed files:\n")

    input<-file('stdin', 'r')
    input.file.dir <- readLines(input, n=1)

    cat("please defne the input file pattern:\n")
    input<-file('stdin', 'r')
    input.file.pattern <- readLines(input, n=1)

    cat("please defne the output file directory:\n")
    input<-file('stdin', 'r')
    output.file.dir <- readLines(input, n=1)

    R_lib=.libPaths()[1]

    cmd1="bsub -P bbc -J \"RunR\" -o %J.RunR.log -e %J.RunR.err -W 72:00 -n 8 -q general -u aimin.yan@med.miami.edu"
    cmd2=paste0("Rscript ",R_lib,"/ChipSeq/bin/Run_Merge_peak.r ",input.file.dir," ",output.file.dir," ",
                input.file.pattern," ",input.file.sample)

    system(paste0(cmd1," ",cmd2))

    cat("Finished peak merge, overlap, produing Venn diagram?\n")
  }else if(row == "No")
  {

    cat("Do you want to perform  Bam files sorting, index and Visualization?\n")

    input<-file('stdin', 'r')
    row <- readLines(input, n=1)

    if(row=="Yes") {

      cat("please defne the input file directory for Bam files:\n")

      input<-file('stdin', 'r')
      input.file.dir <- readLines(input, n=1)

      cat("Finished to get bam files\n")

      cat("please defne the out file directory:\n")

      input<-file('stdin', 'r')
      output.file.dir <- readLines(input, n=1)

      cat("please defne genome:(example: Hs) \n")


      input<-file('stdin', 'r')
      genomeID <- readLines(input, n=1)

      cmd1="bsub -P bbc -J \"BamR\" -o %J.BamR.log -e %J.BamR.err -W 72:00 -n 8 -q general -u aimin.yan@med.miami.edu"

      cmd2=paste0("Rscript ",R_lib,"/ChipSeq/bin/Process_Bam.r ",input.file.dir," ",output.file.dir," ",
                  genomeID)

      system(paste0(cmd1," ",cmd2))

      cat("Finished Bam files sorting, index and Visualization ?\n")

    }else{quit()}
  }
}
