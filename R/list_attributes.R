z22_list_attributes <- function(dataset = NULL, feature = NULL, res = "100m") {
  idx_file <- system.file(sprintf("extdata/index_%s.txt", res), package = "z22")
  index <- readLines(idx_file)

  proto <- list(
    dataset = character(),
    feature = character(),
    category = integer()
  )

  index <- utils::strcapture(
    "(^[a-z]+)(?:_(.*?))?(?:_(\\d+))?$",
    index,
    proto = proto,
    perl = TRUE
  )

  index$feature[!nzchar(index$feature)] <- NA
  index <- index[order(index$dataset, index$feature, index$category),]

  if (!is.null(dataset)) {
    index <- index[index$dataset %in% dataset, ]
  }

  if (!is.null(feature)) {
    index <- index[index$feature %in% feature, ]
  }

  dplyr::as_tibble(index)
}


cat_dict <- list(
  demography = list(
    INSGESAMT = "total",
    ALTER_10JG = "age_long",
    ALTER_KURZ = "age_short",
    FAMSTND_AUSF = "marital_status",
    GEBURTLAND_GRP = "country_of_birth",
    GESCHLECHT = "sex",
    RELIGION_KURZ = "religion",
    STAATSANGE_GRP = "citizenship_groups",
    STAATSANGE_HLND = "citizenship_countries",
    STAATSANGE_KURZ = "citizenship_short",
    STAATZHL = "citizenship_number"
  ),
  families = list(
    FAMTYP_KIND = "family_type",
    FAMGROESS_KLASS = "family_size",
    HHTYP_SENIOR_HH = "household_elderly"
  ),
  households = list(
    HHTYP_FAM = "household_family",
    HHTYP_LEB = "household_lifestyle",
    HHGROESS_KLASS = "household_size"
  ),
  dwellings = list(
    NUTZUNG_DETAIL_HHGEN = "dwelling_use",
    WOHNEIGENTUM = "dwelling_ownership",
    WOHNFLAECHE_10S = "dwelling_space",
    RAUMANZAHL = "dwelling_rooms",
    GEBAEUDEART_SYS = "building_type",
    BAUJAHR_MZ = "building_year",
    EIGENTUM = "building_ownership",
    GEBTYPBAUWEISE = "building_construction",
    GEBTYPGROESSE = "building_size",
    HEIZTYP = "heating_type",
    ZAHLWOHNGN_HHG = "building_dwellings"
  ),
  buildings = list(
    GEBAEUDEART_SYS = "building_type",
    BAUJAHR_MZ = "building_year",
    EIGENTUM = "building_ownership",
    GEBTYPBAUWEISE = "building_construction",
    GEBTYPGROESSE = "building_size",
    HEIZTYP = "heating_type",
    ZAHLWOHNGN_HHG = "building_dwellings"
  )
)


