#' Gene symbol conversion
#'
#' Convert between Mouse and Human gene symbols
#' @param genes vector of genes
#' @export
#' @examples
#' symbols <- convert_symbols(c('Il6'))
convert_symbols <- function(gene_list){
  require('reticulate')
  #loc <- find.package("fastGene")
  loc <- '~/.fastGene/'
  reticulate::import('indra')
  mgi_to_hgnc <- import_from_path('mgi_to_hgnc', 
                                  path = paste0(loc, '/scripts'))
  mgi_to_hgnc$convert_symbols(c(gene_list), loc)
}