# salmon plots script

# set up
# salmon.colors <- c("steelblue3", "darkseagreen3", "goldenrod")
# Okabe-Ito palette for color blindness?
salmon.colors <- c("#56B4E9", "#009E73", "#E69F00")
salmon.names <- c("Chinook", "Sockeye", "Coho")
names(salmon.colors) <- salmon.names
salmon_theme <- theme_classic()

# fit to data

Chosen_fish_int$DayofYear <- factor(Chosen_fish_int$DayofYear)
colnames(Chosen_fish_int) <- c("DayofYear", "Chinook", "Sockeye", "Coho")
long_counts <- gather(Chosen_fish_int[,1:4], key = Species, value = Arrival, Chinook:Coho, factor_key = T)
long_counts$DayofYear <- as.numeric(long_counts$DayofYear) + (start_loop - 1)

The_Fish$DayofYear <- factor(The_Fish$DayofYear)
long_fitted <- gather(The_Fish, key = Species, value = Fitted, Sockeye:Coho, factor_key = T)
long_fitted$DayofYear <- as.numeric(long_fitted$DayofYear) + (start_loop - 1)

plot.arrival.data <- ggplot() +
  geom_point(data = long_counts, aes(x = DayofYear, y = Arrival, color = Species), shape = 1) + 
  geom_line(data = long_fitted, aes(x = DayofYear, y = Fitted, color = Species), lwd = 1.2) +
  scale_color_manual(values = salmon.colors) +
  labs(x = "Day of Year", y = "Arriving Salmon (Fitted)") +
  salmon_theme
plot.arrival.data

# basic summaries

salmon_escapement <- data.frame(Sockeye = escape_sockeye[days], Chinook = escape_chinook[days],
                                Coho = escape_coho[days])
salmon_catch <- data.frame(Sockeye = sum(fished_sockeye), Chinook = sum(fished_chinook),
                           Coho = sum(fished_coho))
salmon_eaten <- data.frame(Sockeye = sum(eaten_sockeye), Chinook = sum(eaten_chinook),
                           Coho = sum(eaten_coho))
residence_table <- data.frame(c(Sockeye = sockeye_residence, Chinook = chinook_residence, Coho = coho_residence))
colnames(residence_table) <- "Days"

plot_consumed <- makePlot_2(x = 1:days + (start_loop - 1), x.name = "Day", y = consumed_total, y.name = "Daily Salmon Consumed", 
                            color = "dodgerblue")

# Plots of Salmon Species data

escape_plot <- makePlot_3(x = 1:days + (start_loop - 1), data = cbind(escape_chinook, escape_sockeye, escape_coho),
                          col.names = c("Day", "Chinook", "Sockeye", "Coho"), variable.name = "Species", 
                          value.name = "Cumulative Escaped Salmon", colors = salmon.colors)
eaten_sp_plot <- makePlot_3(x = 1:days + (start_loop - 1), data = cbind(eaten_chinook, eaten_sockeye, eaten_coho),
                            col.names = c("Day", "Chinook", "Sockeye", "Coho"), variable.name = "Species", 
                            value.name = "Salmon Eaten", colors = salmon.colors)
gauntlet_plot <- makePlot_3(x = 1:days + (start_loop - 1), data = cbind(gauntlet_chinook, gauntlet_sockeye, gauntlet_coho),
                            col.names = c("Day", "Chinook", "Sockeye", "Coho"), variable.name = "Species", 
                            value.name = "Salmon at Gauntlet", colors = salmon.colors)
fished_plot <- makePlot_3(x = 1:days + (start_loop - 1), data = cbind(fished_chinook, fished_sockeye, fished_coho), 
                          col.names = c("Day", "Chinook", "Sockeye", "Coho"), variable.name = "Species",
                          value.name = "Salmon Fished", colors = salmon.colors)