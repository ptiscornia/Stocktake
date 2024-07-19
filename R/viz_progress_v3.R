


source("R/00-libraries.R")
source("R/01-extrac.R")

gg.gauge <- function(pos,breaks=c(0,30,70,100)) {
  require(ggplot2)
  require(c40tools)
  require(glue)
  
  get.poly <- function(a,b,r1=0.5,r2=1) {
    th.start <- pi*(1-a/100)
    th.end   <- pi*(1-b/100)
    th       <- seq(th.start,th.end,length=100)
    x        <- c(r1*cos(th),rev(r2*cos(th)))
    y        <- c(r1*sin(th),rev(r2*sin(th)))
    return(data.frame(x,y))
  }
  ggplot()+ 
    geom_polygon(data=get.poly(breaks[1],breaks[2]),aes(x,y),fill = c40_colors("red"))+
    geom_polygon(data=get.poly(breaks[2],breaks[3]),aes(x,y),fill = c40_colors("blue"))+
    geom_polygon(data=get.poly(breaks[3],breaks[4]),aes(x,y),fill = c40_colors("green"))+
    geom_polygon(data=get.poly(pos-1,pos+1,0.2),aes(x,y), fill = "black")+
    geom_text(data = as.data.frame(breaks), 
              size = 4.5, fontface = "bold", vjust = 0.4,
              aes(x = 1.1 * cos(pi * (1-breaks/100)),
                  y = 1.1 * sin(pi * (1-breaks/100)),
                  #label = paste0(breaks, "%")
                  label = glue("{breaks}%")
              ))+
    annotate("text",
             x = 0, y = 0, 
             label = pos, 
             vjust = 0,
             size = 8,
             fontface = "bold") +
    coord_fixed() +
    theme_bw()+
    theme(axis.text=element_blank(),
          axis.title=element_blank(),
          axis.ticks=element_blank(),
          panel.grid=element_blank(),
          panel.border=element_blank()
    ) 
}


df_hia_status <- df_hia_status_orig |> 
  select(city, ends_with("percent"))

for(i in seq_along(unique(df_hia_status$city))){
  
  text_city <- unique(df_hia_status$city)[i]
  
  df_viz <- df_hia_status |> 
    filter(city == text_city) 
  
  value_pos <- round(df_viz$hi_as_achieved_percent, 1)
  value_adjusted_target <- round(df_viz$power_adjusted_hia_target_percent, 1)
  value_2024_target <- round(df_viz$hia_target_2024_percent, 1)
  
  viz_gauge <- gg.gauge(pos = value_pos,
                 breaks = c(0, value_adjusted_target, value_2024_target, 100))
  
  ## Load image
  img_legend <- "img/arc_chart_legend.png"
  
  ## Draw chart with legend image pasted
  viz_gauge <- ggdraw(viz_gauge) + 
    draw_image(img_legend, x = 0.65, y = 0.2, hjust = 1, vjust = 1, width = 0.6, height = 0.2)

  ggsave(plot = viz_gauge,
         path = "output_viz_arcbar", 
         filename = glue::glue("viz_arcbar_{text_city}.png"), width = 4, height = 4, units = "in")  
  
}
