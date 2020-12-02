library(rtweet)
library(lubridate)
library(tidyverse)
create_token(app = 'Samcuse', consumer_key = "NaWXVRNSkNRTxUKhSBnc4ktyb", consumer_secret = "HUSCdMctBU2VtAWI5WWxpZN0gt9QohAx7pWCY3SdWG7fwvmEpH",access_token = '17938175-wi3wBxwQ9dAQILUBzaDZu3qLcv4W5dJXrdcAxJ5Zm', access_secret = '1iiUbn8OKykBZ7fFGBKdqVu2Q15gSR54BhLu805LWjBOS')

syracuse_explosion <- search_tweets2(q = c("Syracuse explosion","Syracuse boom", 'Syracuse meteor'),
              n = 5000,retryonratelimit = TRUE)

head(syracuse_explosion)
syracuse_explosion %>%
  mutate(hour_minute = format(created_at, '%H:%M'),
         hour = hour(created_at),
         text = tolower(text),
         text_used = case_when(grepl('meteor', text) ~ 'meteor',
                   grepl('boom', text) ~ 'boom',
                   grepl('explosion', text) ~ 'explosion')) %>%
  group_by(hour_minute,text_used) %>%
  tally() %>%
  ggplot(aes(hour_minute, n, fill = text_used)) +
  geom_col()
  
