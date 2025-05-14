# Load required packages
library(MASS)
library(ggplot2)
library(DHARMa)

# Assuming your model is named nb_model
# If not, replace nb_model with your model object

### 1. Overdispersion Test (printed in console, no plot) ###
overdisp_fun <- function(model) {
  rdf <- df.residual(model)
  rp <- residuals(model, type = "pearson")
  Pearson.chisq <- sum(rp^2)
  prat <- Pearson.chisq / rdf
  pval <- pchisq(Pearson.chisq, df = rdf, lower.tail = FALSE)
  cat("Pearson Chi-Square: ", Pearson.chisq, "\n")
  cat("Residual degrees of freedom: ", rdf, "\n")
  cat("Overdispersion ratio: ", prat, "\n")
  cat("p-value: ", pval, "\n")
}
overdisp_fun(nb_model)

### 2. Residuals vs. Fitted Plots ###
res_df <- data.frame(
  Fitted = fitted(nb_model),
  Pearson = residuals(nb_model, type = "pearson"),
  Deviance = residuals(nb_model, type = "deviance")
)

# Pearson residuals plot
p1 <- ggplot(res_df, aes(x = Fitted, y = Pearson)) +
  geom_point(alpha = 0.4) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(title = "Pearson Residuals vs. Fitted", x = "Fitted Values", y = "Pearson Residuals") +
  theme_minimal()
ggsave("pearson_residuals_plot.png", plot = p1, width = 6, height = 4, dpi = 300)

# Deviance residuals plot
p2 <- ggplot(res_df, aes(x = Fitted, y = Deviance)) +
  geom_point(alpha = 0.4) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(title = "Deviance Residuals vs. Fitted", x = "Fitted Values", y = "Deviance Residuals") +
  theme_minimal()
ggsave("deviance_residuals_plot.png", plot = p2, width = 6, height = 4, dpi = 300)

### 3. Cook's Distance Plot ###
png("cooks_distance_plot.png", width = 1800, height = 1200, res = 300)
cooks <- cooks.distance(nb_model)
plot(cooks, type = "h", main = "Cook's Distance", ylab = "Cook's Distance")
abline(h = 4 / length(cooks), col = "red", lty = 2)
legend("topright", legend = "Threshold 4/n", col = "red", lty = 2, bty = "n")
dev.off()

### 4. DHARMa Simulation-Based Diagnostics ###
sim_res <- simulateResiduals(fittedModel = nb_model, n = 1000)

# Overall residual diagnostic plot from DHARMa
png("DHARMa_residuals_plot.png", width = 1800, height = 1200, res = 300)
plot(sim_res)
dev.off()

# Dispersion test
disp_test <- testDispersion(sim_res)
capture.output(disp_test, file = "DHARMa_dispersion_test.txt")

# Zero inflation test
zi_test <- testZeroInflation(sim_res)
capture.output(zi_test, file = "DHARMa_zero_inflation_test.txt")

# Outlier test
outlier_test <- testOutliers(sim_res)
capture.output(outlier_test, file = "DHARMa_outlier_test.txt")
