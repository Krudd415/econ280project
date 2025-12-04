
library(haven)
library(dplyr)
library(ggplot2)


agg_path <- "C:/Users/Keato/Downloads/agg_data.dta"
agg <- read_dta(agg_path)

agg_ext <- agg %>%
  filter(year >= 1980) %>%
  arrange(time) %>%
  mutate(
    lhs_cpi_all     = pi_cpi_all     - spf_cpi_lt,
    lhs_cpi_lessfe  = pi_cpi_lessfe  - spf_cpi_lt,
    lhs_pce_core    = pi_pce_core    - spf_cpi_lt,
    lhs_cpi_rs_core = pi_cpi_rs_core - spf_cpi_lt
  ) %>%
  select(time, year, urate_cyc,
         lhs_cpi_all, lhs_cpi_lessfe,
         lhs_pce_core, lhs_cpi_rs_core) %>%
  filter(complete.cases(.))

models <- list(
  CPI_all     = lm(lhs_cpi_all    ~ urate_cyc, data = agg_ext),
  CPI_lessFE  = lm(lhs_cpi_lessfe ~ urate_cyc, data = agg_ext),
  PCE_core    = lm(lhs_pce_core   ~ urate_cyc, data = agg_ext),
  CPI_RS_core = lm(lhs_cpi_rs_core~ urate_cyc, data = agg_ext)
)

ext_table <- do.call(rbind, lapply(names(models), function(name) {
  m <- models[[name]]
  data.frame(
    Inflation_Measure = name,
    Beta_Slope        = coef(m)[["urate_cyc"]],
    Std_Error         = sqrt(diag(vcov(m)))[["urate_cyc"]],
    R2                = summary(m)$r.squared,
    N                 = length(residuals(m))
  )
}))

print(ext_table)

#Bar Chart below

ext_table$Inflation_Measure <- factor(
  ext_table$Inflation_Measure,
  levels = c("CPI_all", "CPI_lessFE", "PCE_core", "CPI_RS_core")
)

pc_plot <- ggplot(ext_table, aes(x = Inflation_Measure, y = Beta_Slope)) +
  geom_col(fill = "steelblue", alpha = 0.8) +
  geom_errorbar(aes(ymin = Beta_Slope - Std_Error,
                    ymax = Beta_Slope + Std_Error),
                width = 0.15, colour = "black") +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(
    title = "Phillips Curve Slope Across Inflation Measures",
    x = "Inflation Measure",
    y = "Estimated Phillips Curve Slope"
  ) +
  theme_minimal(base_size = 13)

print(pc_plot)