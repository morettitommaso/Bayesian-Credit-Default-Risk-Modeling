# Bayesian Credit Default Risk Scoring

An empirical comparison between Frequentist, Regularized Bayesian, and Two-Stage Bayesian Logistic Models for predicting severe credit default.

## Overview

Credit scoring models in financial institutions require a delicate balance between predictive accuracy and statistical interpretability. While black-box Machine Learning approaches often offer high predictive performance, they can be prone to overfitting and lack the transparency mandated by financial regulators.

This repository implements and compares three credit scoring approaches, drawing inspiration from the works of Kyeong & Shin (2022) [1]:

1. **Frequentist Logistic Regression** (Baseline GLM)
2. **Bayesian Logistic Regression with Laplace Prior** (Sparse/Regularized approach)
3. **Two-Stage Bayesian Logistic Meta-Model** (Hierarchical framework)

The models are evaluated on the Kaggle **"Give Me Some Credit"** dataset to predict severe financial distress (90+ days past due).


## Repository Structure

```text
├── R/                  # R helper functions (evaluation metrics, threshold tuning)
├── data/               # Raw and processed datasets
├── figures/            # Diagnostic plots and more
├── notebooks/          
│   ├── 01_data_preprocessing.Rmd   # Data cleaning and feature engineering
│   ├── 02_frequentist_logit.Rmd    # Baseline GLM modeling
│   ├── 03_bayesian_logit.Rmd       # Bayesian Logit with Laplace priors
│   ├── 04_two_stage_logit.Rmd      # Two-Stage Bayesian implementation
│   └── 05_results.Rmd              # Performance benchmarking 
├── report/             # Executive PDF summary of findings (~5 min read)
└── stan/               # Stan modeling scripts 
```


## Why Bayesian Logistic Regression?

While pure ML techniques dominate leaderboards, Logistic models remain the industry standard due to explicit parameter interpretability and clear log-odds score transformations. Incorporating a Bayesian framework allows for:

- Proper uncertainty quantification via posterior distributions.

- Regularization through informative priors (e.g., Laplace prior for sparsity).

- Stage-wise modeling to capture complex hierarchical relationships without losing interpretability.


## Limitations & Potential Improvements

- Better data cleaning, robust imputation strategies, and optimal binning/WoE transformations could yield the largest performance boosts

- Incorporating exogenous economic variables (e.g., interest rate fluctuations, inflation dynamics, GDP growth expectations) to better explain temporal variance in default rates.


### References

[1] Kyeong, S., Shin, J. Two-stage credit scoring using Bayesian approach. J Big Data 9, 106 (2022). https://doi.org/10.1186/s40537-022-00665-5

[2] Masekoameng, J.L.; Mbona, S.V.; Ananth, A.; Chifurira, R. Bayesian Logistic Regression for Credit Risk Modelling Among South African Loan Borrowers. J. Risk Financial Manag. 2026, 19, 358. https://doi.org/10.3390/jrfm19050358

[3] Mestiri, Sami and Farhat, Abdejelil (2018): Credit Risk Prediction based on Bayesian estimation of logistic regression model with random effects.

[4] Rigon, T. Lecture Notes on GLM and Logistic Regression. https://tommasorigon.github.io/StatIII/
