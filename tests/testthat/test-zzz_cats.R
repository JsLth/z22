# tests all combinations of features and categories to see if there are stale ones
# always skip
skip("This test must be run interactively.")

feats <- z22_features()
for (feat in feats$feature[feats$z22]) {
  message("Testing:", feat, "(2022, 10km)")
  z22_data(feat, year = 2022, res = "10km")
}


for (feat in feats$feature[feats$z11_1km]) {
  message("Testing: ", feat, " (2011, 1km)")
  z22_data(feat, year = 2011, res = "1km")
}


for (feat in feats$feature[feats$z11_100m]) {
  message("Testing: ", feat, " (2011, 100m)")
  z22_data(feat, year = 2011, res = "100m")
}