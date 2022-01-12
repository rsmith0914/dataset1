---
Title: 'Netflix_Data'
Author: 'Ryan'
Date: '12/21/21'
---

#loading packages
library(tidyverse)

#reading in data
data <- read_csv("~/VTL Lab/Surface Area Bubble Plot Study/analysis_12_15_21/joined_data.csv")
data
#Faceting by participants
# data %>% 
#   mutate(resulting_area_ratio = if_else(resulting_area_ratio < 1, -(1 / resulting_area_ratio) + 1, resulting_area_ratio - 1)) %>% 
#   ggplot(aes(as.factor(targ_set_size), resulting_area_ratio)) +
#   geom_jitter(shape = 1,
#               height = 0, 
#               width = 0.1,
#               alpha = 0.5) +
#   geom_hline(yintercept = 0,
#              linetype=2,
#              color="red") +
#   scale_y_continuous(limits=c(-2, 2), breaks=seq(-2, 2, 0.25)) +
#   facet_grid(. ~ participant_id) +
#   labs(title="Area ratio for all participants",
#        subtitle="Participants consistently below line assumed to have misunderstood instructions",
#        x="Target set size",
#        y="Proportional area difference")

#participants rejected for misunderstanding instructions
instr_rejections <- c(26713, 40281, 44692, 49726, 55845, 63476)

#filtering out bad instructions folks, then, looking at control trials

# data %>%
#   filter(!(participant_id %in% instr_rejections)) %>%
#   filter(targ_set_size == 5) %>%
#   mutate(resulting_area_ratio = if_else(resulting_area_ratio < 1, -(1 / resulting_area_ratio) + 1, resulting_area_ratio - 1)) %>%
#   ggplot(aes(as.factor(targ_set_size), resulting_area_ratio)) +
#   geom_jitter(shape = 1,
#               height = 0,
#               width = 0.1,
#               alpha = 0.5) +
#   geom_hline(yintercept = 0,
#              linetype = 2,
#              color = "red") +
#   geom_hline(yintercept = 0.3,
#              linetype = 2,
#              color = "blue") +
#   geom_hline(yintercept = -0.3,
#              linetype = 2,
#              color = "blue") +
#   scale_y_continuous(limits=c(-2,2), breaks=seq(-2, 2, 0.1)) +
#   facet_grid(. ~ participant_id)

#participants rejected for poor performance on 5v5 trials
control_rejections <- c(15814, 18417, 57480)


#recreating first graphs without bad subjects
# data %>% 
#   filter(!(participant_id %in% instr_rejections),
#          !(participant_id %in% control_rejections)) %>%
#   mutate(resulting_area_ratio = if_else(resulting_area_ratio < 1, -(1 / resulting_area_ratio) + 1, resulting_area_ratio - 1)) %>% 
#   ggplot(aes(as.factor(targ_set_size), resulting_area_ratio)) +
#   geom_jitter(shape = 1,
#               height = 0, 
#               width = 0.1,
#               alpha = 0.5) +
#   geom_hline(yintercept = 0,
#              linetype=2,
#              color="red") +
#   scale_y_continuous(limits=c(-1, 1), breaks=seq(-1, 1, 0.1)) +
#   labs(title="Area ratio for all trials",
#        subtitle="Positive values indicate the less numerous display was sized to have larger area",
#        x="Target set size",
#        y="Proportional area difference")
  
#including a boxplot

data %>% 
  filter(!(participant_id %in% instr_rejections),
         !(participant_id %in% control_rejections)) %>%
  mutate(resulting_area_ratio = if_else(resulting_area_ratio < 1, -(1 / resulting_area_ratio) + 1, resulting_area_ratio - 1)) %>% 
  ggplot(aes(as.factor(targ_set_size), resulting_area_ratio)) +
  geom_jitter(shape = 1,
              height = 0, 
              width = 0.1,
              alpha = 0.5) +
  geom_boxplot(alpha = 0.5,
               outlier.shape = NA,
               width = 0.3) +
  geom_hline(yintercept = 0,
             linetype=2,
             color="red") +
  scale_y_continuous(limits=c(-1, 1), breaks=seq(-1, 1, 0.1)) +
  labs(title="Area ratio for all trials",
       subtitle="Positive values indicate the less numerous display was sized to have larger area",
       x="Target set size",
       y="Proportional area difference")

# data %>% 
#   filter(!(participant_id %in% instr_rejections)) %>% 
#   filter(targ_set_size == 5) %>% 
#   mutate(resulting_radius_ratio = if_else(resulting_radius_ratio < 1, -(1 / resulting_radius_ratio) + 1, resulting_radius_ratio - 1)) %>%
#   ggplot(aes(as.factor(targ_set_size), resulting_radius_ratio)) +
#   geom_jitter(shape = 1,
#               height = 0, 
#               width = 0.1,
#               alpha = 0.5) +
#   geom_hline(yintercept = 0, 
#              linetype = 2,
#              color = "red") +
#   geom_hline(yintercept = 0.3, 
#              linetype = 2,
#              color = "blue") +
#   geom_hline(yintercept = -0.3, 
#              linetype = 2,
#              color = "blue") +
#   scale_y_continuous(limits=c(-2,2), breaks=seq(-2, 2, 0.1)) +
#   facet_grid(. ~ participant_id)

#recreating first graphs without bad subjects

# data %>% 
#   filter(!(participant_id %in% instr_rejections),
#          !(participant_id %in% control_rejections)) %>%
#   mutate(resulting_radius_ratio = if_else(resulting_radius_ratio < 1, -(1 / resulting_radius_ratio) + 1, resulting_radius_ratio - 1)) %>% 
#   ggplot(aes(as.factor(targ_set_size), resulting_radius_ratio)) +
#   geom_jitter(shape = 1,
#               height = 0, 
#               width = 0.1,
#               alpha = 0.5) +
#   geom_hline(yintercept = 0,
#              linetype=2,
#              color="red") +
#   scale_y_continuous(limits=c(-1, 1), breaks=seq(-1, 1, 0.1)) +
#   labs(title="Radius ratio for all trials",
#        subtitle="Positive values indicate the less numerous display was sized to have larger area",
#        x="Target set size",
#        y="Proportional radius difference")

#including a boxplot

data %>% 
  filter(!(participant_id %in% instr_rejections),
         !(participant_id %in% control_rejections)) %>%
  mutate(resulting_radius_ratio = if_else(resulting_radius_ratio < 1, -(1 / resulting_radius_ratio) + 1, resulting_radius_ratio - 1)) %>% 
  ggplot(aes(as.factor(targ_set_size), resulting_radius_ratio)) +
  geom_jitter(shape = 1,
              height = 0, 
              width = 0.1,
              alpha = 0.5) +
  geom_boxplot(alpha = 0.5,
               outlier.shape = NA,
               width = 0.3) +
  geom_hline(yintercept = 0,
             linetype=2,
             color="red") +
  scale_y_continuous(limits=c(-1, 1), breaks=seq(-1, 1, 0.1)) +
  labs(title="Radius ratio for all trials",
       subtitle="Positive values indicate the less numerous display was sized to have larger area",
       x="Target set size",
       y="Proportional radius difference")