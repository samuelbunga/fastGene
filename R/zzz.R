check_env <- function(){
  if('r-fastGene' %in% conda_list()[[1]]){
    reticulate::use_condaenv('r-fastGene')
  }else{
    reticulate::conda_install('r-fastGene', 
                              packages = 'pandas')
  }
}
.onLoad <- function(libname, pkgname){
  check_env()
  library(reticulate)
  home_dir <- path.expand("~")
  if(dir.exists(paste0(home_dir, '/.fastGene')) == F){
    print('Creating .fastGene in home directory')
    dir.create(paste0(home_dir, '/.fastGene/scripts'), recursive = T, 
               showWarnings = F)
    print('Downloading scripts...')
    system(paste0('wget https://github.com/samuelbunga/fastGene/tree/main/scripts/__init__.py -P ', home_dir,'/.fastGene/scripts/__init__.py'))
    system(paste0('wget https://github.com/samuelbunga/fastGene/tree/main/scripts/mgi_to_hgnc.py -P ', home_dir,'/.fastGene/scripts/mgi_to_hgnc.py'))
  }
  
}

