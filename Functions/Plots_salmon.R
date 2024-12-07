# salmon plots

salmon_escapement <- colSums(round(escape_salmon[2:ncol(escape_salmon)]))
salmon_catch <- colSums(round(fished_salmon[2:ncol(fished_salmon)]))
salmon_eaten <- colSums(round(eaten_salmon[2:ncol(eaten_salmon)]))

plot_consumed <- makePlot_2(x = 1:days + (start_loop - 1), x.name = "Day", y = consumed_total, y.name = "Daily Salmon Consumed", 
                            color = "dodgerblue")

# Plots of Salmon Species data



escape_plot <- makePlot_4(data = round(escape_salmon), variable.name = "Run", 
                          value.name = "Daily Salmon Escaped", colors = colors_salmon,
                          loop_days = F, start_loop = start_loop)
eaten_sp_plot <- makePlot_4(data = round(eaten_salmon), variable.name = "Run", 
                          value.name = "Daily Salmon Eaten", colors = colors_salmon,
                          loop_days = F, start_loop = start_loop)
gauntlet_plot <- makePlot_4(data = round(salmon_list), variable.name = "Run", 
                            value.name = "Daily Salmon at Gauntlet", colors = colors_salmon,
                            loop_days = F, start_loop = start_loop)
fished_plot <- makePlot_4(data = round(fished_salmon), variable.name = "Run", 
                          value.name = "Daily Salmon Fished", colors = colors_salmon,
                          loop_days = F, start_loop = start_loop)

# eaten_sp_plot <- makePlot_3(x = 1:days + (start_loop - 1), data = cbind(eaten_chinook, eaten_sockeye, eaten_coho),
#                             col.names = c("Day", "Chinook", "Sockeye", "Coho"), variable.name = "Species", 
#                             value.name = "Daily Salmon Eaten", colors = colors_salmon)
# gauntlet_plot <- makePlot_3(x = 1:days + (start_loop - 1), data = cbind(gauntlet_chinook, gauntlet_sockeye, gauntlet_coho),
#                             col.names = c("Day", "Chinook", "Sockeye", "Coho"), variable.name = "Species", 
#                             value.name = "Daily Salmon at Gauntlet", colors = colors_salmon)
# fished_plot <- makePlot_3(x = 1:days + (start_loop - 1), data = cbind(fished_chinook, fished_sockeye, fished_coho), 
#                           col.names = c("Day", "Chinook", "Sockeye", "Coho"), variable.name = "Species",
#                           value.name = "Daily Salmon Fished", colors = colors_salmon)