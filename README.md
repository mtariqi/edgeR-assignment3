# Assignment 3 – Differential Expression of Small RNAs with edgeR

Analysis of the `mobData` dataset (from the Bioconductor package **baySeq**): counts for
3,000 small-RNA loci from an *Arabidopsis* grafting experiment, 6 libraries in 3 groups.

| Group | Samples        | Description                                      |
|-------|----------------|--------------------------------------------------|
| MM    | SL236, SL260   | triple-mutant shoot grafted onto triple-mutant root |
| WM    | SL237, SL238   | wild-type shoot grafted onto triple-mutant root  |
| WW    | SL239, SL240   | wild-type shoot grafted onto wild-type root      |

Adapted from the Stanford BIOS221 RNA-seq lab
(<https://web.stanford.edu/class/bios221/labs/rnaseq/lab_4_rnaseq.html>) and
*Modern Statistics for Modern Biology* (Holmes & Huber).

## Workflow
1. Build a `DGEList`, filter loci (CPM > 100 in ≥ 2 samples), and apply TMM normalization
2. MDS plot (BCV distance)
3. Dispersion: classic qCML (common + tagwise) and GLM (common, trended, tagwise), with BCV plots
4. DE testing: exact test, GLM likelihood-ratio test, and quasi-likelihood F-test
5. Homework answers (Q1–Q5) are generated inside the report with inline R code

## Repository layout
```
edgeR_assignment3.Rmd   # full analysis + answers -> knits to PDF
data/mobData.RData      # input counts
output/                 # Q5 plot (PNG) + DE result tables (CSV), created on knit
```

## How to reproduce
Requirements: R ≥ 4.2, plus the `edgeR`, `baySeq`, and `rmarkdown` packages, and a LaTeX
installation for PDF output (`tinytex::install_tinytex()`).

```r
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("edgeR", "baySeq"))
install.packages(c("rmarkdown", "tinytex")); tinytex::install_tinytex()
rmarkdown::render("edgeR_assignment3.Rmd")
```
