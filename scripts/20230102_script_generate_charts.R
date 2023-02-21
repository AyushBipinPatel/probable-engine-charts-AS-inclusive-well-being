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

data_as_inclusicve_tl <- read_dta(
  here("data/",
       "Alkire-Seth Trend-line data included.dta")
)


# Figure 1 : Change in Average Attainment and Inclusivity premium ---------

data_as_inclusicve_tl|>
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
  geom_line(aes(y = Fig1_solid_black),
            size = 0.3,
            colour = "#000000"
              )+
  geom_line(aes(y = Fig1_solid_grey),
            size = 0.3,
            colour = "#898999"
  )+
  geom_line(aes(y = Fig1_dashed_grey),
            size = 0.3,
            colour = "#898999",
            linetype = 2
  )+
  geom_text_repel(aes(label = ISO),
                  max.overlaps = 12, 
                  size = 5.5)+
  theme_bw()+
  theme(
    axis.title = element_text(colour = "#000000",
                              size = 23),
    axis.text = element_text(colour = "#000000",
                             size = 19),
    text = element_text(family = "EB Garamond")
  )-> fig_1

ggsave(
  plot = fig_1,
  filename = paste0(Sys.Date(),"-figure1-Change in average attainment and inclusivity premium.jpeg"),
  device = "jpeg",
  path = here("charts/"),
  width = 6.5,
  height = 4.5,
  units = "in"
)

# Figure  2: Shared prosperity premiums and inclusivity premiums across 25 countries --------

data_as_inclusicve_tl|>
  filter(!is.na(inc_shr_pre))|> 
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
  geom_line(aes(y = Fig2_solid_black),
            size = 0.3,
            colour = "#000000"
  )+
  geom_line(aes(y = Fig2_solid_gray),
            size = 0.3,
            colour = "#898999"
  )+
  geom_text_repel(aes(label = ISO),
                  max.overlaps = 12,
                  size = 5.5)+
  theme_bw()+
  theme(
    axis.title = element_text(colour = "#000000",
                              size = 23),
    axis.text = element_text(colour = "#000000",
                             size = 19),
    text = element_text(family = "EB Garamond")
  ) -> fig_2

ggsave(
  plot = fig_2,
  filename = paste0(Sys.Date(),"-figure2-Shared prosperity premiums and inclusivity premiums across 25 countries.jpeg"),
  device = "jpeg",
  path = here("charts/"),
  width =6.5,
  height = 4.5,
  units = "in"
)

# Figure 3: Inclusivity premiums and absolute changes in the MPIs  --------


data_as_inclusicve_tl|>
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
  geom_line(aes(y = Fig3_solid_black),
            size = 0.3,
            colour = "#000000"
  )+
  geom_line(aes(y = Fig3_solid_gray),
            size = 0.3,
            colour = "#898999"
  )+
  geom_text_repel(aes(label = ISO),
                  max.overlaps = 12,
                  size = 5.5)+
  theme_bw()+
  theme(
    axis.title = element_text(colour = "#000000",
                              size = 22),
    axis.text = element_text(colour = "#000000",
                             size = 18),
    text = element_text(family = "EB Garamond")
  ) -> fig_3

ggsave(
  plot = fig_3,
  filename = paste0(Sys.Date(),"-figure3-Inclusivity premiums and absolute changes in the MPIs across countries.jpeg"),
  device = "jpeg",
  path = here("charts/"),
  width = 6,
  height = 4,
  units = "in"
)


