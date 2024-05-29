##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                              HIA sector table                            ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
table_hia_powers <- df_hia_powers_orig |> 
  select(city, sector, 
         "implemented" = number_of_actions_achieving_by_sector, 
         "progressing" = number_of_actions_progressing_by_sector,
         "recommended_by_2030" = target_number_of_achieved_hi_as_by_sector_by_2030,
         powers_category_by_sector_limited_partial_strong, barriers_summary, barriers_category) |> 
  rename(
    "City" = city,
     "Sector" = sector,
     "Implemented" = implemented,
     "Progressing" = progressing,
     "Recommended by 2030" = recommended_by_2030,
    "Powers" = powers_category_by_sector_limited_partial_strong,
    "Summary" = barriers_summary,
    "Categories" = barriers_category
  ) |> 
  mutate(`#` = case_when(Sector == "Adaptation" ~ 1,
                         Sector == "Air Quality" ~ 2,
                         Sector == "Clean Construction" ~ 3,
                         Sector == "Energy" ~ 4,
                         Sector == "Buildings" ~ 5,
                         Sector == "Food" ~ 6,
                         Sector == "Urban Planning And Design" ~ 7,
                         Sector == "Transport" ~ 8,
                         Sector == "Waste" ~ 9),
         Powers = ifelse(Powers == "N/A", "No data", Powers),
         Summary = ifelse(is.na(Summary), "No data", Summary),
         Categories = ifelse(is.na(Categories), "No data", Categories),
         column_i = " ",
         column_j = " ") |>
  relocate("#") |> 
  relocate(column_i, .after = Summary) |> 
  relocate(column_j, .after = column_i) |> 
  arrange(City, `#`) 

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                        HIA actions list and status                       ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
table_hia_actions <- df_hia_actions_orig |>
  mutate(Achieving = case_when(status == "Achieving" ~ "Yes",
                               .default = "No"),
         Progressing = case_when(status == "Progressing" ~ "Yes",
                                 .default = "No")) |>
  select(city, action_short_name, Achieving, Progressing, 
         "Action standard description" = action,
         "Notes from research on action status" = notes_from_the_research,
         "Public link" = link_to_relevant_resource,
         "Case study" = c40_case_study_link,
         "Recommendation" = recommendation) |>
  mutate(action_short_name = factor(
    action_short_name, 
    levels = c("Cool surfaces", "Water conservation solutions", "Coastal protection",
               "Sustainable urban drainage systems", "Water system efficiency improvements",
               "Extreme weather emergency response plan", "Green spaces and urban canopy",
               "Air quality city-wide monitoring", 
               "Measures to reduce embodied emissions in buildings/infrastructure",
               "Baseline and embodied emissions reduction target set", 
               "Renewable energy mandates for buildings",
               "Phase out of fossil or solid fuel heating and cooking",
               "Mandatory energy/emissions performance standards for existing buildings",
               "Retrofit programs for private buildings",
               "Building energy regulations, codes or policies towards net zero carbon new buildings",
               "Policies towards net zero carbon municipal buildings",
               "Implement actions towards grid decarbonization",
               "Food security programmes",
               "Food assistance programmes towards low carbon diets",
               "Food businesses programs to minimize carbon emissions",
               "School feeding programs towards low carbon diets",
               "Promote transit-oriented development and affordable housing",
               "15 minute city/ neighbourhood policies",
               "Improvement of quality on street or rail transit",
               "Restrictions on high polluting vehicles",
               "Reallocation of road space to active transport",
               "Citywide speed restrictions",
               "Procure only zero emissions buses",
               "Procure only zero emission municipal vehicles",
               "Transport electrification",
               "Citywide segregated waste collection",
               "Waste collection fees or incentives (volume-based)",
               "Restrict single use and non-recyclable materials",
               "Sanitary landfill",
               "Universal waste collection")),
    column_d = " ",
    column_h = " ",
    column_i = " ",
    column_k = " ",
    column_l = " ") |>
  rename(
    "City" = city,
    "Climate action" = action_short_name,
    "Implemented" = Achieving) |> 
  group_by(City) |> 
  mutate("#" = row_number()) |> 
  ungroup() |> 
  relocate("#") |> 
  relocate(column_d, .after = "Climate action") |> 
  relocate(column_h, .after = "Action standard description") |> 
  relocate(column_i, .after = column_h) |> 
  relocate(column_k, .after = "Notes from research on action status") |> 
  relocate(column_l, .after = column_k) 
  



