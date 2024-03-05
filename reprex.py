from pyproj import CRS, Transformer
from osgeo import gdal
import pyproj.exceptions
import math
import multiprocessing
import alive_progress
import pathos.pools
import pandas
import shapely
import geopandas

gdal.UseExceptions()

from_point = [-77.0364, 38.8951]
to_point = [-78.0364, 39.8951]
ds = gdal.Open("NE1_LR_LC.tif")
dist = 0.1
width = 0.1
method = "bilinear"
seg_id = 1

proj_str = "+proj=tpeqd +lon_1={} +lat_1={} +lon_2={} +lat_2={}".format(
    from_point[0], from_point[1],
    to_point[0], to_point[1])

points_tpeqd = geopandas.GeoDataFrame(
  geometry = [
    shapely.Point(from_point),
    shapely.Point(to_point)
  ],
  crs = "+proj=latlon"
).to_crs(proj_str)

point_1 = points_tpeqd["geometry"][0].coords[0]
point_2 = points_tpeqd["geometry"][1].coords[0]

bbox = [point_1[0], -(width * 0.5), point_2[0], (width * 0.5)]

num_samples = max(2, int(math.ceil((point_2[0] - point_1[0]) / dist)))

profile = gdal.Warp(
  "test_py.tif",
  ds,
  dstSRS=proj_str,
  outputBounds=bbox,
  height=1,
  width=num_samples,
  resampleAlg=method
)