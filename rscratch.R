library(conduit)
library(gridGraphviz)
toHtml <- loadPipeline(name = "toHtml",
                       ref = "transform/toHtml/pipeline.xml")

nodes <- sapply(getComponents(toHtml), getName)

pipes <- getPipes(toHtml)
edgeList <- lapply(
    nodes,
    function(start, pipes) {
        edges = character()
        for (i in seq_along(pipes)) {
            if (startComponent(pipes[[i]]) == start)
                edges <- c(edges, endComponent(pipes[[i]]))
        }
        edges
    }, pipes)

names(edgeList) <- nodes

toHtmlGraph <- new("graphNEL", nodes = nodes, edgeL = edgeList,
                   edgemode = "directed")

Ragraph <- agopenTrue(graph = toHtmlGraph, "",
                      attrs= list(node = list(shape = "ellipse")))
png("toHtml.png", width = graphWidth(Ragraph) * 96,
    height = graphHeight(Ragraph) * 96)
grid.graph(Ragraph, newpage = TRUE)
dev.off()

### report version

library(gridGraphviz)
nodes <- structure(c("xinclude", "substituteEntities",
                     "convertToRhtml", "knitToHtml"),
                   .Names = c("xinclude", "substituteEntities",
                              "convertToRhtml", "knitToHtml"))
edgeList <- structure(list(
    xinclude = "substituteEntities", substituteEntities = "convertToRhtml", 
    convertToRhtml = "knitToHtml", knitToHtml = character(0)),
    .Names = c("xinclude", "substituteEntities", "convertToRhtml",
               "knitToHtml"))
toHtmlGraph <- new("graphNEL", nodes = nodes, edgeL = edgeList,
                   edgemode = "directed")
Ragraph <- agopenTrue(graph = toHtmlGraph, "",
                      attrs= list(node = list(shape = "ellipse")))
png("toHtml.png", width = graphWidth(Ragraph) * 96,
    height = graphHeight(Ragraph) * 96)
grid.graph(Ragraph, newpage = TRUE)
dev.off()
