## Functions for creating plots with similar structures


library(reshape2)
library(ggplot2)
library(patchwork)
library(kableExtra)
library(paletteer)
# library(colorblindr)


# plot_x_range <- start_loop:end_loop

prepForPlots <- function(df, key.col = "Seal", 
                         other.cols = "Day", value.col, offset = (start_loop - 1)){
  melted <- melt(data = df, key.col)
  colnames(melted) <- c(key.col, other.cols, value.col)
  melted[,key.col] <- as.factor(melted[,key.col])
  melted$Day <- melted$Day  + offset
  return(melted)
}

# dummy for colors
prob_gauntlet_plot <- prepForPlots(seal_prob_gauntlet, value.col = "Prob_G")

# Make Palette
colors <- rep(RColorBrewer::brewer.pal(10, "Set3"), length.out = num_seals)
color.names <- levels(prob_gauntlet_plot[,"Seal"])
names(colors) <- color.names

if(num_zc > 0){
  colors_zc <- rep(RColorBrewer::brewer.pal(10, "Set3"), length.out = num_zc)
  color.names.zc <- 1:num_zc
  names(colors_zc) <- color.names.zc
}

if(num_ej > 0){
  colors_ej <- rep(RColorBrewer::brewer.pal(10, "Set3"), length.out = num_ej)
  color.names.ej <- 1:num_ej
  names(colors_ej) <- color.names.ej
}


# colors_salmon <- paletteer_d("IslamicArt::alhambra", n = 6)
# colors_salmon <- paletteer_d("Manu::Kereru", n = 6)
# colors_salmon <- paletteer_d("calecopal::chaparral1", n = 6)
# colors_salmon <- paletteer_d("dutchmasters::pearl_earring")[c(1,2,3,4,6,10)]
# colors_salmon <- paletteer_d("feathers::rose_crowned_fruit_dove")[c(1,2,3,5,6,8)]
# colors_salmon <- c("dodgerblue", "orchid1", "turquoise1", "goldenrod", "orchid4", "lightseagreen")
# colors_salmon <- c("mediumblue", "dodgerblue2", "yellow2", "sienna1", "red2", "magenta2")
# colors_salmon <- paletteer_d("nationalparkcolors::Saguaro")
# colors_salmon <- paletteer_d("nationalparkcolors::DeathValley")
# colors_salmon <- c(paletteer_d("nationalparkcolors::MtRainier"), "#554C6CFF")
colors_salmon <- paletteer_d("PNWColors::Sailboat")
# check out facelift on https://github.com/johnmackintosh/rockthemes



# Plotting Function - individual seal dots
makePlot_1 <- function(data, value.col, colors, legend.inc = F){
  data_for_plot <- prepForPlots(data, value.col = value.col)
  plot <- ggplot(data = data_for_plot, aes(x = data_for_plot[,2], 
                                           y = data_for_plot[,3], color = data_for_plot[,1])) + 
    geom_point() +
    scale_color_manual(values = colors) +
    theme_classic() + 
    theme(legend.position = "none") +
    labs(y = names(data_for_plot)[3], x = names(data_for_plot)[2], color = names(data_for_plot)[1])
  if(legend.inc == T){
    plot <- plot + theme(legend.position = "right")
  }
  return(plot)
}

# Plotting Function - one dimension
makePlot_2 <- function(x, x.name, y, y.name, color, legend.inc = F){
  data_for_plot <- data.frame(col1 = x, col2 = y)
  colnames(data_for_plot) <- c(x.name, y.name)
  plot <- ggplot(data = data_for_plot, aes(x = data_for_plot[,1], y = data_for_plot[,2])) + 
    geom_point(color = color) +
    theme_classic() + 
    theme(legend.position = "none") +
    labs(y = names(data_for_plot)[2], x = names(data_for_plot)[1])
  if(legend.inc == T){
    plot <- plot + theme(legend.position = "right")
  }
  return(plot)
}

# Plotting Function - salmon species data 3D

makePlot_3 <- function(x, data, col.names, variable.name, value.name, colors, legend.inc = F){
  data_for_melt <- data.frame(cbind(x, data))
  colnames(data_for_melt) <- col.names
  data_for_plot <- melt(data = data_for_melt, id.vars = col.names[1], variable.name = variable.name, value.name = value.name)
  plot <- 
    ggplot(data = data_for_plot) + 
    geom_point(aes(x = data_for_plot[,1], y = data_for_plot[,3], color = data_for_plot[,2])) +
    scale_color_manual(values = colors) +
    theme_classic() + 
    theme(legend.position = "none") +
    labs(y = value.name, x = col.names[1], color = variable.name)
  if(legend.inc == T){
    plot <- plot + theme(legend.position = "right")
  }
  return(plot)
}

# same as above but data is already in a df with day column
makePlot_4 <- function(data, variable.name = "Run", value.name, colors, legend.inc = F, loop_days = F, start_loop = 1){
  data_for_plot <- melt(data = data, id.vars = colnames(data)[1], variable.name = variable.name, value.name = value.name)
  data_for_plot[,2] <- as.factor(data_for_plot[,2])
  if(loop_days == T){
    data_for_plot[,1] <- data_for_plot[,1] + (start_loop - 1)
  }
  plot <- 
    ggplot(data = data_for_plot) + 
    geom_point(aes(x = data_for_plot[,1], y = data_for_plot[,3], color = data_for_plot[,2])) +
    scale_color_manual(values = colors) +
    theme_classic() + 
    theme(legend.position = "none") +
    labs(y = value.name, x = colnames(data)[1], color = variable.name)
  if(legend.inc == T){
    plot <- plot + theme(legend.position = "right")
  }
  return(plot)
}
