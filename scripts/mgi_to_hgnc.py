import os
import sys
import pickle
import pandas as pd
from indra.databases.uniprot_client import um
from indra.databases.hgnc_client import get_hgnc_from_mouse, get_hgnc_name


def check_cache(loc):
    cache_dir = os.path.join(loc, '.fastGene')
    if os.path.isdir(cache_dir):
        pass
    else:
        os.mkdir(cache_dir)

    if os.path.isfile(os.path.join(cache_dir, 'filtered_mgi.pkl')):
        return True
    else:
        return False


def mgi_to_hgnc_name(gene_list, mouse_gene_name_to_mgi):
    """Convert given mouse gene symbols to HGNC equivalent symbols"""    
    filtered_mgi = {mouse_gene_name_to_mgi[gene] for gene in gene_list
                    if gene in mouse_gene_name_to_mgi}
    if len(filtered_mgi) == 0:
        return 'None'
        #raise Exception('No genes found')
        
    hgnc_gene_set = dict()
    for mgi_id in filtered_mgi:
        hgnc_id = get_hgnc_from_mouse(mgi_id)
        hgnc_name = get_hgnc_name(hgnc_id)
    return hgnc_name


def convert_symbols(genes, loc):
    cache = check_cache(loc)
    cache_dir = os.path.join(loc, '.fastGene')
    if cache == True:
        with open(os.path.join(cache_dir, 'mouse_gene_name_to_mgi.pkl'), 'rb') as fh:
            mouse_gene_name_to_mgi = pickle.load(fh)
    elif cache == False:
        mouse_gene_name_to_mgi = {v: um.uniprot_mgi.get(k) 
                                  for k, v in um.uniprot_gene_name.items() 
                                  if k in um.uniprot_mgi}
        with open(os.path.join(cache_dir, 'mouse_gene_name_to_mgi.pkl'), 'wb') as fh:
            pickle.dump(mouse_gene_name_to_mgi, fh)

    hgnc_gene_list = [mgi_to_hgnc_name([g], mouse_gene_name_to_mgi) 
                      for g in genes]
    return hgnc_gene_list
