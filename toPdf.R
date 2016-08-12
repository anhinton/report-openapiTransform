#! /usr/bin/Rscript
library(conduit)

### produce HTML and PDF output

## load document to PDF transformation pipeline
toPdf <- loadPipeline(name = "toPdf",
                       ref = "transform/toPdf/pipeline.xml")

## execute document to HTML pipeline
toPdfRes1 <- runPipeline(toPdf, targetDirectory = tempdir())

## export pipeline result
#tarball1 <- export(toPdfRes1)

## copy final report.pdf to working directory
file.copy(from = toPdfRes1$outputList$latexToPdf$report$ref, to = ".",
          overwrite = TRUE)
