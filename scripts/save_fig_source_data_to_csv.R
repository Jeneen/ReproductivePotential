s_fig_1a <- marg_fec
s_fig_1b1 <- den_plot[[1]]$data
s_fig_1b2 <- den_plot[[2]]$data
s_fig_1c <- linear_fig$data


write.csv(s_fig_1a, "fig_source/s_fig_1a.csv")
write.csv(s_fig_1b1, "fig_source/s_fig_1b1.csv")
write.csv(s_fig_1b2, "fig_source/s_fig_1b2.csv")
write.csv(s_fig_1c, "fig_source/s_fig_1c.csv")

s_fig_2a <- all_plot$data
s_fig_2b <- lut_plot$data
s_fig_2c <- scar_plot$data
s_fig_2d <- ser_plot$data

write.csv(s_fig_2a, "fig_source/s_fig_2a.csv")
write.csv(s_fig_2b, "fig_source/s_fig_2b.csv")
write.csv(s_fig_2c, "fig_source/s_fig_2c.csv")
write.csv(s_fig_2d, "fig_source/s_fig_2d.csv")


s_fig_3a <- ratios_b20
s_fig_3b <- ratios_matF
s_fig_3c <- ratios_fec
s_fig_3d <- ratios_lut
s_fig_3e <- ratios_scar
s_fig_3f <- ratios_ser

write.csv(s_fig_3a, "fig_source/s_fig_3a.csv")
write.csv(s_fig_3b, "fig_source/s_fig_3b.csv")
write.csv(s_fig_3c, "fig_source/s_fig_3c.csv")
write.csv(s_fig_3d, "fig_source/s_fig_3d.csv")
write.csv(s_fig_3e, "fig_source/s_fig_3e.csv")
write.csv(s_fig_3f, "fig_source/s_fig_3f.csv")

