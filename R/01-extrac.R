
###################### Dataset path
path <- paste0("/Users/pablotiscornia/Library/CloudStorage/GoogleDrive-ptiscornia@c40.org/Shared drives/BPMI/Business Planning and Reporting/C40 Analytics Team/Leadership Standards/Stocktake/")
#file <- "Stocktake - All cities dataset.xlsx"
file <- "Stocktake - Data repository.xlsx"


###################### Import HIA Powers dataset
text_sheet <- "HIAs-Powers (Sector)"
df_hia_powers_orig <- readxl::read_excel(paste0(path, file), sheet = text_sheet) |> 
  janitor::clean_names() |> 
  filter(city != "Dhaka") |> 
  mutate(city = clean_text(city))


###################### Import HIA actions dataset
text_sheet <- "HIAs-Powers (Action)"

df_hia_actions_orig <- readxl::read_excel(paste0(path, file), sheet = text_sheet) |> 
  janitor::clean_names() |> 
  filter(city != "Dhaka") |> 
  mutate(city = clean_text(city))


###################### Import HIA Status dataset
text_sheet <- "HIAs current status"
df_hia_status_orig <- readxl::read_excel(paste0(path, file), sheet = text_sheet) |> 
  janitor::clean_names() |> 
  filter(city != "Dhaka") |> 
  mutate(city = clean_text(city))

###################### Import HIA Status dataset
text_sheet <- "Buckets-Priority cities"
df_hia_tracking_status <- readxl::read_excel(paste0(path, file), sheet = text_sheet) |> 
  janitor::clean_names() |> 
  filter(city != "Dhaka") |> 
  mutate(city = clean_text(city)) |> 
  mutate(across(contains("_y_n"), \(x) case_when(x == "Y" ~ "On track",
                                                 x == "N" ~ "Off track",
                                                 .default = x)))

