library(ggmap)

m <- get_map("Jakarta",zoom=12,maptype="terrain",source="google")
ggmap(m)
