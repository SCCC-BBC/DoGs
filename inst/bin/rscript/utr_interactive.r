#!/usr/bin/Rscript

# Usage:

# Rscript ~/R/lib64/R/library/ThreeUTR/bin/rscript/utr_interactive.r

R_lib = .libPaths()[1]

get_os <- function()
{
  sysinf <- Sys.info()
  if (!is.null(sysinf))
  {
    os <- sysinf["sysname"]
    if (os == "Darwin")
      os <- "osx"
  } else
  {
    ## mystery machine
    os <- .Platform$OS.type
    if (grepl("^darwin", R.version$os))
      os <- "osx"
    if (grepl("linux-gnu", R.version$os))
      os <- "linux"
  }
  tolower(os)
}

os <- get_os()

cat("Your operating system is: ", os, "\n")

cat("Choose analysis: \n")
cat("\tAvaliable analysis: \t1. QC \t2. Counts \t3. DE_analysis \t4. All\n")

input <- file("stdin", "r")
row <- readLines(input, n = 1)

if (row == 1)
{
  choose.type <- "QC"
}

if (row == 2)
{
  choose.type <- "Counts"
}

if (row == 3)
{
  choose.type <- "DE_analysis"
}

if (row == 4)
{
  choose.type <- "All"
}

bamQC <- function()
{
  cat("You choose to perform QC on the bam files, please define the following setting parameters: \n",
      "input.bam.files.dir (ex: /scratch/projects/exempt/tr/azhang/for_bioinfo_core/3_end_seq)\n",
      "input.ref.gene.bed.file (ex: /projects/ctsi/bbc/aimin/annotation/3UTR_GFF2_2.bed)\n",
      "output.dir (ex:BAMQC)\n")

  input <- file("stdin", "r")
  count.file.dir <- readLines(input, n = 3)

  input.bam.file.dir <- count.file.dir[1]
  input.ref.gene.bed.file <- count.file.dir[2]
  output.dir <- count.file.dir[3]

  library(ThreeUTR)

  cmd1 = "bsub -P bbc -J \"QCBam\" -o %J.QCBam.log -e %J.QCBam.err -W 72:00 -n 8 -q general -u aimin.yan@med.miami.edu"

  cmd2 = "R -e"


  cmd3 = "'library(ChipSeq,ThreeUTR);"
  cmd4="ThreeUTR:::useInferExperiment("

  cmd5 = paste0(cmd3,cmd4)
  cmd6 = paste(paste0(cmd5,input.bam.file.dir),input.ref.gene.bed.file,output.dir,sep=",")
  cmd7=  paste0(cmd6,")'")

  cmd8 = paste(cmd2,cmd7,sep=" ")

  print(cmd8)

  system(paste0(cmd1, " ", cmd8),intern= TRUE)

  cat("Finished qcBAM\n")

}

analysisAll <- function(R_lib)
{
  cat("Do you want to perform peak calling, annotation, and coverage visualization?\n")

  input <- file("stdin", "r")
  row <- readLines(input, n = 1)

  print(row)

  if (row == "Yes")
  {



    cat("Do you have input bam file for control ?\n")

    input <- file("stdin", "r")
    row <- readLines(input, n = 1)

    if (row == "No")
    {

      cat("please define the input Bam file directory:\n")

      input <- file("stdin", "r")
      input.file.dir <- readLines(input, n = 1)

      # input.file.dir=row

      cat("please define the output file directory:\n")

      input <- file("stdin", "r")
      output.file.dir <- readLines(input, n = 1)

      # out.file.dir=row

      cat("please define genome name:\n")

      input <- file("stdin", "r")
      genome <- readLines(input, n = 1)

      cmd1 = "bsub -P bbc -J \"RunR\" -o %J.RunR.log -e %J.RunR.err -W 72:00 -n 8 -q general -u aimin.yan@med.miami.edu"
      cmd2 = paste0("Rscript ", R_lib, "/ChipSeq/bin/Run_Chip_Seq.r ",
                    input.file.dir, " ", output.file.dir, " ", genome)

      system(paste0(cmd1, " ", cmd2))

      # cmd2=paste0()

      # system(cmd2)

      cat("Finished peak calling, annotation, and coverage visualizatio...\n")

    } else if (row == "Yes")
    {

      cat("please define the sample information file:\n")

      input <- file("stdin", "r")
      sample.info.file <- readLines(input, n = 1)

      # input.file.dir=row

      cat("please define the Bam files information file:\n")

      input <- file("stdin", "r")
      bam.info.file <- readLines(input, n = 1)

      # out.file.dir=row

      cat("please define genome name:\n")

      input <- file("stdin", "r")
      genome <- readLines(input, n = 1)

      cat("Which peakcaller you want to use, please choose: macs14 or macs2 \n")

      input <- file("stdin", "r")
      peakcaller <- readLines(input, n = 1)

      cat("The peakcaller you choose is :", peakcaller,
          "please define p value threshold for peak calling: \n")

      input <- file("stdin", "r")
      peakPvalue <- readLines(input, n = 1)

      cat("Please define the name of output directory for peaks: \n")

      input <- file("stdin", "r")
      peak.out.dir <- readLines(input, n = 1)

      peak.out.dir <- paste0(peak.out.dir, "_", genome,
                             "_", peakcaller, "_", peakPvalue)

      cmd1 = "bsub -P bbc -J \"InputCall\" -o %J.InputCall.log -e %J.InputCall.err -W 72:00 -n 8 -q general -u aimin.yan@med.miami.edu"
      cmd2 = paste("Rscript", file.path(R_lib, "ChipSeq/bin/UseInputCall.r"),
                   sample.info.file, bam.info.file, genome, peak.out.dir,
                   peakcaller, peakPvalue, sep = " ")

      system(paste0(cmd1, " ", cmd2))

    }

  } else if (row == "No")
  {

    cat("Do you want to perform peak merge, overlap, produing Venn diagram?\n")

    input <- file("stdin", "r")
    row <- readLines(input, n = 1)

    if (row == "Yes")
    {

      cat("please defne the input file for sample information:\n")

      input <- file("stdin", "r")
      input.file.sample <- readLines(input, n = 1)

      cat("Finished to get sample information\n")


      cat("please defne the input file directory for bed files:\n")

      input <- file("stdin", "r")
      input.file.dir <- readLines(input, n = 1)

      cat("please defne the input file pattern:\n")
      input <- file("stdin", "r")
      input.file.pattern <- readLines(input, n = 1)

      cat("please defne the output file directory:\n")
      input <- file("stdin", "r")
      output.file.dir <- readLines(input, n = 1)

      R_lib = .libPaths()[1]

      cmd1 = "bsub -P bbc -J \"RunR\" -o %J.RunR.log -e %J.RunR.err -W 72:00 -n 8 -q general -u aimin.yan@med.miami.edu"
      cmd2 = paste0("Rscript ", R_lib, "/ChipSeq/bin/Run_Merge_peak.r ",
                    input.file.dir, " ", output.file.dir, " ", input.file.pattern,
                    " ", input.file.sample)

      system(paste0(cmd1, " ", cmd2))

      cat("Finished peak merge, overlap, produing Venn diagram?\n")
    } else if (row == "No")
    {

      cat("Do you want to perform  Bam files sorting, index and Visualization?\n")

      input <- file("stdin", "r")
      row <- readLines(input, n = 1)

      if (row == "Yes")
      {

        cat("please defne the input file directory for Bam files:\n")

        input <- file("stdin", "r")
        input.file.dir <- readLines(input, n = 1)

        cat("Finished to get bam files\n")

        cat("please defne the out file directory:\n")

        input <- file("stdin", "r")
        output.file.dir <- readLines(input, n = 1)

        cat("please defne genome:(example: Hs) \n")


        input <- file("stdin", "r")
        genomeID <- readLines(input, n = 1)

        cmd1 = "bsub -P bbc -J \"BamR\" -o %J.BamR.log -e %J.BamR.err -W 72:00 -n 8 -q general -u aimin.yan@med.miami.edu"

        cmd2 = paste0("Rscript ", R_lib, "/ChipSeq/bin/Process_Bam.r ",
                      input.file.dir, " ", output.file.dir, " ",
                      genomeID)

        system(paste0(cmd1, " ", cmd2))

        cat("Finished Bam files sorting, index and Visualization ?\n")

      } else
      {
        quit()
      }
    }
  }
}

switch(choose.type, QC = {
  bamQC()
}, peakcalling = {
}, annotation = {

}, visualization = {
  analysisVisualization(R_lib)
})
