% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/UTR.R
\name{removeReadsOnExonIntron}
\alias{removeReadsOnExonIntron}
\title{bedtools intersect -v -a 'Results/''Aligned'.bed -b /media/H_driver/2016/Ramin_azhang/Annotation/exons.bed /media/H_driver/2016/Ramin_azhang/Annotation/intron.bed
R -e 'library(ChipSeq);library(ThreeUTR);ThreeUTR:::removeReadsOnExonIntron("/scratch/projects/bbc/aiminy_project/DoGs/BED2","/projects/ctsi/bbc/aimin/annotation/","/scratch/projects/bbc/aiminy_project/DoGs/BedRmExonIntron")'}
\usage{
removeReadsOnExonIntron(input.bed.file.dir, annotation.bed.file.dir,
  output.bed.file.dir)
}
\description{
R -e 'library(ChipSeq);library(ThreeUTR);ThreeUTR:::removeReadsOnExonIntron("/scratch/projects/bbc/aiminy_project/DoGs/BedFileFromBam","/projects/ctsi/bbc/aimin/annotation/","/scratch/projects/bbc/aiminy_project/DoGs/BedRmExonIntron")'
}
