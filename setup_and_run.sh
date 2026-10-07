#!/usr/bin/env bash
# Usage (from inside the edgeR-assignment3 folder):
#   bash setup_and_run.sh          # install everything + build PDF
#   bash setup_and_run.sh --run    # only rebuild the PDF (after first setup)
set -euo pipefail

if [[ "${1:-}" != "--run" ]]; then
  echo "== 1. System packages, R from CRAN, pandoc, LaTeX =="
  sudo apt update
  sudo apt install -y --no-install-recommends software-properties-common dirmngr wget
  wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
    | sudo tee /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc > /dev/null
  sudo add-apt-repository -y "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
  sudo apt update
  sudo apt install -y r-base r-base-dev pandoc \
    libcurl4-openssl-dev libssl-dev libxml2-dev \
    texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended

  echo "== 2. R packages (into your personal library) =="
  Rscript -e '
    lib <- Sys.getenv("R_LIBS_USER"); dir.create(lib, recursive = TRUE, showWarnings = FALSE)
    .libPaths(c(lib, .libPaths()))
    options(repos = c(CRAN = "https://cloud.r-project.org"))
    if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager", lib = lib)
    install.packages(c("rmarkdown", "knitr"), lib = lib)
    BiocManager::install(c("edgeR", "baySeq"), lib = lib, ask = FALSE, update = FALSE)
  '
fi

echo "== 3. R version check =="
Rscript -e 'cat(R.version.string, "\n"); stopifnot(getRversion() >= "4.2.0")'

echo "== 4. Knit the report =="
Rscript -e 'rmarkdown::render("edgeR_assignment3.Rmd", output_format = "pdf_document")'

echo "Done -> edgeR_assignment3.pdf  (plot + CSV tables in output/)"
