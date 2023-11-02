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
       "Alkire-Seth Trend-line data included revised.dta")
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
                              size = 25),
    axis.text = element_text(colour = "#000000",
                             size = 21),
    text = element_text(family = "EB Garamond")
  )-> fig_1

ggsave(
  plot = fig_1,
  filename = paste0(Sys.Date(),"-REVISED-figure1-Change in average attainment and inclusivity premium.jpeg"),
  device = "jpeg",
  path = here("charts/"),
  width = 6.5,
  height = 4.5,
  units = "in"
)

# Figure  2: Shared prosperity premiums and inclusivity premiums across 25 countries --------

### figure 2 is renamed as figure 3 see email from suman Oct 25, 2023

data_as_inclusicve_tl|>
  filter(x == 1)|>
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
  geom_line(data = data_as_inclusicve_tl,
            aes(x = y,y = Fig3_solid_black),
            size = 0.3,
            colour = "#000000"
  )+
  geom_line(data = data_as_inclusicve_tl,
            aes(x = y, y = Fig3_solid_gray),
            size = 0.3,
            colour = "#898999"
  )+
  geom_text_repel(aes(label = ISO),
                  max.overlaps = 12,
                  size = 5.5)+
  theme_bw()+
  theme(
    axis.title = element_text(colour = "#000000",
                              size = 25),
    axis.text = element_text(colour = "#000000",
                             size = 21),
    text = element_text(family = "EB Garamond")
  ) -> fig_2

ggsave(
  plot = fig_2,
  filename = paste0(Sys.Date(),"-REVISED-figure3-Shared prosperity premiums and inclusivity premiums across 25 countries.jpeg"),
  device = "jpeg",
  path = here("charts/"),
  width =6.5,
  height = 4.5,
  units = "in"
)

# Figure 3: Inclusivity premiums and absolute changes in the MPIs  --------

### figure 3 is renamed as figure 4 see email from suman Oct 25, 2023

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
  geom_line(aes(y = Fig4_solid_black),
            size = 0.3,
            colour = "#000000"
  )+
  geom_line(aes(y = Fig4_solid_gray),
            size = 0.3,
            colour = "#898999"
  )+
  geom_text_repel(aes(label = ISO),
                  max.overlaps = 12,
                  size = 5.5)+
  theme_bw()+
  theme(
    axis.title = element_text(colour = "#000000",
                              size = 25),
    axis.text = element_text(colour = "#000000",
                             size = 21),
    text = element_text(family = "EB Garamond")
  ) -> fig_3

ggsave(
  plot = fig_3,
  filename = paste0(Sys.Date(),"-REVISED-figure4-Inclusivity premiums and absolute changes in the MPIs across countries.jpeg"),
  device = "jpeg",
  path = here("charts/"),
  width = 6,
  height = 4,
  units = "in"
)



# Figure 2: Bound-adjusted change in inclusive well-being p.a. vs change in inclusive well-being per annum  -------

### See email by suman on 25, oct 2023


data_as_inclusicve_tl|>
  arrange(M01_33)|>
  mutate(
    rank_well_off = as.factor(c(rep("25 top well-off countries",25), 
                                rep("25 mid well-off countries",25), 
                                rep("25 least well-off countries",25))
    )
  )|>
  ggplot(aes(d_W_Sen_pa, db_W_Sen_pa))+
  geom_point(
    size = 1.5,
    aes(
      shape = rank_well_off,
      colour = rank_well_off
      )
    )+
  scale_colour_manual(name = NULL,
                      values = c("#000000",
                                 "#999999",
                                 "#000000")
                      )+
  scale_shape_discrete(name = NULL)+
  scale_y_continuous(breaks = seq(from = -1,
                                  by = 1,
                                  to = 8))+
  scale_x_continuous(breaks = seq(from = -0.3,
                                  by = 0.3,
                                  to = 2.7))+
  labs(
    y = "Bound-adjusted change in inclusive well-being p.a. (%)",
    x = "Absolute change in inclusive well-being per annum"
  )+
  geom_line(aes(y = Fig2_solid_black),
            size = 0.3,
            colour = "#000000"
  )+
  geom_hline(aes(yintercept = 3),
             linetype = 2,
             colour = "#000000")+
  geom_vline(xintercept = 1.1,
             linetype = 2,
             colour = "#000000"
             )+
  geom_text_repel(aes(label = ISO),
                  max.overlaps = 12,
                  size = 5.5)+
  theme_bw()+
  theme(
    axis.title = element_text(colour = "#000000",
                              size = 25),
    axis.text = element_text(colour = "#000000",
                             size = 21),
    legend.text = element_text(colour = "#000000",
                               size = 22),
    legend.title = NULL,
    legend.direction = "horizontal",
    legend.position = "bottom",
    text = element_text(family = "EB Garamond")
  ) -> fig_2

ggsave(
  plot = fig_2,
  filename = paste0(Sys.Date(),"-REVISED-figure2-Bound-adjusted change in inclusive well-being p.a. vs change in inclusive well-being per annum.jpeg"),
  device = "jpeg",
  path = here("charts/"),
  width = 6,
  height = 4,
  units = "in"
)


