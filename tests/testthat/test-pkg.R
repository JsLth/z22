features <- z22_features()

test_that("feature list subsets correctly", {
  expect_true(all(z22_features(year = "2022")$z22))
  expect_true(all(z22_features(year = "2011", res = "100m")$z11_100m))
  expect_true(all(z22_features(year = "2011", res = "1km")$z11_1km))
  expect_no_error(z22_features(year = "2011"))
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
  coords1 <- dplyr::tibble(x = c(50, 150), y = c(50, 150))
  coords2 <- dplyr::tibble(lon = c(50, 150), lat = c(50, 150))
  coords3 <- sf::st_as_sf(coords1, coords = c("x", "y"))
  coords4 <- as.matrix(coords1)
  inspire1 <- z22_inspire_generate(coords1)
  inspire2 <- z22_inspire_generate(coords2)
  inspire3 <- z22_inspire_generate(coords3)
  inspire4 <- z22_inspire_generate(coords4)
  inspire5 <- z22_inspire_generate(coords1, legacy = TRUE)
  inspire6 <- z22_inspire_generate(coords1, res = "100m")
  expect_equal(inspire1, inspire2)
  expect_equal(inspire1, inspire3)
  expect_equal(inspire1, inspire4)
  expect_equal(inspire1, inspire6)
  expect_equal(z22_inspire_extract(inspire1), coords1)
  expect_equal(z22_inspire_extract(inspire5), coords1)

  coords5 <- dplyr::tibble(x = c(500, 1500), y = c(500, 1500))
  coords6 <- dplyr::tibble(x = c(500, 1500), y = c(500, 1200))
  expect_equal(z22_inspire_generate(coords5, legacy = TRUE), c("1kmN0E0", "1kmN1E1"))
  expect_error(z22_inspire_generate(coords6), "properly aligned")
  expect_warning(z22_inspire_extract(c("CRS4326RES100mN0E0", "CRS3035RES100mN1E1"), as_sf = TRUE))
  expect_equal(sf::st_crs(z22_inspire_extract(c("1kmN0E0", "1kmN1E1"), as_sf = TRUE))$epsg, 3035)
})


test_that("data can be downloaded and prepared", {
  expect_error(z22_data("test"), "available")

  skip_on_cran()
  skip_if_offline("github.com")
  skip_if_not(arrow::codec_is_available("zstd"))

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


test_that("grid can be downloaded", {
  skip_if_not(arrow::codec_is_available("zstd"))
  expect_error(z22_grid(year = -999), "for year")
  expect_error(z22_grid(res = "test"), "resolution of")
  expect_named(z22_grid("100km"), c("x", "y"))
})


test_that("data can be read offline", {
  skip_if_not(arrow::codec_is_available("zstd"))
  old <- options(z22.data_repo = test_path("fixtures"))
  on.exit(options(old))
  expect_equal(nrow(z22_data("foreigners")), 6)
  options(z22.data_repo = "test")
  expect_error(z22_data("foreigners"), "not a valid")
})


test_that("data can be pivoted", {
  skip_if_not(arrow::codec_is_available("zstd"))
  old <- options(z22.data_repo = test_path("fixtures"))
  on.exit(options(old))
  piv1 <- z22_pivot_longer(z22_data("citizenship"), "citizenship")
  piv2 <- z22_pivot_longer(z22_data("citizenship", as_sf = TRUE), "citizenship")
  piv3 <- z22_pivot_longer(z22_data("citizenship", rasterize = TRUE), "citizenship")
  coords <- sf::st_coordinates(piv2)
  piv2 <- dplyr::tibble(sf::st_drop_geometry(piv2), x = coords[, "X"], y = coords[, "Y"])
  names(piv2) <- tolower(names(piv2))
  expect_true(setequal(piv1$value, piv2$value))
  expect_true(setequal(piv1$value, piv3$value))
})


test_that("checkers work", {
  expect_no_error(check_length(1, 1))
  expect_no_error(check_length(NULL, 1, null = TRUE))
  expect_no_error(check_string("test"))
  expect_no_error(check_string(NULL, null = TRUE))
  expect_no_error(check_integerish(1))
  expect_no_error(check_integerish(NULL, null = TRUE))
  expect_no_error(check_class(1, "numeric"))
  expect_no_error(check_class(NULL, "numeric", null = TRUE))
  expect_no_error(check_date(Sys.time()))
  expect_no_error(check_date(NULL, null = TRUE))
  expect_no_error(check_loadable("httr2"))
  expect_no_error(check_feature("women", 2011, "1km"))
  expect_no_error(check_feature(NULL, 2022, "100m", null = TRUE))
  expect_no_error(check_category(c(1, 2), "citizenship"))
  expect_no_error(check_category(NULL, NULL, null = TRUE))
  check_normalize(TRUE, "citizenship")

  expect_error(check_length(1, 2))
  expect_error(check_length(NULL, 1))
  expect_error(check_string(1))
  expect_error(check_integerish(1.1))
  expect_error(check_class(1, "character"))
  expect_error(check_date("2024"))
  expect_error(check_loadable("___"))
  expect_error(check_resolution("10km", 2011))
  expect_error(check_feature("test"), "valid Census feature")
  expect_error(check_feature("rent_avg", 2011, "100m"), "at a resolution")
  expect_error(check_feature("women", 2022), "for 2022")
  expect_error(check_category(c(1, 2), "women"), "code 1")
  expect_error(check_normalize(TRUE, "women"), "shares or averages")
})
