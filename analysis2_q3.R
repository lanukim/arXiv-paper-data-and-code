library(ggplot2)
library(dplyr)
library(survival)
library(simPH)

load("arxiv_data.Rdata")

# Models
m_hep <- coxph(Surv(t_start, t_end, pub_journal) ~
                sqrt_cum
               + n_year
               + sqrt_cum*n_year
               ,
               data=analysis2_hep)

m_astro <- coxph(Surv(t_start, t_end, pub_journal) ~
                   sqrt_cum
                 + n_year
                 + sqrt_cum*n_year
                 ,
               data=analysis2_astro)

m_cond <- coxph(Surv(t_start, t_end, pub_journal) ~
                  sqrt_cum
                + n_year
                + sqrt_cum*n_year
                ,
               data=analysis2_cond)

sim_hep <- coxsimInteract(m_hep, 
                       b1 = "sqrt_cum", b2 = "n_year",
                       qi = "Marginal Effect",
                       X2 = seq(0, 15, by = 3), nsim = 1000)
sim_hep <- simGG(sim_hep, ribbons = TRUE, alpha = 0.5)

sim_astro <- coxsimInteract(m_astro, 
                            b1 = "sqrt_cum", b2 = "n_year",
                            qi = "Marginal Effect",
                            X2 = seq(0, 15, by = 3), nsim = 1000)
sim_astro <- simGG(sim_astro, ribbons = TRUE, alpha = 0.5)

sim_cond <- coxsimInteract(m_cond, 
                           b1 = "sqrt_cum", b2 = "n_year",
                           qi = "Marginal Effect",
                           X2 = seq(0, 15, by = 3), nsim = 1000)
sim_cond <- simGG(sim_cond, ribbons = TRUE, alpha = 0.5)

n = length(seq(0, 15, by=3))
sim_hep <- data.frame(median=sim_hep$data$Median, 
                      ub=sim_hep$data$Max, 
                      lb=sim_hep$data$Min,
                      discipline="Hep-ph",
                      x=seq(0, 15, by=3)
                      )
sim_astro <- data.frame(median=sim_astro$data$Median, 
                      ub=sim_astro$data$Max, 
                      lb=sim_astro$data$Min,
                      discipline="Astrophysics",
                      x=seq(0, 15, by=3)
                      )
sim_cond <- data.frame(median=sim_cond$data$Median, 
                      ub=sim_cond$data$Max, 
                      lb=sim_cond$data$Min,
                      discipline="Condensed matter",
                      x=seq(0, 15, by=3)
                      )

sim <- rbind(sim_hep, sim_astro, sim_cond)

ggplot(sim, aes(x=x, y=median, col=discipline)) +
  geom_line() +
  geom_ribbon(aes(ymin=lb, ymax=ub, linetype=NA), alpha = 0.15) +
  theme_bw() +
  labs(x="Year", 
       y="Effect size of citation count accumulated in the arXiv\n before journal publication",
       color="") +
  theme(text = element_text(size=12), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        panel.background = element_blank(),
        strip.background = element_rect(colour=NA, fill=NA)) +
  scale_x_continuous(
    breaks = c(0, 3, 6, 9, 12, 15),
    labels = c(1998, 2001, 2004, 2007, 2010, 2013)
  ) +
  scale_y_continuous(limits=c(0.9, 1.8))
ggsave("survival_marginal_effect_year.pdf", width = 6, height = 4.5)


# Robust check with the total citations made to arXiv in a given year
m_hep_robust <- coxph(Surv(t_start, t_end, pub_journal) ~
                 sqrt_cum
               + sqrt_cite_n
               + sqrt_cum*sqrt_cite_n
               ,
               data=analysis2_hep)

m_astro_robust <- coxph(Surv(t_start, t_end, pub_journal) ~
                   sqrt_cum
                 + sqrt_cite_n
                 + sqrt_cum*sqrt_cite_n
                 ,
                 data=analysis2_astro)

m_cond_robust <- coxph(Surv(t_start, t_end, pub_journal) ~
                  sqrt_cum
                + sqrt_cite_n
                + sqrt_cum*sqrt_cite_n
                ,
                data=analysis2_cond)
























