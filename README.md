# TransLearning


This repository includes MATLAB scripts for constructing the adaptive Riemannian decoders utilized in (https://doi.org/10.1093/pnasnexus/pgae076).

This repository utilizes functions introduced in the following toolboxes:
* Covariance toolbox (https://github.com/alexandrebarachant/covariancetoolbox)
* BCI Signal Processing toolbox (https://drive.google.com/file/d/0B93wwoGtlGkmYWJjODktVFNfUFU/view?resourcekey=0-cjG6MhcJMwLPaCQFNn4pLQ)
* Adaptive Riemannian classification (https://github.com/neurosatya/AdaRGC?tab=readme-ov-file)
* EEGLab toolbox (https://sccn.ucsd.edu/eeglab/index.php)
* Biosig toolbox for loading raw EEG data (https://biosig.sourceforge.net/)

# Example Scripts

**generateCovarainceInterpretation.m**

This sample script generates the Electrode Discriminancy Score (EDS) topoplot pattern of the Expert subject, as illustrated in Figure 5a of the paper. It utilizes the topoplot function from the EEG Lab toolbox. If you do not have the EEG Lab toolbox installed, please ensure to install it before using this script.

**raceTriggerSync.m**

This sample script demonstrates how to synchronize the triggers from the acquired EEG data during the races to those of the race log generated from the brain driver game. Unlike the bar feedback setup, which operates in a synchronous setting and includes a target BCI command in the EEG header files (see dataset description for details), races do not have a target BCI command in their EEG header files. To address this, I provide a sample script that synchronizes the race log files to the corresponding header file. When you run this script, the *eventHeader* will consist of triggers 7691 and 7701 with their corresponding timestamps, which are synchronized to the EEG header of the corresponding race recording.


If you end up using the data for analysis from: https://zenodo.org/records/10694880?preview=1 for benchmarking BCI algorithms or use codes from this repository (https://github.com/neurosatya/TransLearning) please cite our following work


* Satyam Kumar, Hussein Alawieh, Frigyes Samuel Racz, Rawan Fakhreddine, and José del R Millán. Transfer
learning promotes acquisition of individual bci skills. PNAS Nexus, page pgae076, 2024.
