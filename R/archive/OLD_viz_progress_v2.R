

source("R/00-libraries.R")
source("R/01-extrac.R")
source("R/02-transform.R")


for(i in seq_along(unique(df_hia_actions_orig$city))){
  
  text_city <- unique(df_hia_actions_orig$city)[i]
  
  df_viz <- df_hia_actions_orig |> 
    filter(city == text_city) |> 
    mutate(status = factor(status, 
                           levels = c("Basic", "Progressing", "Achieving"))) |> 
    count(city, status, .drop = FALSE) |> 
    mutate(percentage = round(n / sum(n) * 100, digits = 0)) |> 
    filter(!is.na(status)) |> 
    mutate(color = c(c40_colors("blue"),
                     c40_colors("green"),
                     '#A9A9A9'))
  
  viz <- df_viz |> 
    hchart(type = "pie",
           hcaes(x = status, y = percentage, color = color)) |> 
    hc_plotOptions(
      pie = list(
        innerSize = '70%', 
        startAngle = -90, 
        endAngle = 90, 
        dataLabels = list(
          enabled = TRUE,
          format = '<b>{point.name}</b>: {point.percentage:.1f} %'
        )
      )
    )  
  
  
  htmlwidgets::saveWidget(widget = viz, 
                          file = glue::glue("output_viz_arcbar/html/viz_arcbar_{text_city}.html"))
  
  ## save html to png 
  webshot2::webshot(url = glue::glue("output_viz_arcbar/html/viz_arcbar_{text_city}.html"), 
                   file = glue::glue("output_viz_arcbar/png/viz_arcbar_{text_city}.png"),
                   vwidth = 600, vheight = 400,
                   zoom = 1.5,
                   cliprect = c(85, 5, 520, 230),
                   delay = 0.5)
  
  # ggsave(plot = viz,
  #        path = "output_viz_arcbar", 
  #        filename = glue::glue("viz_arcbar_{text_city}.png"), width = 4, height = 4, units = "in")
}
