library(wrapr)

from_point <- c(-77.0364, 38.8951)
to_point <- c(-78.0364, 39.8951)

dist <- 0.1
width <- 0.1
method <- "bilinear"
seg_id <- 1

#Must be in float64
ds <- "NE1_LR_LC.tif"

proj_str <- paste0(
  "+proj=tpeqd ",
  " +lon_1=", from_point[1], " +lat_1=",  from_point[2],
  " +lon_2=", to_point[1], " +lat_2=", to_point[2]
)
points_tpeqd <-
  sf::st_sfc(
    sf::st_point(from_point),
    sf::st_point(to_point),
    crs = "+proj=latlon"
  ) %.>%
  sf::st_transform(., proj_str)

point_1 <- points_tpeqd[[1]]
point_2 <- points_tpeqd[[2]]

bbox <- c(point_1[1], -(width * 0.5), point_2[1], (width * 0.5))

num_samples <- max(2, as.integer(ceiling((point_2[1] - point_1[1]) / dist)))

profile <- sf::gdal_utils(
  util = "warp",
  ds,
  "test_R.tif",
  config_options = c(
    dstSRS = proj_str,
    outputBounds = as.character(bbox),
    height = as.character(1),
    width = as.character(num_samples),
    resampleAlg = method
  )
)