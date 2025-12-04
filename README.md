# ECON 280 Replication Extension — Phillips Curve Slope Across Inflation Measures

This repository contains my ECON 280 extension analysis based on Hazell, Herreño, Nakamura, and Steinsson (2022), *“The Slope of the Phillips Curve: Evidence from U.S. States.”*  

The goal of this extension is to test how the estimated Phillips Curve slope (β) changes when different measures of inflation are used in place of the original core CPI (CPI-RS core) measure.

note: project description and paragraph are listed as writeup.md

---

## 1. Overview of the Extension

Hazell et al. (2022) argue that the Phillips Curve is very flat and stable over time.  
To explore the robustness of this result, I estimate the slope using **four different inflation series** available in the aggregated dataset:

- `pi_cpi_all` — Headline CPI inflation  
- `pi_cpi_lessfe` — CPI inflation excluding food & energy  
- `pi_pce_core` — Core PCE inflation  
- `pi_cpi_rs_core` — CPI-RS core inflation (used in the original paper’s aggregate figure)

I regress each inflation gap measure on cyclical unemployment (`urate_cyc`) and compare the estimated slopes across measures.

---

## 2. required software

- R (version 4.0 or later)
- RStudio (recommended for running the script and viewing outputs)

### Required R Packages
The script uses the following R packages:

- haven
- dplyr
- ggplot2

If these packages are not already installed on your system, install them using:

install.packages(c("haven", "dplyr", "ggplot2"))

These packages are automatically loaded at the top of the script.

---

## 3. Data

I use the publicly available dataset:

- **`agg_data.dta`**  
  Contains monthly/quarterly U.S. aggregate variables including CPI, PCE inflation, long-run expectations (SPF), and cyclical unemployment.  

This dataset comes from the replication files accompanying Hazell et al. (2022).  
All variables required for this extension are already included in the file.

---

## 4. Code

All analysis and figure generation is done in a single script:

- **`programs/analysis/Econ280_extension.R`** 

This script:

1. Loads `agg_data.dta`
2. Constructs four alternative inflation gap series  
3. Estimates four separate Phillips Curve slopes  
4. Builds a comparison table  
5. Produces a bar chart with slope estimates and error bars 

---

## 5. Outputs

Running `Econ280_extension.R` produces:

### **Figures**
- `output/Rplot_Econ280.png`  
  A bar chart comparing Phillips Curve slopes across inflation measures.

---

## 6. Instructions to Replicate

1. download  data/cleaned/agg_data.dta  
2. Open R or RStudio and modify the file path of line 7: agg_path <- "C:/Users/Keato/Downloads/agg_data.dta"
3. Run the script:

---

## 7. Reference

Hazell, Jonathon, Juan Herreño, Emi Nakamura, and Jón Steinsson. 2022.
“The Slope of the Phillips Curve: Evidence from U.S. States.”
Quarterly Journal of Economics 137(3): 1299–1344.


