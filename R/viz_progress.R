
library(tidyverse)
library(ggforce)
library(ggpol)
library(marquee)

for(i in seq_along(unique(df_hia_actions_orig$city))){
  
  text_city <- unique(df_hia_actions_orig$city)[i]
  
  df_viz <- df_hia_actions_orig |> 
    filter(city == text_city) |> 
    mutate(status = factor(status, 
                           levels = c("Basic", "Progressing", "Achieving"))) |> 
    count(city, status, .drop = FALSE) |> 
    mutate(percentage = round(n / sum(n) * 100, digits = 0)) |> 
    filter(!is.na(status))
  
  library(fontawesome)
  viz <- ggplot(df_viz) + 
    geom_arcbar(aes(shares = percentage, 
                    r0 = 5, r1 = 10, 
                    fill = status), 
                sep = 0.05, show.legend = FALSE) + 
    scale_fill_manual(values = c("Basic" = "grey",
                                 "Progressing" = c40_colors("blue"),
                                 "Achieving" = c40_colors("green"))) +
    guides(fill = guide_legend(reverse=TRUE)) +
    coord_fixed() +
    theme_void() +
    labs(title = glue(
    "<span style = 'color: {c40_colors('green')};'>  {df_viz$percentage[df_viz$status == 'Achieving']}% Implemented</span> <br>
    <span style = 'color: {c40_colors('blue')};'> {df_viz$percentage[df_viz$status == 'Progressing']}% Progressing</span> <br>
    <span style = 'color: grey;'> {df_viz$percentage[df_viz$status == 'Basic']}% Basic</span>")) +
    theme(
      text = element_text(family = "Montserrat"),
      plot.title = ggtext::element_markdown(size = rel(1.5), margin = margin(0,0,20,0), face = "bold")
      )

    
  
  ggsave(plot = viz,
         path = "output_viz_arcbar", 
         filename = glue::glue("viz_arcbar_{text_city}.png"), width = 4, height = 4, units = "in")
}
