features <- z22_features()

test_that("feature list subsets correctly", {
  expect_true(all(z22_features(year = "2022")$z22))
  expect_true(all(z22_features(year = "2011", res = "100m")$z11_100m))
  expect_true(all(z22_features(year = "2011", res = "1km")$z11_1km))
  expect_in("Population", z22_features(theme = "population")$theme)
  expect_failure(expect_equal(z22_features(legacy_names = TRUE)$feature, features$feature))
  expect_error(z22_features("test"), "does not exist")
  expect_error(z22_features(year = "test"), "Year")
  expect_error(z22_features(res = "test"), "resolutions")
})


test_that("categories are assigned correctly", {
  expect_equal(z22_categories("population")$code, 0)
  expect_equal(z22_categories("citizenship")$code, c(1, 2))
  expect_error(z22_categories("test"), "available")
})


test_that("decoding works", {
  expect_equal(z22_decode(c(1, 2, 1), "sex"), c("Male", "Female", "Male"))
  expect_equal(z22_decode(c(1, NA), "sex"), c("Male", NA))
  expect_equal(z22_decode(c("cat_1", NA), "sex"), c("Male", NA))
  expect_equal(z22_decode(as.factor(c(1, NA)), "sex"), c("Male", NA))
})


test_that("inspire can be converted", {
  skip_if_not_installed("dplyr")
  coords <- dplyr::tibble(x = c(50, 150), y = c(50, 150))
  inspire <- z22_inspire_generate(coords)
  expect_equal(z22_inspire_extract(inspire), coords)
})


test_that("data can be downloaded and prepared", {
  skip_on_cran()
  skip_if_offline("github.com")

  grid1 <- z22_data("citizenship", res = "10km")
  expect_named(grid1, c("cat_1", "cat_2", "x", "y"))
  pvt <- z22_pivot_longer(grid1, "citizenship")
  expect_false(all(is.na(pvt$category)))
  expect_false(all(is.na(pvt$value)))

  grid2 <- z22_data("citizenship", res = "10km", normalize = TRUE)
  # 0.1 tolerance because sometimes the population is lower than the
  # number of people per cell, possibly due to the cell key method
  expect_false(any(na.omit(grid2$cat_1) > 1.1))

  grid3 <- z22_data("citizenship", res = "10km", all_cells = TRUE)
  expect_gt(nrow(grid3), nrow(grid1))

  skip_if_not_installed("terra")
  grid4 <- z22_data("citizenship", res = "10km", rasterize = TRUE)
  expect_s4_class(grid4, "SpatRasterDataset")
  expect_length(grid4, 2)

  skip_if_not_installed("sf")
  grid5 <- z22_data("citizenship", res = "10km", as_sf = TRUE)
  expect_s3_class(grid5, "sf")
})
