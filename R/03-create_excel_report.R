
source("R/00-libraries.R")
source("R/01-extrac.R")
source("R/02-transform.R")

version <- "v0.4"

### Excel creation
wb <- createWorkbook()
#options("openxlsx.borderColour" = "#4F80BD")
#options("openxlsx.borderStyle" = "thin")
modifyBaseFont(wb, fontSize = 11, fontName = "Montserrat")

for (i in seq_along(sort(unique(table_hia_powers$City)))) {
  #for (i in seq_along(sort(unique(df_hia_powers$city)[1:13]))) {
  
  #text_city <- sort(unique(df_hia_powers$city))[1:13][i]
  text_city <- sort(unique(table_hia_powers$City))[i]
  
  text_track_emissions_d2020pc <- df_hia_tracking_status |> 
    filter(city == text_city) |>  pull(emissions_below_d2020_per_capita_y_n)
  
  text_track_2024_updated_target <- df_hia_tracking_status |> 
    filter(city == text_city) |>  pull(on_track_with_2024_hia_updated_target_y_n)
  
  text_track_2024_adjusted_target <- df_hia_tracking_status |> 
    filter(city == text_city) |>  pull(on_track_with_2024_hia_power_adjusted_target_y_n)
  
  text_track_gral_compliance <- df_hia_tracking_status |> 
    filter(city == text_city) |>  pull(general_compliance_assessment)
  
  ### Add sheet
  addWorksheet(wb, sheetName = text_city, gridLines = FALSE)
  
  
  ### File Settings
  source("R/settings-width_col_row.R")
  source("R/settings-styles.R")
  
  ### Insert C40 logo
  insertImage(wb, i, file = "img/c40_logo.png", startCol = "B", startRow = 3, 
              width = 1, height = 1, units = "in")
  
  
  ### Write data
  writeData(wb, i, startCol = "D", startRow = 3, x = "City Stocktake Report, 2024  \n[Annex to the C40 Leadership Standard, 2023 End-Year Report]")
  mergeCells(wb, i, cols = 4:7, rows = 3)
  addStyle(wb, i, style = style1, cols = 4:7, rows = 3, stack = FALSE, gridExpand = TRUE)
  
  writeData(wb, i, startCol = "J", startRow = 3, x = "Summary assessment")
  mergeCells(wb, i, cols = 10:15, rows = 3)
  addStyle(wb, i, style = style1, cols = 10:15, rows = 3, stack = FALSE, gridExpand = TRUE)
  
  writeData(wb, i, startCol = "D", startRow = 5, x = text_city)
  mergeCells(wb, i, cols = 4:7, rows = 5)
  addStyle(wb, i, style = style2, cols = 4:7, rows = 5, stack = FALSE, gridExpand = TRUE)
  
  writeData(wb, i, startCol = "J", startRow = 5, x = text_track_gral_compliance)
  mergeCells(wb, i, cols = 10:15, rows = 5)
  addStyle(wb, i, style = style_conditional_04, cols = 10:15, rows = 5, stack = FALSE, gridExpand = TRUE)
  
  writeData(wb, i, startCol = "B", startRow = 7, x = "Alignment with the city's 2030 climate targets | GHG emissions and Climate Action Implementation")
  mergeCells(wb, i, cols = 2:15, rows = 7)
  addStyle(wb, i, style = style1, cols = 2:15, rows = 7, stack = FALSE, gridExpand = TRUE)
  
  ### GHG Emissions graph
  # Title
  # 
  writeData(wb, i, startCol = "B", startRow = 9, x = "GHG emissions against CAP and D2020 targets")
  addStyle(wb, i, style = style3, cols = "B", rows = 9, stack = FALSE, gridExpand = TRUE)
  
  writeData(wb, i, startCol = "G", startRow = 9, x = "Status")
  addStyle(wb, i, style = style3, cols = "G", rows = 9, stack = FALSE)
  
  writeData(wb, i, startCol = "G", startRow = 10, x = text_track_emissions_d2020pc)
  addStyle(wb, i, style = style_conditional_01, cols = "G", rows = 10, stack = FALSE, gridExpand = TRUE)
  
  ### GRAPH
  img_path <- paste0("/Users/pablotiscornia/Library/CloudStorage/GoogleDrive-ptiscornia@c40.org/Shared drives/BPMI/Business Planning and Reporting/C40 Analytics Team/Leadership Standards/GHG Forecasts/plots-forecasts-trends/")
  img_file <- list.files(path = "img/plots_forecaste_trends/", pattern = substr(text_city, 1,5))
  
  insertImage(wb, i, file = glue::glue("img/plots_forecaste_trends/{img_file}"),
              startRow = 10,  startCol = 2,
              width = 4, height = 2.5, units = "in")
  
  
  # Title
  writeData(wb, i, startCol = "J", startRow = 9, x = "Climate action implementation (%)")
  addStyle(wb, i, style = style3, cols = "J", rows = 9, stack = FALSE)
  
  writeData(wb, i, startCol = "N", startRow = 9, x = "Status - 2024 target")
  addStyle(wb, i, style = style3, cols = "N", rows = 9, stack = FALSE)
  
  writeData(wb, i, startCol = "N", startRow = 10, x = text_track_2024_updated_target)
  addStyle(wb, i, style = style_conditional_02, cols = "N", rows = 10, stack = FALSE, gridExpand = TRUE)
  
  writeData(wb, i, startCol = "N", startRow = 12, x = "Status - 2024 power adjusted target")
  addStyle(wb, i, style = style3, cols = "N", rows = 12, stack = FALSE)
  
  writeData(wb, i, startCol = "N", startRow = 13, x = text_track_2024_adjusted_target)
  addStyle(wb, i, style = style_conditional_03, cols = "N", rows = 13, stack = FALSE, gridExpand = TRUE)
  
  ### GRAPH
  img_file <- list.files(path = "output_viz_arcbar/", pattern = substr(text_city, 1,5))
  
  insertImage(wb, i, file = glue::glue("output_viz_arcbar/{img_file}"),
              startRow = 10,  startCol = 10,
              width = 4, height = 4, units = "in")
  
  
  writeData(wb, i, startCol = "B", startRow = 18, x = "[PLACEHOLDER - ADAPTATION OUTCOMES SNAPSHOT]")
  mergeCells(wb, i, cols = 2:6, rows = 18)
  addStyle(wb, i, style = style9, cols = 2:6, rows = 18, stack = FALSE, gridExpand = TRUE)
  
  writeData(wb, i, startCol = "B", startRow = 20, x = "Climate Action implementation | Assessment of Powers & Barriers")
  mergeCells(wb, i, cols = 2:15, rows = 20)
  addStyle(wb, i, style = style1, cols = 2:15, rows = 20, stack = FALSE, gridExpand = TRUE)
  
  writeData(wb, i, startCol = "B", startRow = 22, x = "[PLEASE COMPLETE]")
  mergeCells(wb, i, cols = 2:15, rows = 22)
  addStyle(wb, i, style = style9, cols = 2:15, rows = 22, stack = FALSE, gridExpand = TRUE)
  
  ### Summary table
  writeData(wb, i, startCol = "B", startRow = 24, x = "Powers per sector (see Annex for a detailed list of actions accounted for)")
  addStyle(wb, i, style = style3, cols = 2:6, rows = 24, stack = FALSE, gridExpand = TRUE)
  mergeCells(wb, i, cols = 2:6, rows = 24)
  
  writeData(wb, i, startCol = "H", startRow = 24, x = "Barriers")
  mergeCells(wb, i, cols = 8:15, rows = 24)
  addStyle(wb, i, style = style3, cols = 8:15, rows = 24, stack = FALSE, gridExpand = TRUE)
  
  writeData(wb, i, startCol = "H", startRow = 25, x = "Barrier Category")
  mergeCells(wb, i, cols = 8, rows = 25:26)
  addStyle(wb, i, style = style7, cols = 8, rows = 25:26, stack = FALSE, gridExpand = TRUE)
  
  writeData(wb, i, startCol = "I", startRow = 25, x = "Barrier Description")
  mergeCells(wb, i, cols = 9:14, rows = 25:26)
  addStyle(wb, i, style = style7, cols = 9:14, rows = 25:26, stack = FALSE, gridExpand = TRUE)
  
  writeData(wb, i, startCol = "O", startRow = 25, x = "Any usefull link?")
  mergeCells(wb, i, cols = 15, rows = 25:26)
  addStyle(wb, i, style = style7, cols = 15, rows = 25:26, stack = FALSE, gridExpand = TRUE)
  
  ### HIA Powers Table
  ### Write HIA action's table
  df_powers <- table_hia_powers |> 
    select("#", City, Sector, Implemented, Progressing, Powers)
  
  for (n_col in seq_along(colnames(df_powers |> select(-City)))) {
    
    temp_df <- df_powers |> select(-City)
    
    columns <- LETTERS[2:6]
    
    # Write Column's names
    writeData(wb, i, startCol = columns[n_col], startRow = 26, 
              x = colnames(temp_df)[n_col])
    
    # Write Data
    writeData(wb, i, startCol = columns[n_col], startRow = 27, 
              x = df_powers |> 
                filter(City == text_city) |> 
                select(-City) |> 
                select(colnames(temp_df[n_col])) |> 
                pull())
  }
  
  # for (n_row2 in 26:35) {
  #   mergeCells(wb, i, cols = 8:10, rows = n_row2)
  #   mergeCells(wb, i, cols = 11:15, rows = n_row2)
  # }
  
  addStyle(wb, i, style = style10, cols = 2:6, rows = 27:35, stack = TRUE, gridExpand = TRUE)
  addStyle(wb, i, style = style10, cols = 8:15, rows = 27:35, stack = TRUE, gridExpand = TRUE)
  
  conditionalFormatting(wb, i, style = style_table_hia_strong, cols = c(2:6), rows = 27:35, type = "contains", rule = "Strong")
  conditionalFormatting(wb, i, style = style_table_hia_partial, cols = c(2:6), rows = 27:35, type = "contains", rule = "Partial")
  
  #conditionalFormatting(wb, i, style = style_table_hia_significant, cols = c(2:15), rows = 27:35, type = "contains", rule = "Significant")
  #conditionalFormatting(wb, i, style = style_table_hia_some, cols = c(2:15), rows = 27:35, type = "contains", rule = "Some")
  
  writeData(wb, i, startCol = "D", startRow = 25, x = "Climate policies")
  mergeCells(wb, i, cols = 4:6, rows = 25)
  
  # writeData(wb, i, startCol = "H", startRow = 25, x = "Barrier Category")
  # mergeCells(wb, i, cols = 8, rows = 25:26)
  
  # writeData(wb, i, startCol = "I", startRow = 25, x = "Barrier Descriptio")
  # mergeCells(wb, i, cols = 8:14, rows = 25:26)
  
  addStyle(wb, i, style = style7, cols = 2:6, rows = 25:26, stack = FALSE, gridExpand = TRUE)
  #addStyle(wb, i, style = style7, cols = 8:9, rows = 25:26, stack = FALSE, gridExpand = TRUE)
  
  
  writeData(wb, i, startCol = "B", startRow = 37, x = "CONCLUSION | Can the city get on track into a 1.5C trajectory if given the right support? ")
  mergeCells(wb, i, cols = 2:15, rows = 37)
  addStyle(wb, i, style = style1, cols = 2:15, rows = 37, stack = FALSE, gridExpand = TRUE)
  
  writeData(wb, i, startCol = "B", startRow = 39, x = "[PLEASE COMPLETE]")
  mergeCells(wb, i, cols = 2:15, rows = 39)
  addStyle(wb, i, style = style9, cols = 2:15, rows = 39, stack = FALSE, gridExpand = TRUE)
  
  ### Annex
  writeData(wb, i, startCol = "B", startRow = 41, x = "Annex - Full list of Climate Actions implemented")
  mergeCells(wb, i, cols = 2:15, rows = 41)
  addStyle(wb, i, style = style1, cols = 2:15, rows = 41, stack = FALSE, gridExpand = TRUE)
  
  
  ### Write HIA action's table
  for (n_col in seq_along(colnames(table_hia_actions |> select(-City)))) {
    
    temp_df <- table_hia_actions |> select(-City)
    
    writeData(wb, i, startCol = columns[n_col], startRow = 43, 
              x = colnames(temp_df)[n_col])
    
    columns <- LETTERS[2:15]
    writeData(wb, i, startCol = columns[n_col], startRow = 44, 
              x = table_hia_actions |> 
                filter(City == text_city) |> 
                select(-City) |> 
                select(colnames(temp_df[n_col])) |> 
                pull())
  }
  
  for (n_row in 43:78) {
    mergeCells(wb, i, cols = 3:4, rows = n_row)
    mergeCells(wb, i, cols = 7:9, rows = n_row)
    mergeCells(wb, i, cols = 10:12, rows = n_row)
  }
  
  conditionalFormatting(wb, i, style = style_table_hia_partial, cols = c(5, 6), rows = 44:78, type = "contains", rule = "Yes")
  
  addStyle(wb, i, style = style7, cols = 2:15, rows = 43, stack = FALSE, gridExpand = TRUE)
  addStyle(wb, i, style = style10, cols = c(2:12, 14:15), rows = 44:78, stack = TRUE, gridExpand = TRUE)
  addStyle(wb, i, style = style11, cols = 13, rows = 44:78, stack = TRUE, gridExpand = TRUE)
  
  writeData(wb, i, startCol = "B", startRow = 80, x = "Please follow the links to read about the methodologies behind forecasted emissions, HIAs and powers.")
  
} 

### Write excel file
saveWorkbook(wb, glue::glue("output_stocktake/City Report Automation_{version}.xlsx"), 
             returnValue = TRUE, overwrite = TRUE) ## save to working directory

