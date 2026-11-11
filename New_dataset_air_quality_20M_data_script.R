library(tidyverse)
library(readr)

data_raw<- read_csv(file.choose())
data_raw

glimpse(data_raw)

final_air_quality_20M_data<- data_raw %>% distinct() %>%
  mutate(
    co_column = as.numeric(co_column),
    co_quality = as.numeric(co_quality)
  ) %>% filter(co_column > 0 & co_quality > 0 ) %>%
  group_by(year,month) %>%
  summarise(
    Avg_co_column = mean(co_column),
    Avg_CO_quality = mean(co_quality),
    Total_Unit = n(),
    .groups = 'drop'
  )%>% arrange(desc(Total_Unit))

final_air_quality_20M_data
write.csv(final_air_quality_20M_data,
          'New_dataset_air_quality_20M_data.csv',
          row.names = FALSE)
getwd()
