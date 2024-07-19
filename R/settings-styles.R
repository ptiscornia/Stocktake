
## Style
style_conditional_01 <- createStyle(fontSize = 12, border = "TopBottomLeftRight", borderStyle = "thick", 
                                 textDecoration = "bold", 
                                 fgFill = ifelse(text_track_emissions_d2020pc == "On track", c40_colors("green"), 
                                                 ifelse(text_track_emissions_d2020pc == "N/A", "grey",
                                                        ifelse(text_track_emissions_d2020pc == "Off track", c40_colors("red"),
                                                               "yellow"))),
                                 wrapText = TRUE, valign = "center", halign = "center")

## Style
style_conditional_02 <- createStyle(fontSize = 12, border = "TopBottomLeftRight", borderStyle = "thick", 
                                    textDecoration = "bold", 
                                    fgFill = ifelse(text_track_2024_updated_target == "On track", c40_colors("green"), 
                                                    ifelse(text_track_2024_updated_target == "N/A", "grey",
                                                           ifelse(text_track_2024_updated_target == "Off track", c40_colors("red"),
                                                                  "yellow"))),
                                    wrapText = TRUE, valign = "center", halign = "center")

style_conditional_03 <- createStyle(fontSize = 12, border = "TopBottomLeftRight", borderStyle = "thick", 
                                    textDecoration = "bold", 
                                    fgFill = ifelse(text_track_2024_adjusted_target == "On track", c40_colors("green"), 
                                                    ifelse(text_track_2024_adjusted_target == "N/A", "grey",
                                                           ifelse(text_track_2024_adjusted_target == "Off track", c40_colors("red"),
                                                                  "yellow"))),
                                    wrapText = TRUE, valign = "center", halign = "center")

style_conditional_04 <- createStyle(fontSize = 12, border = "TopBottomLeftRight", borderStyle = "thick", 
                                    textDecoration = "bold", 
                                    fgFill = ifelse(text_track_gral_compliance == "On track", c40_colors("green"), 
                                                    ifelse(text_track_gral_compliance == "N/A", "grey",
                                                           ifelse(text_track_gral_compliance == "At risck", c40_colors("yellow"),
                                                                  "yellow"))),
                                    wrapText = TRUE, valign = "center", halign = "center")


### Power column styling
style_table_hia_strong <- createStyle(fontSize = 12, border = "TopBottomLeftRight", borderStyle = "thin", textDecoration = NULL, 
            bgFill =c40_colors("green"), wrapText = TRUE, valign = "center", halign="left")

style_table_hia_partial <- createStyle(fontSize = 12, border = "TopBottomLeftRight", borderStyle = "thin", textDecoration = NULL, 
                                      bgFill ="#ccf2d9", wrapText = TRUE, valign = "center", halign="left")

### Barriers - Summary column styling
style_table_hia_significant <- createStyle(fontSize = 12, border = "TopBottomLeftRight", borderStyle = "thin", textDecoration = NULL, 
                                       bgFill ="#d4444d", wrapText = TRUE, valign = "center", halign="left")

style_table_hia_some <- createStyle(fontSize = 12, border = "TopBottomLeftRight", borderStyle = "thin", textDecoration = NULL, 
                                           bgFill ="#e9a1a6", wrapText = TRUE, valign = "center", halign="left")


### Greens
# "#04f457"
# "#03c245"
# "#029033"

### Reds
# "#d4444d"
# "#e9a1a6"
style1 <- createStyle(fontSize = 14, border = "TopBottomLeftRight", borderStyle = "thick", textDecoration = "bold", 
                      fgFill ="lightgray", halign="left", wrapText = TRUE, valign = "center")

style2 <- createStyle(fontSize = 12, border = "TopBottomLeftRight", borderStyle = "thick", textDecoration = "bold", 
                      fgFill ="white", wrapText = TRUE, valign = "center", halign="center")

style3 <- createStyle(fontSize = 12, textDecoration = "bold", 
                      fgFill ="white", wrapText = FALSE, valign = "center", halign = "left")

style4 <- createStyle(fontSize = 12, fgFill = c40_colors("green"), wrapText = FALSE, valign = "center", halign = "center")

style5 <- createStyle(fontSize = 12, fgFill = "lightgray", wrapText = TRUE, valign = "center", halign = "left")

style6 <- createStyle(fontSize = 12, fgFill = c40_colors("green"), wrapText = TRUE, valign = "center", halign = "left")

style7 <- createStyle(fontSize = 11, fontColour = "white", 
                      border = "TopBottomLeftRight", borderStyle = "thin", borderColour = "white",
                      textDecoration = "bold",  fgFill ="black", halign="left", valign = "center", wrapText = TRUE)

style8 <- createStyle(fontSize = 11, fontColour = "black", 
                      border = "TopBottomLeftRight", borderStyle = "double", borderColour = "black",
                      fgFill = c40_colors("green"), halign="left", valign = "center", wrapText = TRUE)

style9 <- createStyle(fontSize = 11, fontColour = "black", 
                      border = "TopBottomLeftRight", borderStyle = "double", borderColour = "black",
                      fgFill = c40_colors("yellow"), halign="left", valign = "center", wrapText = TRUE)

style10 <- createStyle(fontSize = 12, border = "TopBottomLeftRight", borderStyle = "thin", textDecoration = NULL, 
                      fgFill ="white", wrapText = TRUE, valign = "center", halign="left")
style11 <- createStyle(fontSize = 12, border = "TopBottomLeftRight", borderStyle = "thin", textDecoration = NULL, 
                       fgFill ="white", wrapText = FALSE, valign = "center", halign="left")
