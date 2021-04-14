check_env <- function(){
  if('r-fastGene' %in% reticulate::conda_list()[[1]]){
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
    system(paste0('wget https://raw.githubusercontent.com/samuelbunga/fastGene/main/scripts/__init__.py -P ',
                  home_dir,'/.fastGene/scripts/'))
    system(paste0('wget https://raw.githubusercontent.com/samuelbunga/fastGene/main/scripts/mgi_to_hgnc.py -P ',
                  home_dir,'/.fastGene/scripts/'))
  }
  
}

