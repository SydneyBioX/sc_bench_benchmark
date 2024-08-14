# The current landscape and emerging challenges of benchmarking single-cell methods

In this study, we conducted a systematic literature search and assessed 245 papers, including all 95 benchmark-only papers from the search and an additional 150 method development papers containing benchmarking.

The "data.csv" is the anonymous survey response that contains information on each of the 245 papers. To visualise our result, please go to our [webpage](https://shiny.maths.usyd.edu.au/sc_bench_benchmark/).

To contribute to our study, please submit this [form](https://docs.google.com/forms/d/12nQKGxNnwCsomzUrRi6J1nNrpQ3wffJElaIMqPiaSiE/viewform?edit_requested=true)

## Citation

<a href="https://www.biorxiv.org/content/10.1101/2023.12.19.572303v1" style="text-decoration: none; display: inline-flex; align-items: center; border: 1px solid black; padding: 5px;">
  <img src="https://www.biorxiv.org/sites/default/files/biorxiv_article.jpg" alt="bioRxiv Logo" style="height: 30px; vertical-align: middle;"> 
  <span style="font-size: 16px; font-family: Arial, sans-serif; padding-left: 10px;">The current landscape and emerging challenges of benchmarking single-cell methods</span>
</a>

## Contents

- [The current landscape and emerging challenges of benchmarking single-cell methods](#the-current-landscape-and-emerging-challenges-of-benchmarking-single-cell-methods)
  - [Citation](#citation)
  - [Contents](#contents)
  - [Benchmarking single-cell methods](#benchmarking-single-cell-methods)
    - [Pure benchmark](#pure-benchmark)
      - [Single-cell RNA-seq](#single-cell-rna-seq)
        - [Data](#data)
        - [Initial analysis](#initial-analysis)
        - [Intermediate analysis](#intermediate-analysis)
        - [Downstream analysis](#downstream-analysis)
        - [Analysis pipelines](#analysis-pipelines)
      - [Single-cell Hi-C](#single-cell-hi-c)
        - [Intermediate analysis](#intermediate-analysis-1)
      - [Single-cell mass cytometry](#single-cell-mass-cytometry)
        - [Intermediate analysis](#intermediate-analysis-2)
      - [Single-cell ATAC-seq](#single-cell-atac-seq)
        - [Initial analysis](#initial-analysis-1)
        - [Intermediate analysis](#intermediate-analysis-3)
        - [Analysis pipelines](#analysis-pipelines-1)
      - [Single-cell multiomics](#single-cell-multiomics)
        - [Intermediate analysis](#intermediate-analysis-4)
      - [Single-cell proteomics](#single-cell-proteomics)
        - [Analysis pipelines](#analysis-pipelines-2)
      - [Spatial transcriptomics](#spatial-transcriptomics)
        - [Initial analysis](#initial-analysis-2)
        - [Intermediate analysis](#intermediate-analysis-5)
    - [New method](#new-method)
      - [Single-cell RNA-seq](#single-cell-rna-seq-1)
        - [Data](#data-1)
        - [Initial analysis](#initial-analysis-3)
        - [Intermediate analysis](#intermediate-analysis-6)
        - [Downstream analysis](#downstream-analysis-1)
        - [Analysis pipelines](#analysis-pipelines-3)
      - [Single-cell Hi-C](#single-cell-hi-c-1)
        - [Initial analysis](#initial-analysis-4)
        - [Intermediate analysis](#intermediate-analysis-7)
      - [Single-cell sequencing](#single-cell-sequencing)
        - [Initial analysis](#initial-analysis-5)
        - [Downstream analysis](#downstream-analysis-2)
      - [Single-cell multiomics](#single-cell-multiomics-1)
        - [Initial analysis](#initial-analysis-6)
        - [Intermediate analysis](#intermediate-analysis-8)
        - [Downstream analysis](#downstream-analysis-3)
        - [Analysis pipelines](#analysis-pipelines-4)
      - [Single-cell ATAC-seq](#single-cell-atac-seq-1)
        - [Data](#data-2)
        - [Intermediate analysis](#intermediate-analysis-9)
        - [Downstream analysis](#downstream-analysis-4)
        - [Analysis pipelines](#analysis-pipelines-5)
      - [Single-cell ChIP-seq](#single-cell-chip-seq)
        - [Data](#data-3)
      - [Single-cell genomics](#single-cell-genomics)
        - [Data](#data-4)
        - [Intermediate analysis](#intermediate-analysis-10)
      - [Spatial transcriptomics](#spatial-transcriptomics-1)
        - [Initial analysis](#initial-analysis-7)
        - [Intermediate analysis](#intermediate-analysis-11)
        - [Downstream analysis](#downstream-analysis-5)
        - [Analysis pipelines](#analysis-pipelines-6)
      - [Spatial imaging](#spatial-imaging)
        - [Initial analysis](#initial-analysis-8)
        - [Intermediate analysis](#intermediate-analysis-12)
        - [Downstream analysis](#downstream-analysis-6)
        - [Analysis pipelines](#analysis-pipelines-7)

## Benchmarking single-cell methods

### Pure benchmark

#### Single-cell RNA-seq

##### Data

* **Benchmark datasets**

  - 2021 - [A multi-center cross-platform single-cell RNA sequencing reference dataset](https://pubmed.ncbi.nlm.nih.gov/33531477/)

* **Simulation**

  - 2023 - [The shaky foundations of simulating single-cell RNA sequencing data](https://pubmed.ncbi.nlm.nih.gov/36991470/)
  - 2022 - [A Framework for Comparison and Assessment of Synthetic RNA-Seq Data](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9778097/)
  - 2021 - [Benchmark study of simulation methods for single-cell RNA sequencing data](https://ideas.repec.org/a/nat/natcom/v12y2021i1d10.1038_s41467-021-27130-w.html)

##### Initial analysis

* **Alignment**

  - 2022 - [Comparative analysis of common alignment tools for single-cell RNA sequencing](https://pubmed.ncbi.nlm.nih.gov/35084033/)
  - 2021 - [Choice of pre-processing pipeline influences clustering quality of scRNA-seq datasets](https://pubmed.ncbi.nlm.nih.gov/34521337/)
  - 2020 - [Evaluation of STAR and Kallisto on Single Cell RNA-Seq Data Alignment](https://pubmed.ncbi.nlm.nih.gov/32220951/)

* **Deconvolution**

  - 2022 - [Comprehensive evaluation of deconvolution methods for human brain gene expression](https://pubmed.ncbi.nlm.nih.gov/35292647/)
  - 2021 - [Systematic evaluation of transcriptomics-based deconvolution methods and references using thousands of clinical samples](https://pubmed.ncbi.nlm.nih.gov/34346485/)
  - 2020 - [Benchmarking of cell type deconvolution pipelines for transcriptomics data](https://pubmed.ncbi.nlm.nih.gov/33159064/)
  - 2019 - [Comprehensive evaluation of transcriptome-based cell-type quantification methods for immuno-oncology](https://pubmed.ncbi.nlm.nih.gov/31510660/)

* **Doublet detection**

  - 2021 - [Benchmarking computational doublet-detection methods for single-cell RNA sequencing data](https://pubmed.ncbi.nlm.nih.gov/33338399/)

* **Imputation**

  - 2022 - [scIMC: a platform for benchmarking comparison and visualization analysis of scRNA-seq data imputation methods](https://pubmed.ncbi.nlm.nih.gov/35524568/)
  - 2020 - [A systematic evaluation of single-cell RNA-sequencing imputation methods](https://pubmed.ncbi.nlm.nih.gov/32854757/)
  - 2020 - [Comparison of Computational Methods for Imputing Single-Cell RNA-Sequencing Data](https://pubmed.ncbi.nlm.nih.gov/29994128/)
  - 2018 - [False signals induced by single-cell imputation](https://pubmed.ncbi.nlm.nih.gov/30906525/)

* **Quantification**

  - 2018 - [Simulation-based benchmarking of isoform quantification in single-cell RNA-seq](https://pubmed.ncbi.nlm.nih.gov/30404663/)

* **Standardization**

  - 2020 - [Normalization Methods on Single-Cell RNA-seq Data: An Empirical Survey](https://pubmed.ncbi.nlm.nih.gov/32117453/)
  - 2017 - [Assessment of Single Cell RNA-Seq Normalization Methods](https://pubmed.ncbi.nlm.nih.gov/28468817/)

* **Visualisation**

  - 2020 - [Comparison of visualization tools for single-cell RNAseq data](https://pubmed.ncbi.nlm.nih.gov/32766548/)

##### Intermediate analysis

* **Batch correction**

  - 2022 - [Comprehensive evaluation of noise reduction methods for single-cell RNA sequencing data](https://pubmed.ncbi.nlm.nih.gov/35048125/)
  - 2021 - [Benchmarking atlas-level data integration in single-cell genomics](https://pubmed.ncbi.nlm.nih.gov/34949812/)
  - 2021 - [Flexible comparison of batch correction methods for single-cell RNA-seq using BatchBench](https://pubmed.ncbi.nlm.nih.gov/33524142/)
  - 2020 - [A benchmark of batch-effect correction methods for single-cell RNA sequencing data](https://pubmed.ncbi.nlm.nih.gov/31948481/)
  - 2020 - [A comparison of methods accounting for batch effects in differential expression analysis of UMI count based single cell RNA sequencing](https://pubmed.ncbi.nlm.nih.gov/32322368/)

* **Cell type/state identification**

  - 2022 - [A Systematic Evaluation of Supervised Machine Learning Algorithms for Cell Phenotype Classification Using Single-Cell RNA Sequencing Data](https://pubmed.ncbi.nlm.nih.gov/35281805/)
  - 2021 - [Evaluation of machine learning approaches for cell-type identification from single-cell transcriptomics data](https://pubmed.ncbi.nlm.nih.gov/33611343/)
  - 2021 - [Evaluation of some aspects in supervised cell type identification for single-cell RNA-seq: classifier, feature selection, and reference construction](https://pubmed.ncbi.nlm.nih.gov/34503564/)
  - 2020 - [Evaluation of Cell Type Annotation R Packages on Single-cell RNA-seq Data](https://pubmed.ncbi.nlm.nih.gov/33359678/)
  - 2020 - [Evaluation of single-cell classifiers for single-cell RNA sequencing data sets](https://pubmed.ncbi.nlm.nih.gov/31675098/)
  - 2019 - [A comparison of automatic cell identification methods for single-cell RNA sequencing data](https://pubmed.ncbi.nlm.nih.gov/31500660/)
  - 2019 - [Evaluation of methods to assign cell type labels to cell clusters from single-cell RNA-sequencing data](https://pubmed.ncbi.nlm.nih.gov/31508207/)

* **Clustering**

  - 2022 - [Benchmarking clustering algorithms onÂ estimating theÂ number ofÂ cell types fromÂ single-cell RNA-sequencing data](https://pubmed.ncbi.nlm.nih.gov/35135612/)
  - 2019 - [Benchmark and Parameter Sensitivity Analysis of Single-Cell RNA Sequencing Clustering Methods](https://pubmed.ncbi.nlm.nih.gov/31921297/)
  - 2019 - [Clustering methods for single-cell RNA-sequencing expression data: performance evaluation with varying sample sizes and cell compositions](https://pubmed.ncbi.nlm.nih.gov/31646845/)
  - 2018 - [A systematic performance evaluation of clustering methods for single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/30271584/)
  - 2018 - [Comparison of clustering tools in R for medium-sized 10x Genomics single-cell RNA-sequencing data](https://pubmed.ncbi.nlm.nih.gov/30228881/)

* **Data integration**

  - 2023 - [IBRAP: integrated benchmarking single-cell RNA-sequencing analytical pipeline](https://pubmed.ncbi.nlm.nih.gov/36847692/)

* **Dimension reduction**

  - 2022 - [Towards a comprehensive evaluation of dimension reduction methods for transcriptomic data visualization](https://pubmed.ncbi.nlm.nih.gov/35853932/)
  - 2021 - [A Comparison for Dimensionality Reduction Methods of Single-Cell RNA-seq Data](https://pubmed.ncbi.nlm.nih.gov/33833778/)
  - 2021 - [Supervised application of internal validation measures to benchmark dimensionality reduction methods in scRNA-seq data](https://pubmed.ncbi.nlm.nih.gov/34374742/)
  - 2020 - [A Quantitative Framework for Evaluating Single-Cell Data Structure Preservation by Dimensionality Reduction Techniques](https://pubmed.ncbi.nlm.nih.gov/32375029/)
  - 2020 - [Benchmarking principal component analysis for large-scale single-cell RNA-sequencing](https://pubmed.ncbi.nlm.nih.gov/31955711/)
  - 2020 - [Tuning parameters of dimensionality reduction methods for single-cell RNA-seq analysis](https://pubmed.ncbi.nlm.nih.gov/32831127/)
  - 2019 - [Accuracy, robustness and scalability of dimensionality reduction methods for single-cell RNA-seq analysis](https://pubmed.ncbi.nlm.nih.gov/31823809/)
  - 2019 - [Parameter tuning is a key part of dimensionality reduction via deep variational autoencoders for single cell RNA transcriptomics](https://pubmed.ncbi.nlm.nih.gov/30963075/)
  - 2018 - [Dimensionality reduction for visualizing single-cell data using UMAP](https://pubmed.ncbi.nlm.nih.gov/30531897/)

* **Measure of association**

  - 2022 - [How does the structure of data impact cell-cell similarity? Evaluating how structural properties influence the performance of proximity metrics in single cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/36151725/)
  - 2019 - [Evaluating measures of association for single-cell transcriptomics](https://pubmed.ncbi.nlm.nih.gov/30962620/)

* **Subclone detection**

  - 2019 - [Systematic comparative analysis of single-nucleotide variant detection methods from single-cell RNA sequencing data](https://pubmed.ncbi.nlm.nih.gov/31744515/)

##### Downstream analysis

* **Cell cell communication**

  - 2022 - [A systematic evaluation of the computational tools for ligand-receptor-based cell-cell interaction inference](https://pubmed.ncbi.nlm.nih.gov/35822343/)
  - 2022 - [Evaluation of cell-cell interaction methods by integrating single-cell RNA sequencing data with spatial information](https://pubmed.ncbi.nlm.nih.gov/36253792/)

* **Differential analysis - others**

  - 2020 - [Quantifying Waddingtonâ€™s epigenetic landscape: a comparison of single-cell potency measures](https://pubmed.ncbi.nlm.nih.gov/30289442/)

* **Differential expression**

  - 2023 - [Benchmarking integration of single-cell differential expression](https://pubmed.ncbi.nlm.nih.gov/36944632/)
  - 2022 - [Benchmarking methods for detecting differential states between conditions from multi-subject single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/35880426/)
  - 2022 - [Recommendations of scRNA-seq Differential Gene Expression Analysis Based on Comprehensive Benchmarking](https://pubmed.ncbi.nlm.nih.gov/35743881/)
  - 2020 - [Reproducibility of Methods to Detect Differentially Expressed Genes from Single-Cell RNA Sequencing](https://pubmed.ncbi.nlm.nih.gov/32010190/)
  - 2019 - [Comparative analysis of differential gene expression analysis tools for single-cell RNA sequencing data](https://pubmed.ncbi.nlm.nih.gov/30658573/)
  - 2018 - [Bias, robustness and scalability in single-cell differential expression analysis](https://pubmed.ncbi.nlm.nih.gov/29481549/)
  - 2017 - [Comparison of methods to detect differentially expressed genes between single-cell populations](https://pubmed.ncbi.nlm.nih.gov/27373736/)
  - 2017 - [Single-cell RNA-sequencing: assessment of differential expression analysis methods](https://www.frontiersin.org/journals/genetics/articles/10.3389/fgene.2017.00062/full)

* **Highly variable genes**

  - 2019 - [Evaluation of tools for highly variable gene discovery from single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/29481632/)

* **Pathway enrichment**

  - 2022 - [Signature-scoring methods developed for bulk samples are not adequate for cancer single-cell RNA sequencing data](https://pubmed.ncbi.nlm.nih.gov/35212622/)
  - 2020 - [Benchmarking algorithms for pathway activity transformation of single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/33209207/)
  - 2020 - [Robustness and applicability of transcription factor and pathway analysis tools on single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/32051003/)

* **Regulatory network inference**

  - 2023 - [Identifying strengths and weaknesses of methods for computational network inference from single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/36626328/)
  - 2021 - [A comprehensive survey of regulatory network inference methods using single cell RNA sequencing data](https://pubmed.ncbi.nlm.nih.gov/34020546/)
  - 2021 - [Evaluating the reproducibility of single-cell gene regulatory network inference algorithms](https://pubmed.ncbi.nlm.nih.gov/33828580/)
  - 2021 - [Performance assessment of sample-specific network control methods for bulk and single-cell biological data analysis](https://pubmed.ncbi.nlm.nih.gov/33956788/)
  - 2020 - [Benchmarking algorithms for gene regulatory network inference from single-cell transcriptomic data](https://pubmed.ncbi.nlm.nih.gov/31907445/)
  - 2018 - [Evaluating methods of inferring gene regulatory networks highlights their lack of performance for single cell gene expression data](https://pubmed.ncbi.nlm.nih.gov/29914350/)

* **T/B-cell receptor**

  - 2022 - [Benchmarking computational methods for B-cell receptor reconstruction from single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/35855325/)

* **Trajectory**

  - 2019 - [A comparison of single-cell trajectory inference methods](https://pubmed.ncbi.nlm.nih.gov/30936559/)

* **Velocity**

  - 2021 - [Preprocessing choices affect RNA velocity results for droplet scRNA-seq data](https://pubmed.ncbi.nlm.nih.gov/33428615/)

##### Analysis pipelines

* **Analysis pipelines**
  
  - 2021 - [A multicenter study benchmarking single-cell RNA sequencing technologies using reference samples](https://pubmed.ncbi.nlm.nih.gov/33349700/)
  - 2021 - [Benchmarking UMI-based single-cell RNA-seq preprocessing workflows](https://pubmed.ncbi.nlm.nih.gov/34906205/)
  - 2021 - [Comparison of high-throughput single-cell RNA sequencing data processing pipelines](https://pubmed.ncbi.nlm.nih.gov/34020539/)
  - 2020 - [pipeComp, a general framework for the evaluation of computational pipelines, reveals performant single cell RNA-seq preprocessing tools](https://pubmed.ncbi.nlm.nih.gov/32873325/)
  - 2019 - [A systematic evaluation of single cell RNA-seq analysis pipelines](https://pubmed.ncbi.nlm.nih.gov/31604912/)
  - 2019 - [Benchmarking single cell RNA-sequencing analysis pipelines using mixture control experiments](https://pubmed.ncbi.nlm.nih.gov/31133762/)

#### Single-cell Hi-C

##### Intermediate analysis

* **Clustering**

  - 2022 - [A review and performance evaluation of clustering frameworks for single-cell Hi-C data](https://pubmed.ncbi.nlm.nih.gov/36151714/)

#### Single-cell mass cytometry

##### Intermediate analysis

* **Clustering**

  - 2021 - [Using single-cell cytometry to illustrate integrated multi-perspective evaluation of clustering algorithms using Pareto fronts](https://pubmed.ncbi.nlm.nih.gov/33508103/)
  - 2019 - [A comparison framework and guideline of clustering methods for mass cytometry data](https://pubmed.ncbi.nlm.nih.gov/31870419/)

#### Single-cell ATAC-seq

##### Initial analysis

* **Imputation**

  - 2022 - [Are dropout imputation methods for scRNA-seq effective for scATAC-seq data?](https://pubmed.ncbi.nlm.nih.gov/34718405/)

##### Intermediate analysis

* **Cell type/state identification**

  - 2022 - [Benchmarking automated cell type annotation tools for single-cell ATAC-seq data](https://pubmed.ncbi.nlm.nih.gov/36583014/)

##### Analysis pipelines

* **Analysis pipelines**
  
  - 2019 - [Assessment of computational methods for the analysis of single-cell ATAC-seq data](https://pubmed.ncbi.nlm.nih.gov/31739806/)

#### Single-cell multiomics

##### Intermediate analysis

* **Data integration**

  - 2022 - [A benchmark study of deep learning-based multi-omics data fusion methods for cancer](https://pubmed.ncbi.nlm.nih.gov/35945544/)
  - 2022 - [Integrating temporal single-cell gene expression modalities for trajectory inference and disease prediction](https://pubmed.ncbi.nlm.nih.gov/36064614/)

* **Dimension reduction**

  - 2021 - [Benchmarking joint multi-omics dimensionality reduction approaches for the study of cancer](https://pubmed.ncbi.nlm.nih.gov/33402734/)

#### Single-cell proteomics

##### Analysis pipelines

* **Analysis pipelines**
  
  - 2023 - [The Current State of Single-Cell Proteomics Data Analysis](https://pubmed.ncbi.nlm.nih.gov/36633424/)

#### Spatial transcriptomics

##### Initial analysis

* **Deconvolution**

  - 2023 - [A comprehensive benchmarking with practical guidelines for cellular deconvolution of spatial transcriptomics](https://pubmed.ncbi.nlm.nih.gov/36941264/)
  - 2023 - [Benchmarking and integration of methods for deconvoluting spatial transcriptomic data](https://pubmed.ncbi.nlm.nih.gov/36515467/)

##### Intermediate analysis

* **Clustering**

  - 2023 - [Benchmarking cell-type clustering methods for spatially resolved transcriptomics data](https://pubmed.ncbi.nlm.nih.gov/36410733/)

* **Data integration**

  - 2022 - [Benchmarking spatial and single-cell transcriptomics integration methods](https://pubmed.ncbi.nlm.nih.gov/35577955/)
  - 2022 - [Benchmarking spatial and single-cell transcriptomics integration methods for transcript distribution prediction and cell type deconvolution](https://pubmed.ncbi.nlm.nih.gov/35577954/)

### New method

#### Single-cell RNA-seq

##### Data

* **Simulation**

  - 2023 - [SimCH: simulation of single-cell RNA sequencing data by modeling cellular heterogeneity at gene expression level](https://pubmed.ncbi.nlm.nih.gov/36575569/)
  - 2021 - [ESCO: single cell expression simulation incorporating gene co-expression](https://pubmed.ncbi.nlm.nih.gov/33624750/)
  - 2021 - [scDesign2: a transparent simulator that generates high-fidelity single-cell gene expression count data with gene correlations captured](https://pubmed.ncbi.nlm.nih.gov/34034771/)
  - 2021 - [Spearheading future omics analyses using dyngen, a multi-modal simulator of single cells](https://pubmed.ncbi.nlm.nih.gov/34168133/)
  - 2021 - [splatPop: simulating population scale single-cell RNA sequencing data](https://pubmed.ncbi.nlm.nih.gov/34911537/)
  - 2020 - [Realistic in silico generation and augmentation of single-cell RNA-seq data using generative adversarial networks](https://pubmed.ncbi.nlm.nih.gov/31919373/)
  - 2020 - [Simulation, power evaluation and sample size recommendation for single-cell RNA-seq](https://pubmed.ncbi.nlm.nih.gov/32614380/)
  - 2019 - [A statistical simulator scDesign for rational scRNA-seq experimental design](https://pubmed.ncbi.nlm.nih.gov/31510652/)
  - 2017 - [powsimR: power analysis for bulk and single cell RNA-seq experiments](https://pubmed.ncbi.nlm.nih.gov/29036287/)

##### Initial analysis

* **Deconvolution**

  - 2022 - [Deconvolution analysis of cell-type expression from bulk tissues by integrating with single-cell expression reference](https://pubmed.ncbi.nlm.nih.gov/35788983/)

* **Doublet detection**

  - 2023 - [Vaeda computationally annotates doublets in single-cell RNA sequencing data](https://pubmed.ncbi.nlm.nih.gov/36342203/)

* **Imputation**

  - 2022 - [A novel method for single-cell data imputation using subspace regression](https://pubmed.ncbi.nlm.nih.gov/35177662/)
  - 2022 - [NISC: Neural Network-Imputation for Single-Cell RNA Sequencing and Cell Type Clustering](https://pubmed.ncbi.nlm.nih.gov/35591853/)
  - 2022 - [scESI: evolutionary sparse imputation for single-cell transcriptomes from nearest neighbor cells](https://pubmed.ncbi.nlm.nih.gov/35512331/)
  - 2020 - [scHinter: imputing dropout events for single-cell RNA-seq data with limited sample size](https://pubmed.ncbi.nlm.nih.gov/31392316/)
  - 2019 - [scNPF: an integrative framework assisted by network propagation and network fusion for preprocessing of single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/31068142/)

* **Quantification**

  - 2021 - [EmptyNN: A neural network based on positive and unlabeled learning to remove cell-free droplets and recover lost cells in scRNA-seq data](https://pubmed.ncbi.nlm.nih.gov/34430929/)

* **Standardization**

  - 2019 - [Performance Assessment and Selection of Normalization Procedures for Single-Cell RNA-Seq](https://pubmed.ncbi.nlm.nih.gov/31022373/)

* **Visualisation**

  - 2018 - [Generalizable and Scalable Visualization of Single-Cell Data Using Neural Networks](https://pubmed.ncbi.nlm.nih.gov/29936184/)
  - 2017 - [Visualization and analysis of single-cell RNA-seq data by kernel-based similarity learning](https://pubmed.ncbi.nlm.nih.gov/28263960/)

##### Intermediate analysis

* **Batch correction**

  - 2021 - [CellMixS: quantifying and visualizing batch effects in single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/33758076/)
  - 2021 - [iSMNN: batch effect correction for single-cell RNA-seq data via iterative supervised mutual nearest neighbor refinement](https://pubmed.ncbi.nlm.nih.gov/33839756/)
  - 2020 - [BBKNN: fast batch alignment of single cell transcriptomes](https://pubmed.ncbi.nlm.nih.gov/31400197/)
  - 2019 - [scMerge leverages factor analysis, stable expression, and pseudoreplication to merge multiple single-cell RNA-seq datasets](https://pubmed.ncbi.nlm.nih.gov/31028141/)

* **Cell type/state identification**

  - 2023 - [Adversarial dense graph convolutional networks for single-cell classification](https://pubmed.ncbi.nlm.nih.gov/36661313/)
  - 2023 - [Influence of Cell-type Ratio on Spatially Resolved Single-cell Transcriptomes using the Tangram Algorithm: Based on Implementation on Single-Cell and MxIF Data](https://pubmed.ncbi.nlm.nih.gov/37324550/)
  - 2023 - [Learning Cell Annotation under Multiple Reference Datasets by Multisource Domain Adaptation](https://pubmed.ncbi.nlm.nih.gov/36579851/)
  - 2023 - [scGAD: a new task and end-to-end framework for generalized cell type annotation and discovery](https://pubmed.ncbi.nlm.nih.gov/36869836/)
  - 2022 - [Cross-species cell-type assignment from single-cell RNA-seq data by a heterogeneous graph neural network](https://pubmed.ncbi.nlm.nih.gov/36526433/)
  - 2022 - [scMAGIC: accurately annotating single cells using two rounds of reference-based classification](https://pubmed.ncbi.nlm.nih.gov/34986249/)
  - 2021 - [ChrNet: A re-trainable chromosome-based 1D convolutional neural network for predicting immune cell types](https://pubmed.ncbi.nlm.nih.gov/33932523/)
  - 2021 - [Identifying phenotype-associated subpopulations by integrating bulk and single-cell sequencing data](https://pubmed.ncbi.nlm.nih.gov/34764492/)
  - 2021 - [Integrating multiple references for single-cell assignment](https://pubmed.ncbi.nlm.nih.gov/34037791/)
  - 2020 - [A multiresolution framework to characterize single-cell state landscapes](https://pubmed.ncbi.nlm.nih.gov/33106496/)
  - 2020 - [Learning for single-cell assignment](https://pubmed.ncbi.nlm.nih.gov/33127686/)
  - 2020 - [scCATCH: Automatic Annotation on Cell Types of Clusters from Single-Cell RNA Sequencing Data](https://pubmed.ncbi.nlm.nih.gov/32062421/)
  - 2020 - [scClassify: sample size estimation and multiscale classification of cells using single and multiple reference](https://pubmed.ncbi.nlm.nih.gov/32567229/)
  - 2019 - [CellFishing.jl: an ultrafast and scalable cell search method for single-cell RNA sequencing](https://pubmed.ncbi.nlm.nih.gov/30744683/)
  - 2019 - [CHETAH: a selective, hierarchical cell type identification method for single-cell RNA sequencing](https://pubmed.ncbi.nlm.nih.gov/31226206/)
  - 2019 - [Latent cellular analysis robustly reveals subtle diversity in large-scale single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/31566233/)
  - 2019 - [scPred: accurate supervised method for cell-type classification from single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/31829268/)
  - 2019 - [Supervised classification enables rapid annotation of cell atlases](https://pubmed.ncbi.nlm.nih.gov/31501545/)

* **Clustering**

  - 2023 - [scMINER: a mutual information-based framework for identifying hidden drivers from single-cell omics data](https://pubmed.ncbi.nlm.nih.gov/36747874/)
  - 2022 - [A model-based constrained deep learning clustering approach for spatially resolved single-cell data](https://pubmed.ncbi.nlm.nih.gov/36198490/)
  - 2022 - [EDClust: an EM-MM hybrid method for cell clustering in multiple-subject single-cell RNA sequencing](https://pubmed.ncbi.nlm.nih.gov/35561178/)
  - 2022 - [Secuer: Ultrafast, scalable and accurate clustering of single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/36469543/)
  - 2021 - [A spectral clustering with self-weighted multiple kernel learning method for single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/33003206/)
  - 2021 - [HGC: fast hierarchical clustering for large-scale single-cell data](https://pubmed.ncbi.nlm.nih.gov/34096998/)
  - 2020 - [Single-Cell RNA Sequencing Data Interpretation by Evolutionary Multiobjective Clustering](https://pubmed.ncbi.nlm.nih.gov/30908236/)
  - 2019 - [A Hybrid Clustering Algorithm for Identifying Cell Types from Single-Cell RNA-Seq Data](https://pubmed.ncbi.nlm.nih.gov/30700040/)
  - 2019 - [Autoencoder-based cluster ensembles for single-cell RNA-seq data analysis](https://pubmed.ncbi.nlm.nih.gov/31870278/)
  - 2017 - [CIDR: Ultrafast and accurate clustering through imputation for single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/28351406/)
  - 2017 - [sc3: consensus clustering of single-cell rna-seq data](https://pubmed.ncbi.nlm.nih.gov/28346451/)

* **Data integration**

  - 2022 - [Integration of single cell data by disentangled representation learning](https://pubmed.ncbi.nlm.nih.gov/34850092/)
  - 2021 - [DEEPsc: A Deep Learning-Based Map Connecting Single-Cell Transcriptomics and Spatial Imaging Data](https://pubmed.ncbi.nlm.nih.gov/33833776/)
  - 2019 - [Fast, sensitive and accurate integration of single-cell data with Harmony](https://pubmed.ncbi.nlm.nih.gov/31740819/)

* **Dimension reduction**

  - 2017 - [Network embedding-based representation learning for single cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/28977434/)

* **Measure of association**

  - 2019 - [Impact of similarity metrics on single-cell RNA-seq data clustering](https://pubmed.ncbi.nlm.nih.gov/30137247/)

* **Rare cell type identification**

  - 2021 - [Bayesian information sharing enhances detection of regulatory associations in rare cell types](https://pubmed.ncbi.nlm.nih.gov/34252956/)
  - 2021 - [GapClust is a light-weight approach distinguishing rare cells from voluminous single cell expression profiles](https://pubmed.ncbi.nlm.nih.gov/34234139/)
  - 2019 - [CellSIUS provides sensitive and specific detection of rare cell populations from complex single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/31315641/)
  - 2018 - [Discovery of rare cells from voluminous single cell expression data](https://pubmed.ncbi.nlm.nih.gov/30413715/)

* **Subclone detection**

  - 2023 - [A Variational Algorithm to Detect the Clonal Copy Number Substructure of Tumors from scRNA-seq Data](https://pubmed.ncbi.nlm.nih.gov/36841879/)
  - 2021 - [Delineating Copy Number and Clonal Substructure in Human Tumors from Single-cell Transcriptomes](https://pubmed.ncbi.nlm.nih.gov/33462507/)
  - 2020 - [DENDRO: genetic heterogeneity profiling and subclone detection by single-cell RNA sequencing](https://pubmed.ncbi.nlm.nih.gov/31937348/)

##### Downstream analysis

* **Differential analysis - others**

  - 2022 - [Transcriptome analysis method based on differential distribution evaluation](https://pubmed.ncbi.nlm.nih.gov/35151228/)
  - 2021 - [Differential abundance testing on single-cell data using k-nearest neighbor graphs](https://pubmed.ncbi.nlm.nih.gov/34594043/)
  - 2021 - [Ultra-fast scalable estimation of single-cell differentiation potency from scRNA-Seq data](https://pubmed.ncbi.nlm.nih.gov/33244588/)
  - 2018 - [A sparse differential clustering algorithm for tracing cell type changes via single-cell RNA-sequencing data](https://pubmed.ncbi.nlm.nih.gov/29140455/)

* **Differential expression**

  - 2022 - [Benchmarking of a Bayesian single cell RNAseq differential gene expression test for doseâ€“response study designs](https://pubmed.ncbi.nlm.nih.gov/35061903/)
  - 2022 - [Differential expression of single-cell RNA-seq data using Tweedie models](https://pubmed.ncbi.nlm.nih.gov/35656596/)

* **Marker/signature identification**

  - 2022 - [Triku: a feature selection method based on nearest neighbors for single-cell data](https://pubmed.ncbi.nlm.nih.gov/35277963/)
  - 2021 - [Uncovering cell identity through differential stability with Cepo](https://pubmed.ncbi.nlm.nih.gov/38217190/)
  - 2020 - [A rank-based marker selection method for high throughput scRNA-seq data](https://pubmed.ncbi.nlm.nih.gov/33097004/)
  - 2020 - [DrivAER: Identification of driving transcriptional programs in single-cell RNA sequencing data](https://pubmed.ncbi.nlm.nih.gov/33301553/)
  - 2019 - [De novo gene signature identification from single-cell RNA-seq with hierarchical Poisson factorization](https://pubmed.ncbi.nlm.nih.gov/30796088/)
  - 2019 - [Identifying gene expression programs of cell-type identity and cellular activity with single-cell RNA-Seq](https://pubmed.ncbi.nlm.nih.gov/31282856/)

* **Regulatory network inference**

  - 2023 - [Single-cell gene regulatory network prediction by explainable AI](https://pubmed.ncbi.nlm.nih.gov/36629274/)
  - 2022 - [NetREX-CF integrates incomplete transcription factor data with gene expression to reconstruct gene regulatory networks](https://pubmed.ncbi.nlm.nih.gov/36418514/)
  - 2022 - [SRGS: sparse partial least squares-based recursive gene selection for gene regulatory network inference](https://pubmed.ncbi.nlm.nih.gov/36451086/)

* **T/B-cell receptor**

  - 2021 - [Predicting recognition between T cell receptors and epitopes with TCRGP](https://pubmed.ncbi.nlm.nih.gov/33764977/)

* **Trajectory**

  - 2022 - [Density-based detection of cell transition states to construct disparate and bifurcating trajectories](https://pubmed.ncbi.nlm.nih.gov/36124665/)
  - 2022 - [Detecting critical transition signals from single-cell transcriptomes to infer lineage-determining transcription factors](https://pubmed.ncbi.nlm.nih.gov/35640613/)
  - 2022 - [psupertime: supervised pseudotime analysis for time-series single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/35758781/)
  - 2022 - [scShaper: an ensemble method for fast and accurate linear trajectory inference from single-cell RNA-seq data](https://pubmed.ncbi.nlm.nih.gov/34888622/)
  - 2021 - [PseudoGA: cell pseudotime reconstruction based on genetic algorithm](https://pubmed.ncbi.nlm.nih.gov/34244782/)
  - 2019 - [PAGA: graph abstraction reconciles clustering with trajectory inference through a topology preserving map of single cells](https://pubmed.ncbi.nlm.nih.gov/30890159/)

* **Velocity**

  - 2022 - [DeepVelo: Single-cell transcriptomic deep velocity field learning with neural ordinary differential equations](https://pubmed.ncbi.nlm.nih.gov/36449617/)

##### Analysis pipelines

* **Analysis pipelines**

  - 2021 - [TISCH: a comprehensive web resource enabling interactive single-cell transcriptome visualization of tumor microenvironment](https://pubmed.ncbi.nlm.nih.gov/33179754/)
  - 2020 - [Cumulus provides cloud-based data analysis for large-scale single-cell and single-nucleus RNA-seq](https://pubmed.ncbi.nlm.nih.gov/32719530/)

* **Multi-task**

  - 2022 - [High-throughput single-cell RNA-seq data imputation and characterization with surrogate-assisted automated deep learning](https://pubmed.ncbi.nlm.nih.gov/34553763/)
  - 2021 - [scGNN is a novel graph neural network framework for single-cell RNA-Seq analyses](https://pubmed.ncbi.nlm.nih.gov/33767197/)

#### Single-cell Hi-C

##### Initial analysis

* **Standardization**

  - 2022 - [Normalization and de-noising of single-cell Hi-C data with BandNorm and scVI-3D](https://pubmed.ncbi.nlm.nih.gov/36253828/)

##### Intermediate analysis

* **Chromatin conformation**

  - 2021 - [Perspectives for the reconstruction of 3D chromatin conformation using single cell Hi-C data](https://pubmed.ncbi.nlm.nih.gov/34793453/)
  - 2021 - [SnapHiC: a computational pipeline to identify chromatin loops from single-cell Hi-C data](https://pubmed.ncbi.nlm.nih.gov/34446921/)

* **Subclone detection**

  - 2022 - [Resolving single-cell copy number profiling for large datasets](https://pubmed.ncbi.nlm.nih.gov/35801503/)

#### Single-cell sequencing

##### Initial analysis

* **Quantification**

  - 2021 - [Pheniqs 20: accurate, high-performance Bayesian decoding and confidence estimation for combinatorial barcode indexing](https://pubmed.ncbi.nlm.nih.gov/34215187/)

##### Downstream analysis

* **Trajectory**

  - 2022 - [A lineage tree-based hidden Markov model quantifies cellular heterogeneity and plasticity](https://pubmed.ncbi.nlm.nih.gov/36396800/)

#### Single-cell multiomics

##### Initial analysis

* **Doublet detection**

  - 2022 - [Doublet identification in single-cell sequencing data using scDblFinder](https://pubmed.ncbi.nlm.nih.gov/35814628/)

* **Imputation**

  - 2020 - [SpaGE: Spatial Gene Enhancement using scRNA-seq](https://pubmed.ncbi.nlm.nih.gov/32955565/)

##### Intermediate analysis

* **Cell type/state identification**

  - 2021 - [scGCN is a graph convolutional networks algorithm for knowledge transfer in single cell omics](https://pubmed.ncbi.nlm.nih.gov/34158507/)

* **Data integration**

  - 2023 - [Single-cell multi-omics integration for unpaired data by a siamese network with graph-based contrastive loss](https://pubmed.ncbi.nlm.nih.gov/36600199/)
  - 2022 - [Adversarial domain translation networks for integrating large-scale atlas-level single-cell datasets](https://pubmed.ncbi.nlm.nih.gov/38177826/)
  - 2022 - [AIscEA: unsupervised integration of single-cell gene expression and chromatin accessibility via their biological consistency](https://pubmed.ncbi.nlm.nih.gov/36250795/)
  - 2022 - [Multi-omics single-cell data integration and regulatory inference with graph-linked embedding](https://pubmed.ncbi.nlm.nih.gov/35501393/)
  - 2022 - [scJoint integrates atlas-scale single-cell RNA-seq and ATAC-seq data with transfer learning](https://pubmed.ncbi.nlm.nih.gov/35058621/)

##### Downstream analysis

* **Cell cell communication**

  - 2022 - [Optimal transport improves cell-cell similarity inference in single-cell omics data](https://pubmed.ncbi.nlm.nih.gov/35157031/)

* **Regulatory network inference**

  - 2023 - [Dissecting cell identity via network inference and in silico gene perturbation](https://pubmed.ncbi.nlm.nih.gov/36755098/)
  - 2023 - [Single-cell biological network inference using a heterogeneous graph transformer](https://pubmed.ncbi.nlm.nih.gov/36810839/)
  - 2022 - [DIRECT-NET: An efficient method to discover cis-regulatory elements and construct regulatory networks from single-cell multiomics data](https://pubmed.ncbi.nlm.nih.gov/35648859/)
  - 2022 - [Functional inference of gene regulation using single-cell multi-omics](https://pubmed.ncbi.nlm.nih.gov/36204155/)
  - 2022 - [IReNA: Integrated regulatory network analysis of single-cell transcriptomes and chromatin accessibility profiles](https://pubmed.ncbi.nlm.nih.gov/36325073/)
  - 2022 - [Nonparametric single-cell multiomic characterization of trio relationships between transcription factors, target genes, and cis-regulatory regions](https://pubmed.ncbi.nlm.nih.gov/36055233/)
  - 2022 - [Regulatory analysis of single cell multiome gene expression and chromatin accessibility data with scREG](https://pubmed.ncbi.nlm.nih.gov/35578363/)

##### Analysis pipelines

* **Analysis pipelines**

  - 2023 - [Destin2: Integrative and cross-modality analysis of single-cell chromatin accessibility data](https://pubmed.ncbi.nlm.nih.gov/36873935/)
  - 2021 - [EpiScanpy: integrated single-cell epigenomic analysis](https://pubmed.ncbi.nlm.nih.gov/34471111/)

* **Multi-task**

  - 2022 - [Joint dimension reduction and clustering analysis of single-cell RNA-seq and spatial transcriptomics data](https://pubmed.ncbi.nlm.nih.gov/35349708/)

#### Single-cell ATAC-seq

##### Data

* **Simulation**

  - 2021 - [SCAN-ATAC-Sim: a scalable and efficient method for simulating single-cell ATAC-seq data from bulk-tissue experiments](https://pubmed.ncbi.nlm.nih.gov/33471102/)
  - 2021 - [simATAC: a single-cell ATAC-seq simulation framework](https://pubmed.ncbi.nlm.nih.gov/33663563/)

##### Intermediate analysis

* **Clustering**

  - 2023 - [ASTER: accurately estimating the number of cell types in single-cell chromatin accessibility data](https://pubmed.ncbi.nlm.nih.gov/36610708/)

##### Downstream analysis

* **Regulatory network inference**

  - 2023 - [maxATAC: Genome-scale transcription-factor binding prediction from ATAC-seq with deep neural networks](https://pubmed.ncbi.nlm.nih.gov/36719906/)

##### Analysis pipelines

* **Analysis pipelines**

  - 2020 - [Interactive analysis of single-cell epigenomic landscapes with ChromSCape](https://pubmed.ncbi.nlm.nih.gov/33177523/)

#### Single-cell ChIP-seq

##### Data

* **Simulation**
  - 2021 - [Novel ChIP-seq simulating program with superior versatility: isChIP](https://pubmed.ncbi.nlm.nih.gov/33320934/)

#### Single-cell genomics

##### Data

* **Simulation**

  - 2020 - [SCSsim: an integrated tool for simulating single-cell genome sequencing data](https://pubmed.ncbi.nlm.nih.gov/31584615/)

##### Intermediate analysis

* **Cell type/state identification**

  - 2022 - [scAB detects multiresolution cell states with clinical significance by integrating single-cell genomics and bulk sequencing data](https://pubmed.ncbi.nlm.nih.gov/36440766/)

#### Spatial transcriptomics

##### Initial analysis

* **Cell segmentation**

  - 2021 - [Cell segmentation in imaging-based spatial transcriptomics](https://pubmed.ncbi.nlm.nih.gov/34650268/)

* **Deconvolution**

  - 2022 - [Advances in mixed cell deconvolution enable quantification of cell types in spatial transcriptomic data](https://pubmed.ncbi.nlm.nih.gov/35046414/)
  - 2022 - [SD2: spatially resolved transcriptomics deconvolution through integration of dropout and spatial information](https://pubmed.ncbi.nlm.nih.gov/36063455/)
  - 2021 - [SpatialDWLS: accurate deconvolution of spatial transcriptomic data](https://pubmed.ncbi.nlm.nih.gov/33971932/)

* **Imputation**

  - 2022 - [Efficient prediction of a spatial transcriptomics profile better characterizes breast cancer tissue sections without costly experimentation](https://pubmed.ncbi.nlm.nih.gov/35260632/)
  - 2022 - [Region-specific denoising identifies spatial co-expression patterns and intra-tissue heterogeneity in spatially resolved transcriptomics data](https://pubmed.ncbi.nlm.nih.gov/36376296/)
  - 2021 - [Spatial transcriptomics at subspot resolution with BayesSpace](https://pubmed.ncbi.nlm.nih.gov/34083791/)

##### Intermediate analysis

* **Cell type/state identification**

  - 2022 - [Spatial-ID: a cell typing method for spatially resolved transcriptomics via transfer learning and spatial embedding](https://pubmed.ncbi.nlm.nih.gov/36496406/)

* **Data integration**

  - 2022 - [Alignment and integration of spatial transcriptomics data](https://pubmed.ncbi.nlm.nih.gov/35577957/)
  - 2022 - [DeepST: identifying spatial domains in spatial transcriptomics by deep learning](https://pubmed.ncbi.nlm.nih.gov/36250636/)

##### Downstream analysis

* **Highly variable genes**

  - 2023 - [SINFONIA: Scalable Identification of Spatially Variable Genes for Deciphering Spatial Domains](https://pubmed.ncbi.nlm.nih.gov/36831270/)
  - 2021 - [SOMDE: a scalable method for identifying spatially variable genes with self-organizing map](https://pubmed.ncbi.nlm.nih.gov/34165490/)
  - 2021 - [SpaGCN: Integrating gene expression, spatial location and histology to identify spatial domains and spatially variable genes by graph convolutional network](https://pubmed.ncbi.nlm.nih.gov/34711970/)
  - 2021 - [SPARK-X: non-parametric modeling enables scalable and robust detection of spatial expression patterns for large spatial transcriptomic studies](https://pubmed.ncbi.nlm.nih.gov/34154649/)
  - 2018 - [SpatialDE: identification of spatially variable genes](https://pubmed.ncbi.nlm.nih.gov/29553579/)

##### Analysis pipelines

* **Analysis pipelines**

  - 2022 - [TIST: Transcriptome and Histopathological Image Integrative Analysis for Spatial Transcriptomics](https://pubmed.ncbi.nlm.nih.gov/36549467/)
  - 2021 - [Giotto: a toolbox for integrative analysis and visualization of spatial expression data](https://pubmed.ncbi.nlm.nih.gov/33685491/)

* **Multi-task**

  - 2023 - [Spatially informed clustering, integration, and deconvolution of spatial transcriptomics with GraphST](https://pubmed.ncbi.nlm.nih.gov/36859400/)

#### Spatial imaging

##### Initial analysis

* **Assembly**

  - 2018 - [Mapping molecular assemblies with fluorescence microscopy and object-based spatial statistics](https://pubmed.ncbi.nlm.nih.gov/29449608/)

* **Cell segmentation**

  - 2021 - [Joint cell segmentation and cell type annotation for spatial transcriptomics](https://pubmed.ncbi.nlm.nih.gov/34057817/)
  - 2020 - [Cellpose: a generalist algorithm for cellular segmentation](https://pubmed.ncbi.nlm.nih.gov/33318659/)

##### Intermediate analysis

* **Clustering**

  - 2021 - [ClusterMap for multi-scale clustering analysis of spatial gene expression](https://pubmed.ncbi.nlm.nih.gov/34625546/)

##### Downstream analysis

* **Trajectory**

  - 2020 - [Predicting cell lineages using autoencoders and optimal transport](https://pubmed.ncbi.nlm.nih.gov/32343706/)

##### Analysis pipelines

* **Analysis pipelines**

  - 2022 - [spicyR: spatial analysis of in situ cytometry data in R](https://pubmed.ncbi.nlm.nih.gov/35438129/)
  - 2017 - [histocat: analysis of cell phenotypes and interactions in multiplex image cytometry data](https://pubmed.ncbi.nlm.nih.gov/28783155/)
