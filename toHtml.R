#! /usr/bin/Rscript
library(conduit)

### produce HTML output

## load document to HTML transformation pipeline
toHtml <- loadPipeline(name = "toHtml",
                       ref = "transform/toHtml/pipeline.xml")

## execute document to HTML pipeline
toHtmlRes1 <- runPipeline(toHtml, targetDirectory = tempdir())

## export pipeline result
#tarball1 <- export(toHtmlRes1)

## copy final report.html to working directory
file.copy(from = toHtmlRes1$outputList$knitToHtml$report$ref, to = ".",
          overwrite = TRUE)
## copy toHtmlGraph.png to working directory
file.copy(from = toHtmlRes1$outputList$knitToHtml$toHtmlGraph$ref,
          to = ".", overwrite = TRUE)
## copy toPdfGraph.png to current directory
file.copy(from = toHtmlRes1$outputList$knitToHtml$toPdfGraph$ref,
          to = ".", overwrite = TRUE)
