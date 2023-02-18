## This script contains code to re-create charts
## that are show in the draft document in the `docs` folder.


# libraries ---------------------------------------------------------------

library(here)
library(haven)
library(ggrepel)
library(tidyverse)
library(showtext)
font_add_google(name = "EB Garamond")
font_add("Garamond","GARA.TTF")
showtext_auto()
# load data ---------------------------------------------------------------

data_as_inclusicve <- read_dta(
  here("data/",
       "Alkire-Seth inclusive well-being data for graphs.dta")
)


# Figure 1 : Change in Average Attainment and Inclusivity premium ---------

data_as_inclusicve|>
  ggplot(aes(d_attain_pa,S_W_Sen_pa))+
  geom_point(
    shape = 1,
    aes(size = population)
  )+
  guides(size = "none")+
  scale_size_area(max_size = 25)+
  scale_y_continuous(breaks = seq(-0.25,1,0.25))+
  scale_x_continuous(breaks = seq(-0.3,2.4,0.3))+
  labs(
    y = "Inclusivity Premium per annum",
    x = "Change in average attainment per annum"
  )+
  geom_smooth(
    aes(weight = population),
    method = "lm",
    se = F,
    colour = "#898999"
  )+
  geom_smooth(
    method = "lm",
    formula = y ~ x + I(x^2),
    se = F,
    colour = "#898999",
    linetype = 2
  )+
  geom_smooth(
    aes(weight = population),
    method = "lm",
    formula = y ~ x + I(x^2),
    se = F,
    colour = "#000000"
  )+
  geom_text_repel(aes(label = ISO),
                  max.overlaps = 12)+
  theme_bw()+
  theme(
    axis.title = element_text(colour = "#000000",
                              size = 18),
    axis.text = element_text(colour = "#000000",
                             size = 14),
    text = element_text(family = "EB Garamond")
  )-> fig_1

ggsave(
  plot = fig_1,
  filename = paste0(Sys.Date(),"-figure1-Change in average attainment and inclusivity premium.jpeg"),
  device = "jpeg",
  path = here("charts/"),
  width = 12,
  height = 8,
  units = "in"
)

# Figure  2: Shared prosperity premiums and inclusivity premiums across 25 countries --------

data_as_inclusicve|>
  ggplot(aes(S_W_Sen_pa,inc_shr_pre))+
  geom_point(
    shape = 1,
    aes(size = population)
  )+
  guides(size = "none")+
  scale_size_area(max_size = 25)+
  scale_y_continuous(breaks = seq(-2,4,1))+
  scale_x_continuous(breaks = seq(-0.2,1,0.2),
                     limits = c(-0.2,1))+
  labs(
    y = "Shared propensity premium (SPP) per annum",
    x = "Inclusivity premium per annum"
  )+
  geom_smooth(
    aes(weight = population),
    method = "lm",
    formula = y ~ x + I(x^2),
    se = F,
    colour = "#000000"
  )+
  geom_smooth(
    method = "lm",
    formula = y ~ x + I(x^2),
    se = F,
    colour = "#898999"
  )+
  geom_text_repel(aes(label = ISO),
                  max.overlaps = 12)+
  theme_bw()+
  theme(
    axis.title = element_text(colour = "#000000",
                              size = 18),
    axis.text = element_text(colour = "#000000",
                             size = 14),
    text = element_text(family = "EB Garamond")
  ) -> fig_2

ggsave(
  plot = fig_2,
  filename = paste0(Sys.Date(),"-figure2-Shared prosperity premiums and inclusivity premiums across 25 countries.jpeg"),
  device = "jpeg",
  path = here("charts/"),
  width = 12,
  height = 8,
  units = "in"
)

# Figure 3: Inclusivity premiums and absolute changes in the MPIs  --------


data_as_inclusicve|>
  ggplot(aes(S_W_Sen_pa,abs_M0_33_pa))+
  geom_point(
    shape = 1,
    aes(size = population)
  )+
  guides(size = "none")+
  scale_size_area(max_size = 25)+
  scale_y_continuous(breaks = seq(-0.030,0.005,0.005),
                     limits = c(-0.030,0.005))+
  scale_x_continuous(breaks = seq(-0.25,1,0.25))+
  labs(
    y = "Absolute change in MPI per annum",
    x = "Inclusivity premium per annum"
  )+
  geom_smooth(
    aes(weight = population),
    method = "lm",
    formula = y ~ x + I(x^2),
    se = F,
    colour = "#000000"
  )+
  geom_smooth(
    method = "lm",
    formula = y ~ x + I(x^2),
    se = F,
    colour = "#898999"
  )+
  geom_text_repel(aes(label = ISO),
                  max.overlaps = 16)+
  theme_bw()+
  theme(
    axis.title = element_text(colour = "#000000",
                              size = 18),
    axis.text = element_text(colour = "#000000",
                             size = 14),
    text = element_text(family = "EB Garamond")
  ) -> fig_3

ggsave(
  plot = fig_3,
  filename = paste0(Sys.Date(),"-figure3-Inclusivity premiums and absolute changes in the MPIs across countries.jpeg"),
  device = "jpeg",
  path = here("charts/"),
  width = 12,
  height = 8,
  units = "in"
)


