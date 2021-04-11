#' Gene symbol conversion
#'
#' Convert between Mouse and Human gene symbols
#' @param genes vector of genes
#' @export
#' @examples
#' symbols <- convert_symbols(c('Il6'))
library(reticulate)
if('r-fastGene' %in% conda_list()[[1]]){
  reticulate::use_condaenv('r-fastGene')
}else{
  conda_install('r-fastGene', packages = 'pandas')
}
convert_symbols <- function(genes){
  loc <- find.package("fastGene")
  reticulate::import('indra')
  mgi_to_hgnc <- import_from_path('mgi_to_hgnc', 
                                  path = paste0(loc,'/scripts'))
  mgi_to_hgnc$convert_symbols(c(genes))
}