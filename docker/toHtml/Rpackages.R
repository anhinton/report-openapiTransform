lib <- .Library.site[1]
## select CRAN mirror
chooseCRANmirror(
    ind = which(getCRANmirrors()[,"URL"] == "https://cloud.r-project.org/"))
## selecte CRAN, BioConductor, R-Forge for repos
setRepositories(ind=c(1,2))

## install packages from repos
packages <- c("XML", "whisker", "rPython", "Rgraphviz", "gridGraphviz",
              "knitr")
installIfRequired <- function(pkg) {
    if (!suppressWarnings(require(package = pkg, character.only = TRUE))) {
        install.packages(pkgs = pkg, lib = lib)
    }
}
for (i in packages) {
    installIfRequired(i)
}
