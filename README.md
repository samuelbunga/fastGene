# fastGene
fastGene: Tool to convert Mouse gene symbols to Human equivalent gene symbols and vice versa by using [INDRA](https://github.com/sorgerlab/indra) (Integrated Network and Dynamical Reasoning Assembler) resources

Install:
```{r}
install_github('samuelbunga/fastGene')
```

Run fastGene:
```{r}
mouse_genes <- c('Il6', 'Cd4')
human_symbols <- convert_symbols(mouse_genes)
```
