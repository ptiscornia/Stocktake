library(highcharter)

i <- seq_along(unique(df_hia_actions_orig$city))[1]

text_city <- unique(df_hia_actions_orig$city)[i]

df_viz <- df_hia_actions_orig |> 
  filter(city == text_city) |> 
  mutate(status = factor(status, 
                         levels = c("Basic", "Progressing", "Achieving"))) |> 
  count(city, status, .drop = FALSE) |> 
  mutate(percentage = round(n / sum(n) * 100, digits = 0)) |> 
  filter(!is.na(status))

df <- df_viz |> 
  dplyr::mutate(color = c(
    c40_colors("blue"),
    c40_colors("green"),
    '#A9A9A9'))

pie <- df |> 
  hchart(type = "pie",
         hcaes(x = status, y = percentage, color = color)) |> 
  hc_plotOptions(
    pie = list(
      innerSize = '50%', 
      startAngle = -90, 
      endAngle = 90, 
      dataLabels = list(
        fontSize = 20,
        enabled = TRUE,
        format = '<b>{point.name}</b>: {point.percentage:.1f} %'
      )
    )
  )  

pie

htmlwidgets::saveWidget(widget = pie, file = "test.html")


## save html to png 
webshot2::webshot(url = "test.html", 
                  vwidth = 600, vheight = 400,
                  zoom = 1.5,
                  cliprect = c(85, 5, 520, 230),
                 file = "test.png", delay = 0.5)
