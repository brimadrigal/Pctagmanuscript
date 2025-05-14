# Load necessary libraries
library(R.matlab)  # For reading .mat files
library(ggplot2)   # For plotting
library(boot)      # For bootstrapping (confidence interval estimation)
library(gridExtra)
library(DHARMa)
library(MASS)

data <- read.csv("all_tag_callrates_divestates.csv") # 1732 rows initially before zeros removed. Was all_calls.csv but decided to use this one so could see when zeros removed
# Remove rows where Call_rate is 0
data <- data[data$Call_rate != 0, ]

data_bin$DiveStates_bin <- ifelse(
  grepl("_", as.character(data_bin$Dive_state_mode)),
  5,
  as.numeric(as.character(data_bin$Dive_state_mode))
)
################# Figure 5a - Speed

# Negative Binomial Regression
# Load necessary packages

data$Dive_state_mode <- as.factor(data$Dive_state_mode)

# Fit negative binomial regression with both predictors
nb_model <- glm.nb(Call_rate ~ + Speed_average + factor(DiveStates_bin), data = data_bin)
#nb_model_inter <- glm.nb(Call_rate ~ 0 + Speed_average * Dive_state_mode, data = data) #testing if interaction

# Summary of the model
summary(nb_model)
summary(nb_model_inter)

########## Test polynomials and assess which one is best based on  AIC
library(MASS)  # for glm.nb

# Initialize a results data frame
aic_results <- data.frame(
  Poly_Speed = integer(),
  AIC = numeric()
)

# Loop over polynomial degrees 1 to 4 for Speed_average only
for (deg_speed in 1:3) {
  
  # Fit the negative binomial model
  model <- glm.nb(Call_rate ~
                    poly(Speed_average, degree = deg_speed, raw = TRUE) + 
                    Depth_average + 
                    Dive_state_mode,
                  data = data_bin)
  
  # Store the results
  aic_results <- rbind(aic_results, data.frame(
    Poly_Speed = deg_speed,
    AIC = AIC(model)
  ))
}

# Print all AIC results
print(aic_results)

# Identify and print the best model (lowest AIC)
best_model <- aic_results[which.min(aic_results$AIC), ]
print(best_model)

########################## SPEED prediction and plot
# Ensure Tag_num is a factor with custom labels
data_bin$Tag_num <- as.factor(data_bin$Tag_num)
levels(data_bin$Tag_num) <- c("HIPc706", "HIPc265", "HIPc805")  # Assuming original levels were 2, 3, 4

# Filter data to only include Dive_states 0, 1, 2, 3, 5
filtered_data <- data_bin %>%
  filter(DiveStates_bin %in% c("0", "1", "2", "3", "5"))

# Create prediction grid across Speed_average and Dive_state_mode
newdata_speed <- expand.grid(
  Speed_average = seq(min(filtered_data$Speed_average, na.rm = TRUE), 
                      max(filtered_data$Speed_average, na.rm = TRUE), 
                      length.out = 100),
  DiveStates_bin = c("0", "1", "2", "3", "5")
)

#newdata_speed$DiveStates_bin <- as.numeric(as.character(newdata_speed$DiveStates_bin))

# Predict with SE for each combination
pred_speed <- predict(nb_model, newdata = newdata_speed, type = "link", se.fit = TRUE)

# Add prediction results to newdata_speed
newdata_speed$fit <- pred_speed$fit
newdata_speed$se <- pred_speed$se.fit
newdata_speed$lower <- exp(newdata_speed$fit - 1.96 * newdata_speed$se)
newdata_speed$upper <- exp(newdata_speed$fit + 1.96 * newdata_speed$se)
newdata_speed$predicted <- exp(newdata_speed$fit)

# Plot with facets (2x2 grid) for Dive_state_mode and rug plot
final_speed_plot <- ggplot() +
  # Observed points, colored by Tag_num
  geom_point(data = filtered_data, 
             aes(x = Speed_average, y = Call_rate, color = Tag_num), shape = 16) +
  # Predicted line and ribbon
  geom_line(data = newdata_speed, 
            aes(x = Speed_average, y = predicted), 
            color = "black", size = 1.2) +
  geom_ribbon(data = newdata_speed, 
              aes(x = Speed_average, ymin = lower, ymax = upper), 
              alpha = 0.2, fill = "grey70") +
  # Rug plot along x-axis
  geom_rug(data = filtered_data, 
           aes(x = Speed_average, color = Tag_num), 
           alpha = 0.5, sides = "b") +
  # Facet with custom labels
  facet_wrap(~ DiveStates_bin, ncol = 3, nrow = 2, scales = "fixed",
             labeller = as_labeller(c(
               "0" = "Surface",
               "1" = "Descent",
               "2" = "Ascent",
               "3" = "Bottom Phase",
               "5" = "Transition"
             ))) +
  labs(x = "Average Speed (m/s)", y = "Predicted Call Rate (calls/min)",
       color = "Animal") +
  scale_color_manual(values = c("#2A9D8F", "#E9C46A", "#E76F51"),
                     labels = c("HIPc706", "HIPc265", "HIPc805")) +
  theme_minimal() +
  theme(strip.text = element_text(size = 12),
        legend.position = "right")

print(final_speed_plot)

ggsave("nbr_speed.png", plot = final_speed_plot, 
       width = 8, height = 6, units = "in", dpi = 300)

###### Dive State prediction and plot

# ✅ Make sure Dive_state_mode is a factor
data_bin$DiveStates_bin <- as.factor(data_bin$DiveStates_bin)

# ✅ Filter data to only include Dive_state_mode 0, 1, 2, 3
filtered_data_state <- data_bin %>%
  filter(DiveStates_bin %in% c("0", "1", "2", "3", "5"))

# ✅ Create prediction grid — must include Speed_average because your model includes it!
newdata_state <- data.frame(
  DiveStates_bin = c("0", "1", "2", "3", "5"),
  Speed_average = median(data$Speed_average, na.rm = TRUE)  # Hold Speed_average constant
)

# ✅ Predict with SE for each Dive_state_mode (with Speed_average constant)
pred_state <- predict(nb_model, newdata = newdata_state, type = "link", se.fit = TRUE)

# ✅ Add prediction results to newdata_state
newdata_state$fit <- pred_state$fit
newdata_state$se <- pred_state$se.fit
newdata_state$lower <- exp(newdata_state$fit - 1.96 * newdata_state$se)
newdata_state$upper <- exp(newdata_state$fit + 1.96 * newdata_state$se)
newdata_state$predicted <- exp(newdata_state$fit)

# ✅ Calculate observed means for each Dive_state_mode and Tag_num
observed_means_state <- filtered_data_state %>%
  group_by(DiveStates_bin, Tag_num) %>%
  summarize(mean_call_rate = mean(Call_rate, na.rm = TRUE), .groups = 'drop')

# Bar plot of predicted call rate by Dive_state_mode with custom colors
final_divestate_plot <- ggplot() +
  # Predicted bars with custom fill color for each dive state
  geom_col(data = newdata_state, 
           aes(x = DiveStates_bin, y = predicted, fill = DiveStates_bin), color = "black") +
  # Observed means as dots, colored by Tag_num
  geom_point(data = observed_means_state, 
             aes(x = DiveStates_bin, y = mean_call_rate, color = Tag_num), 
             position = position_jitter(width = 0.2), 
             size = 2, shape = 16) +
  # Error bars for 95% CI
  geom_errorbar(data = newdata_state, 
                aes(x = DiveStates_bin, ymin = lower, ymax = upper), 
                width = 0.2) +
  labs(x = "Dive State", y = "Predicted Call Rate (calls/min)",
       fill = "Dive State Mode", color = "Tag Number") +
  scale_fill_manual(values = c("0" = "#A8DADC", 
                               "1" = "#457B9D", 
                               "2" = "#1D3557", 
                               "3" = "#E63946",
                               "5" = "grey")) +
  scale_color_manual(values = c("#2A9D8F", "#E9C46A", "#E76F51"),
                     labels = c("HIPc706", "HIPc265", "HIPc805")) +
  theme_minimal() +
  theme(strip.text = element_text(size = 12),
        legend.position = "right")

print(final_divestate_plot)
ggsave("nbr_divestate.png", plot = final_divestate_plot, 
       width = 8, height = 6, units = "in", dpi = 300)



# -----------------------------------------------------
# Attempt with new labels: 

final_divestate_plot_labels <- ggplot() +
  # Predicted bars with custom fill color for each dive state
  geom_col(data = newdata_state, 
           aes(x = DiveStates_bin, y = predicted, fill = DiveStates_bin), color = "black") +
  # Observed means as dots, colored by Tag_num
  geom_point(data = observed_means_state, 
             aes(x = DiveStates_bin, y = mean_call_rate, color = Tag_num), 
             position = position_jitter(width = 0.2), 
             size = 2, shape = 16) +
  # Error bars for 95% CI
  geom_errorbar(data = newdata_state, 
                aes(x = DiveStates_bin, ymin = lower, ymax = upper), 
                width = 0.2) +
  labs(x = "Dive State", y = "Predicted Call Rate (calls/min)",
       fill = "Dive Phase", color = "Tag Number") +
  scale_x_discrete(labels = c("0" = "Surface", 
                              "1" = "Descent", 
                              "2" = "Ascent", 
                              "3" = "Bottom Phase",
                              "5" = "Transition")) +
  scale_fill_manual(values = c("0" = "#A8DADC", 
                               "1" = "#457B9D", 
                               "2" = "#1D3557", 
                               "3" = "#E63946",
                               "5" = "grey"),
                    labels = c("0" = "Surface", 
                               "1" = "Descent", 
                               "2" = "Ascent", 
                               "3" = "Bottom Phase",
                               "5" = "Transition")) +
  scale_color_manual(values = c("#2A9D8F", "#E9C46A", "#E76F51"),
                     labels = c("HIPc706", "HIPc265", "HIPc805")) +
  theme_minimal() +
  theme(strip.text = element_text(size = 12),
        legend.position = "right")

print(final_divestate_plot_labels)
ggsave("nbr_divestate.png", plot = final_divestate_plot_labels, 
       width = 8, height = 6, units = "in", dpi = 300)