library(dplyr)
library(ggplot2)
library(gridExtra)
library(ggpubr)
library(grid)
library(reshape2)

g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}

# Model fit
g <- read.csv("arxiv_analysis_v2.csv", head=T)

g <- g %>%
  mutate(before_n = ifelse(!is.na(before_n), before_n, "No info")) %>%
  mutate(before_n = factor(before_n, levels=c("No info", "0", "1", "5"),
                           labels=c("No citation information - prior citations unadjusted", 
                                    "0 arXiv citation - adjusting for prior citations", 
                                    "1 arXiv citation - adjusting for prior citations", 
                                    "5 arXiv citation - adjusting for prior citations"))) %>%
  mutate(discipline = factor(discipline, levels=c("hep-ph", "astro", "cond"),
                             labels=c("High energy physics", "Astrophysics", "Condensed matter")))
  
## Draw graphs
p1_m6 <- 
  g %>% filter(model != "m3" & month == "m6") %>%
  ggplot(., aes(x=AI, y=yhat, ymin=lb, ymax=ub, group=before_n, col=before_n, linetype=before_n)) +
  geom_line() +
  geom_ribbon(linetype=0, alpha=0.2) +
  theme_bw() +
  labs(x="Journal influence", 
       y="Predicted citation count \nafter journal publication",
       color="",
       linetype="") +
  theme(text = element_text(size=14), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        panel.background = element_blank(),
        strip.background = element_blank(),
        legend.position = "bottom",
        legend.direction = "vertical") +
  scale_color_manual(values=c("Red", "skyblue1", "dodgerblue1", "blue")) +
  scale_linetype_manual(values=c("dashed", "solid", "solid", "solid")) +
  scale_x_continuous(breaks=c(0, 1, 3, 5),
                     labels=c(0, 1, 3, 5)) +
  coord_trans(y="sqrt", x="sqrt") +
  facet_wrap(~discipline)

mylegend<-g_legend(p1_m6)

p1_m6 <- grid.arrange(
  p1_m6 + theme(legend.position="none"),
  mylegend, 
  heights=c(8,3))

ggsave(p1_m6, file="q1_more6_data.pdf", width=8, height=5)


p1_full <- 
  g %>% filter(model != "m3" & month == "full") %>%
  ggplot(., aes(x=AI, y=yhat, ymin=lb, ymax=ub, group=before_n, col=before_n, linetype=before_n)) +
  geom_line() +
  geom_ribbon(linetype=0, alpha=0.2) +
  theme_bw() +
  labs(x="Journal influence", 
       y="Predicted citation count \nafter journal publication",
       color="",
       linetype="") +
  theme(text = element_text(size=14), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        panel.background = element_blank(),
        strip.background = element_blank(),
        legend.position = "bottom",
        legend.direction = "vertical") +
  scale_color_manual(values=c("Red", "skyblue1", "dodgerblue1", "blue")) +
  scale_linetype_manual(values=c("dashed", "solid", "solid", "solid")) +
  scale_x_continuous(breaks=c(0, 1, 3, 5),
                     labels=c(0, 1, 3, 5)) +
  coord_trans(y="log") +
  facet_wrap(~discipline)

mylegend<-g_legend(p1_full)

p1_full <- grid.arrange(
  p1_full + theme(legend.position="none"),
  mylegend, 
  heights=c(8,3))

ggsave(p1_full, file="q1_full_data.pdf", width=8, height=5)

## Answer for question 2
g <- g[-which(g$discipline=="Astrophysics" & g$model=="m3" & g$month=="m6" & g$yhat==32.382380),]

g <- g %>%
  filter(model=="m3") %>%
  mutate(AI = factor(AI, levels=c("0.71", "1.41", "2.24"),
                     labels=c("0.5", "2", "5")))

p3_m6 <-
  g %>% filter(month == "m6") %>%
  ggplot(., aes(x=cite_n, y=yhat, ymin=lb, ymax=ub, group=as.factor(AI), linetype=as.factor(AI))) +
  geom_line() +
  geom_ribbon(linetype=0, alpha=0.2) +
  theme_bw() +
  labs(x="The rise of arXiv \n(Yearly total citations to papers uploaded to the arXiv)",
       y="Predicted citation count \nafter journal publication",
       linetype="Journal influence"
  ) +
  theme(text = element_text(size=14), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        panel.background = element_blank(),
        strip.background = element_blank(),
        legend.position = "bottom",
        legend.direction = "horizontal") +
  scale_x_continuous(breaks=c(0, 31.6, 44.7, 54.77),
                     labels=c(0, 1000, 2000, 3000)) +
  facet_wrap(~discipline) 
ggsave(p3_m6, file="q2_m6_data.pdf", width=8, height=4)

p3_full <- 
  g %>% filter(month == "full") %>%
  ggplot(., aes(x=cite_n, y=yhat, ymin=lb, ymax=ub, group=as.factor(AI), linetype=as.factor(AI))) +
  geom_line() +
  geom_ribbon(linetype=0, alpha=0.2) +
  theme_bw() +
  labs(x="The rise of arXiv \n(Yearly total citations to papers uploaded to the arXiv)",
       y="Predicted citation count \nafter journal publication",
       linetype="Journal influence"
  ) +
  theme(text = element_text(size=14), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        panel.background = element_blank(),
        strip.background = element_blank(),
        legend.position = "bottom",
        legend.direction = "horizontal") +
  scale_x_continuous(breaks=c(0, 31.6, 44.7, 54.77),
                     labels=c(0, 1000, 2000, 3000)) +
  facet_wrap(~discipline) 
ggsave(p3_full, file="q2_full_data.pdf", width=8, height=4)



