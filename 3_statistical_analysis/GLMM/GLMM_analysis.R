library(dplyr)
library(lme4)
library(DHARMa)
library(ggplot2)
library(visreg) 
library(glmmTMB)
library(arm)
library(performance)
library(MuMIn)

# Load data_60s.RData first

# Step 1 : Set up spreadsheet with categorical variables

data_60s_bin <- data_60s %>%
  mutate(
    # 1. Add Time_of_Day_bin
    Time_of_Day_bin = case_when(
      Time_of_Day >= 20 | Time_of_Day <= 5  ~ "Night",
      Time_of_Day >= 6  & Time_of_Day <= 9  ~ "Morning",
      Time_of_Day >= 10 & Time_of_Day <= 13 ~ "Midday",
      Time_of_Day >= 14 & Time_of_Day <= 17 ~ "Afternoon",
      Time_of_Day >= 18 & Time_of_Day <= 19 ~ "Evening",
      TRUE ~ NA_character_
    ),
    
    # 2. Create DiveStates_bin: set to 5 if it contains "_", else convert to numeric
    DiveStates_bin = ifelse(
      grepl("_", as.character(DiveStates)), 
      5, 
      as.numeric(as.character(DiveStates))
    )
  )

# Step 2: Create model(s)

# Make sure factor columns are treated properly
data_60s_bin$Time_of_Day_bin <- as.factor(data_60s_bin$Time_of_Day_bin)
data_60s_bin$DiveStates_bin <- as.factor(data_60s_bin$DiveStates_bin)  # or leave as numeric if continuous
data_60s_bin$Time <- as.factor(data_60s_bin$Time)

# Run the GLMM (binomial family for binary Calling) - random intercept for TagNum
glmm_model_1 <- glmer(
  Calling ~ Time_of_Day_bin + DiveStates_bin + (1 | TagNum),
  data = data_60s_bin,
  family = binomial
)

glmm_model_2 <- glmer(
  Calling ~ 0 + Time_of_Day_bin + DiveStates_bin + (1 | TagNum),
  data = data_60s_bin,
  family = binomial
)

glmm_model_3 <- glmmTMB(
  Calling ~ 0 + Time_of_Day_bin + DiveStates_bin + ar1(Time + 0 | TagNum),
  data = data_60s_bin,
  family = binomial()
)

# Account for overdispersion
glmm_model_4 <- glmmTMB(
  Calling ~ 0 + Time_of_Day_bin + DiveStates_bin + ar1(Time + 0 | TagNum),
  data = data_60s_bin,
  family = betabinomial(link = "logit")
)

data_60s_bin$ObsID <- factor(seq_len(nrow(data_60s_bin)))

glmm_model_5 <- glmmTMB(
  Calling ~ 0 + Time_of_Day_bin + DiveStates_bin + (1 | TagNum) + (1 | ObsID),
  data = data_60s_bin,
  family = binomial()
)

glmm_model_6 <- glmmTMB(
  Calling ~ 0 + Time_of_Day_bin + DiveStates_bin + (1 | TagNum) + (1 | ObsID),  
  data = data_60s_bin,  
  family = binomial,  
  dispformula = ~ ar1(time = Time | TagNum) 
  )

glmm_model_7 <- glmmTMB(
  Calling ~ Time_of_Day_bin + DiveStates_bin + (1 | TagNum) + (1 | ObsID),  
  data = data_60s_bin,  
  family = binomial,  
  dispformula = ~ ar1(time = Time | TagNum) 
)

# Checking reference
levels(data_60s_bin$Time_of_Day_bin)
# Change reference
data_60s_bin$Time_of_Day_bin <- relevel(data_60s_bin$Time_of_Day_bin, ref = "Morning")

# View summary
summary(glmm_model_1)
summary(glmm_model_2)
summary(glmm_model_3)
summary(glmm_model_4)
summary(glmm_model_5)
summary(glmm_model_6)
summary(glmm_model_7)

# Step 3: Diagnostics (includes residual vs predicted plots, QQ plot, test for dispersion and zero inflation)

# Simulate residuals
sim_res_1 <- simulateResiduals(fittedModel = glmm_model_1)

# Plot diagnostic summary
plot(sim_res_1)

# Simulate residuals
sim_res_2 <- simulateResiduals(fittedModel = glmm_model_2)

# Plot diagnostic summary
plot(sim_res_2)

# Simulate residuals
sim_res_3 <- simulateResiduals(fittedModel = glmm_model_3)

# Plot diagnostic summary
plot(sim_res_3)

# Simulate residuals
sim_res_4 <- simulateResiduals(fittedModel = glmm_model_4)

# Plot diagnostic summary
plot(sim_res_4)

# Simulate residuals
sim_res_5 <- simulateResiduals(fittedModel = glmm_model_5)

# Plot diagnostic summary
plot(sim_res_5)

acf(resid_pearson, main = "ACF of Pearson Residuals")

# Simulate residuals
sim_res_6 <- simulateResiduals(fittedModel = glmm_model_6)

# Plot diagnostic summary
plot(sim_res_6)

resids_pearson_6 <- residuals(glmm_model_6, type = "pearson")
acf(resids_pearson_6, main = "ACF of Pearson Residuals")
resids_deviance_6 <- residuals(glmm_model_6, type = "deviance")
acf(resids_deviance_6, main = "ACF of Deviance")

# Simulate residuals
sim_res_7 <- simulateResiduals(fittedModel = glmm_model_7)

# Plot diagnostic summary
plot(sim_res_7)

resids_pearson_7 <- residuals(glmm_model_7, type = "pearson")
acf(resids_pearson_7, main = "ACF of Pearson Residuals")
resids_deviance_7 <- residuals(glmm_model_7, type = "deviance")
acf(resids_deviance_7, main = "ACF of Deviance")

dispersion_ratio_model7 <- deviance(glmm_model_7) / df.residual(glmm_model_7)
print(dispersion_ratio_model7)

# Binned residual plot

# For glmer model
binnedplot(
  x = fitted(glmm_model_7),
  y = resid(glmm_model_7, type = "response"),
  xlab = "Expected Values",
  ylab = "Average Residual",
  main = "Binned Residual Plot"
)

##### TESTING 
# Step 1: Simulate residuals for the full model
sim_res <- simulateResiduals(fittedModel = glmm_model_4)

# Step 2: Recalculate residuals, grouped by Time
sim_res_grouped <- recalculateResiduals(sim_res, group = data_60s_bin$Time)

# Step 3: Get time values in the same order as the grouped residuals
# This works because recalculateResiduals collapses by factor order of `group`
time_grouped <- sort(unique(data_60s_bin$Time))

# Step 4: Test autocorrelation
testTemporalAutocorrelation(sim_res_grouped, time = time_grouped)

# Step 4: Plot Predictions

## FIGURE VERSION 1 - bar plots
# Create a new data frame for predictions
newdata <- expand.grid(
  Time_of_Day_bin = levels(data_60s_bin$Time_of_Day_bin),
  DiveStates_bin = levels(as.factor(data_60s_bin$DiveStates_bin)),
  TagNum = unique(data_60s_bin$TagNum)[2]  # use one tag for fixed random effect
)

# Get predicted probabilities
newdata$predicted <- predict(glmm_model_2, newdata = newdata, type = "response", re.form = NA)

# Plot
ggplot(newdata, aes(x = DiveStates_bin, y = predicted, fill = Time_of_Day_bin)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Predicted Calling Probability",
       x = "Dive State Bin",
       y = "Predicted Probability of Calling") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2")

# FIGURE VERSION 2: with CI

# Step 1: Create new data for prediction
newdata <- expand.grid(
  Time_of_Day_bin = levels(data_60s_bin$Time_of_Day_bin),
  DiveStates_bin = levels(as.factor(data_60s_bin$DiveStates_bin)),
  Time = levels(as.factor(data_60s_bin$Time)),
  TagNum = unique(data_60s_bin$TagNum)[2]  # Hold TagNum constant
)

# Step 2: Predict using glmer model with confidence intervals
predictions <- predict(glmm_model_7, newdata = newdata, type = "link", se.fit = TRUE, re.form = NA)

# Step 3: Convert to response scale (logit -> probability)
newdata <- newdata %>%
  mutate(
    fit_link = predictions$fit,
    se_link = predictions$se.fit,
    lower = plogis(fit_link - 1.96 * se_link),
    upper = plogis(fit_link + 1.96 * se_link),
    predicted = plogis(fit_link)
  )
newdata$DiveStates_bin <- factor(newdata$DiveStates_bin,
                                 levels = c("0", "1", "2", "3", "5"),
                                 labels = c("Surface", "Descent", "Ascent", "Bottom Phase", "Transition"))
axis.text.x = element_text(angle = 45, hjust = 1)
ggplot(newdata, aes(x = DiveStates_bin, y = predicted, color = Time_of_Day_bin, group = Time_of_Day_bin)) +
  geom_line(size = 1.2) +
  geom_ribbon(aes(ymin = lower, ymax = upper, fill = Time_of_Day_bin), alpha = 0.2, color = NA) +
  labs(
    x = "Dive State",
    y = "Predicted Probability of Calling",
    color = "Time of Day",
    fill = "Time of Day"
  ) +
  theme_minimal() +
  theme(text = element_text(size = 14)) +
  scale_color_brewer(palette = "Set2") +
  scale_fill_brewer(palette = "Set2")

ggsave("glmm_fig_7.png", plot = glmm_fig, 
       width = 8, height = 6, units = "in", dpi = 300)


### Reportable values
r2(glmm_model_7)
r.squaredGLMM(glmm_model_7)

glmm_model_reduced <- update(glmm_model_7, . ~ . - (1 | ObsID))
r.squaredGLMM(glmm_model_reduced)