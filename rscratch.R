library(conduit)
library(gridGraphviz)

## TO PDF ####

## toPdf <- loadPipeline(name = "toPdf",
##                        ref = "transform/toPdf/pipeline.xml")
## nodes <- sapply(getComponents(toPdf), getName)
## pipes <- getPipes(toPdf)
## edgeList <- lapply(
##     nodes,
##     function(start, pipes) {
##         edges = character()
##         for (i in seq_along(pipes)) {
##             if (startComponent(pipes[[i]]) == start)
##                 edges <- c(edges, endComponent(pipes[[i]]))
##         }
##         edges
##     }, pipes)
## names(edgeList) <- nodes

nodes <- structure(
    c("xinclude", "substituteEntities", "convertToRhtml", 
      "knitToHtml", "latexChars", "latexEntities",
      "commentCode", "convertToRtex", "knitToLatex", "latexToPdf",
      "report.xml", "report.html", "report.pdf"),
    .Names = c("xinclude", "substituteEntities",
               "convertToRhtml", "knitToHtml", "latexChars",
               "latexEntities", "commentCode", "convertToRtex",
               "knitToLatex", "latexToPdf",
               "report.xml", "report.html", "report.pdf"))
edgeList <- structure(
    list(xinclude = c("substituteEntities", "latexChars"),
         substituteEntities = "convertToRhtml",
         convertToRhtml = "knitToHtml",
         knitToHtml = "report.html",
         latexChars = "latexEntities", latexEntities = "commentCode",
         commentCode = "convertToRtex", convertToRtex = "knitToLatex",
         knitToLatex = c("latexToPdf", "latexToPdf"),
         latexToPdf = "report.pdf",
         `report.xml` = "xinclude",
         `report.html` = character(0),
         `report.pdf` = character(0)),
    .Names = c("xinclude", "substituteEntities", "convertToRhtml",
               "knitToHtml", "latexChars", "latexEntities", "commentCode",
               "convertToRtex", "knitToLatex", "latexToPdf",
               "report.xml", "report.html", "report.pdf"))
toPdfGraph <- new("graphNEL", nodes = nodes, edgeL = edgeList,
                   edgemode = "directed")
Ragraph <- agopenTrue(
    graph = toPdfGraph, name = "",
    attrs = list(node = list(shape = "ellipse")),
    nodeAttrs = list(shape = c("latexChars" = "hexagon",
                               "latexEntities" = "hexagon",
                               "commentCode" = "hexagon",
                               "convertToRtex" = "hexagon",
                               "knitToLatex" = "hexagon",
                               "latexToPdf" = "hexagon",
                               "report.xml" = "polygon",
                               "report.html" = "polygon",
                               "report.pdf" = "polygon"
                               )))
png("toPdfGraph.png", width = graphWidth(Ragraph) * 96,
     height = graphHeight(Ragraph) * 96)
grid.graph(Ragraph, newpage = TRUE)
dev.off()

## TOHTML ####

## toHtml <- loadPipeline(name = "toHtml",
##                        ref = "transform/toHtml/pipeline.xml")
## nodes <- sapply(getComponents(toHtml), getName)
## pipes <- getPipes(toHtml)
## edgeList <- lapply(
##     nodes,
##     function(start, pipes) {
##         edges = character()
##         for (i in seq_along(pipes)) {
##             if (startComponent(pipes[[i]]) == start)
##                 edges <- c(edges, endComponent(pipes[[i]]))
##         }
##         edges
##     }, pipes)
## names(edgeList) <- nodes
nodes <- structure(c("xinclude", "substituteEntities",
                     "convertToRhtml", "knitToHtml",
                     "report.xml", "report.html"),
                   .Names = c("xinclude", "substituteEntities",
                              "convertToRhtml", "knitToHtml",
                              "report.xml", "report.html"))
edgeList <- structure(list(
    xinclude = "substituteEntities", substituteEntities = "convertToRhtml", 
    convertToRhtml = "knitToHtml", knitToHtml = "report.html",
    `report.xml` = "xinclude",
    `report.html` = character(0)),
    .Names = c("xinclude", "substituteEntities", "convertToRhtml",
               "knitToHtml",
               "report.xml", "report.html"))
toHtmlGraph <- new("graphNEL", nodes = nodes, edgeL = edgeList,
                   edgemode = "directed")
Ragraph <- agopenTrue(
    graph = toHtmlGraph, name = "",
    attrs= list(node = list(shape = "ellipse")),
    nodeAttrs = list(shape = c("report.xml" = "polygon",
                               "report.html" = "polygon")))
png("toHtmlGraph.png", width = graphWidth(Ragraph) * 96,
    height = graphHeight(Ragraph) * 96)
grid.graph(Ragraph, newpage = TRUE)
dev.off()
