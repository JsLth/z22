#' Feature categories
#' @description
#' While some features contain total counts or averages, others contain figures
#' classified by certain categories. You can access these tables
#' programmatically using \code{z22_categories}.
#'
#' For further clarification of terms used in the category labels, see
#' the \link{glossary}.
#'
#' @param feature A grid feature. See \code{\link{z22_features}} for a list
#' of available features. If a feature is provided that does not have
#' categories, generates a table based on the feature description.
#'
#' @evalRd make_rd_categories()
#' @name categories
#' @export
#'
#' @examples
#' z11_categories("sex")
#' z11_categories("families")
z22_categories <- function(feature) {
  if (!feature %in% names(categories) && !feature %in% features$name) {
    cli::cli_abort(c(
      "No feature {.val {feature}} available.",
      "i" = "See `z22_features()` for a list of available features."
    ))
  } else if (feature %in% names(categories)) {
    categories[[feature]]
  } else {
    feat_df <- features[features$name %in% feature, ]
    dplyr::tibble(
      code = 0,
      german = feat_df$german,
      english = feat_df$english
    )
  }
}

categories <- list(
  birth_country = tibble::tibble(
    code = c(1, 20, 21, 22, 23, 24),
    german = c("Deutschland", "Ausland", "EU27-Land", "Europa", "Welt", "Sonstige"),
    english = c("Germany", "Foreign", "EU27 country", "Europe", "World", "Other"),
  ),
  sex = tibble::tibble(
    code = 1:2,
    german = c("M\U{E4}nnlich", "Weiblich"),
    english = c("Male", "Female"),
  ),
  religion = tibble::tibble(
    code = 1:3,
    german = c(
      "R\U{F6}misch-katholische Kirche", "Evangelische Kirche",
      "Sonstige, keine, ohne Angabe"
    ),
    english = c("Roman Catholic Church", "Evangelical Church", "Other, none, no information"),
  ),
  citizenship = tibble::tibble(
    code = 1:2,
    german = c("Deutschland", "Ausland"),
    english = c("Germany", "Foreign"),
  ),
  citizenship_group = tibble::tibble(
    code = c(1, 20, 21, 22, 23, 24),
    german = c("Deutschland", "Ausland", "EU27-Land", "Sonstiges Europa", "Sonstige Welt", "Sonstige"),
    english = c("Germany", "Foreign", "EU27 Country", "Other Europe", "Other World", "Other"),
  ),
  citizenship_origin = tibble::tibble(
    code = 1:14,
    german = c(
      "Deutschland", "Bosnien und Herzegowina", "Griechenland", "Italien",
      "Kasachstan", "Kroatien", "Niederlande", "\U{D6}sterreich", "Polen",
      "Rum\U{E4}nien", "Russische F\U{F6}deration", "T\U{FC}rkei", "Ukraine",
      "Sonstige"
    ),
    english = c(
      "Germany", "Bosnia and Herzegovina", "Greece", "Italy", "Kazakhstan",
      "Croatia", "Netherlands", "Austria", "Poland", "Romania",
      "Russian Federation", "Turkey", "Ukraine", "Other"
    ),
  ),
  citizenship_total = tibble::tibble(
    code = 1:4,
    german = c(
      "Eine Staatsangeh\U{F6}rigkeit", "Mehrere, deutsch und ...",
      "Mehrere, nur ausl\U{E4}ndische", "Nicht bekannt"
    ),
    english = c("One citizenship", "Several, German and ...", "Several, only foreign", "Unknown"),
  ),
  age_short = tibble::tibble(
    code = 1:5,
    german = c("Unter 18", "18 - 29", "30 - 49", "50 - 64", "65 und \U{E4}lter"),
    english = c("Under 18", "18 to 29", "30 to 49", "50 to 64", "65 and older"),
  ),
  age_long = tibble::tibble(
    code = 1:9,
    german = c(
      "Unter 10", "10 - 19", "20 - 29", "30 - 39", "40 - 49", "50 - 59", "60 - 69",
      "70 - 79", "80 und \U{E4}lter"
    ),
    english = c(
      "Under 10", "10 to 19", "20 to 29", "30 to 39", "40 to 49", "50 to 59",
      "60 to 69", "70 to 79", "80 and older"
    ),
  ),
  marital_status = tibble::tibble(
    code = 1:8,
    german = c(
      "Ledig", "Verheiratet", "Verwitwet", "Geschieden",
      "Eingetr. Lebenspartnerschaft", "Eingetr. Lebenspartner/-in verstorben",
      "Eingetr. Lebenspartnerschaft aufgehoben", "Ohne Angabe"
    ),
    english = c(
      "Single", "Married", "Widowed", "Divorced", "Registered partnership",
      "Registered partner deceased", "Registered partnership annulled",
      "No information"
    ),
  ),
  family_type = tibble::tibble(
    code = seq(1, 13, by = 1),
    german = c(
      "Ehepaare ohne Kind", "Ehepaare, mind. 1 Kind < 18",
      "Ehepaare alle Kinder \U{2265} 18",
      "Eingetr. Lebenspartnerschaften ohne Kind",
      "Eingetr. Lebenspartnerschaften mind. 1 Kind < 18",
      "Eingetr. Lebenspartnerschaften alle Kinder \U{2265} 18",
      "Nichteheliche Lebensgem. ohne Kind",
      "Nichteheliche Lebensgem. mind. 1 Kind < 18",
      "Nichteheliche Lebensgem. alle Kinder \U{2265} 18",
      "Alleinerziehende V\U{E4}ter mind. 1 Kind < 18",
      "Alleinerziehende V\U{E4}ter alle Kinder \U{2265} 18",
      "Alleinerziehende M\U{FC}tter mind. 1 Kind < 18",
      "Alleinerziehende M\U{FC}tter alle Kinder \U{2265} 18"
    ),
    english = c(
      "Couples without child", "Couples, at least 1 child < 18",
      "Couples all children \U{2265} 18",
      "Registered civil partnerships without child",
      "Registered civil partnerships, at least 1 child < 18",
      "Registered civil partnerships all children \U{2265} 18",
      "Non-marital partnerships without child",
      "Non-marital partnerships, at least 1 child < 18",
      "Non-marital partnerships all children \U{2265} 18",
      "Single fathers, at least 1 child < 18",
      "Single fathers all children \U{2265} 18",
      "Single mothers, at least 1 child < 18",
      "Single mothers all children \U{2265} 18"
    ),
  ),
  family_size = tibble::tibble(
    code = seq(1, 5, by = 1),
    german = c("2 Personen", "3 Personen", "4 Personen", "5 Personen", "6 und mehr Personen"),
    english = c("2 Persons", "3 Persons", "4 Persons", "5 Persons", "6 and more Persons"),
  ),
  household_family = tibble::tibble(
    code = seq(1, 5, by = 1),
    german = c(
      "Einpersonenhaushalte (Singlehaushalte)", "Paare ohne Kind(er)",
      "Paare mit Kind(ern)", "Alleinerziehende Elternteile",
      "Mehrpersonenhaushalte ohne Kernfamilie"
    ),
    english = c(
      "One-person households (Single households)", "Couples without child(ren)",
      "Couples with child(ren)", "Single parents",
      "Multi-person households without core family"
    ),
  ),
  household_lifestyle = tibble::tibble(
    code = seq(1, 7, by = 1),
    german = c(
      "Einpersonenhaushalte (Singlehaushalte)", "Ehepaare",
      "Eingetr. Lebenspartnerschaften", "Nichteheliche Lebensgemeinschaften",
      "Alleinerziehende M\U{FC}tter", "Alleinerziehende V\U{E4}ter",
      "Mehrpersonenhaushalte ohne Kernfamilie"
    ),
    english = c(
      "One-person households (Single households)", "Married couples",
      "Registered civil partnerships", "Non-marital partnerships", "Single mothers",
      "Single fathers", "Multi-person households without core family"
    ),
  ),
  household_senior = tibble::tibble(
    code = c(1, 2, 3),
    german = c(
      "Haushalte mit ausschlie\U{DF}lich Senioren/-innen",
      "Haushalte mit Senioren/-innen und J\U{FC}ngeren",
      "Haushalte ohne Senioren/-innen"
    ),
    english = c(
      "Households with only seniors", "Households with seniors and younger people",
      "Households without seniors"
    ),
  ),
  household_size_group = tibble::tibble(
    code = seq(1, 6, by = 1),
    german = c(
      "1 Person", "2 Personen", "3 Personen", "4 Personen", "5 Personen",
      "6 und mehr Personen"
    ),
    english = c(
      "1 Person", "2 Persons", "3 Persons", "4 Persons", "5 Persons",
      "6 and more Persons"
    ),
  ),
  dwelling_occupancy = tibble::tibble(
    code = c(1, 11, 12, 2, 21, 22, 3, 4, 5, 99),
    german = c(
      "Von Eigent\U{FC}mer/-in bewohnt",
      "Eigentum: mit aktuell gef\U{FC}hrtem Haushalt",
      "Eigentum: ohne aktuell gef\U{FC}hrtem Haushalt", "Zu Wohnzwecken vermietet",
      "Vermietet: mit aktuell gef\U{FC}hrtem Haushalt",
      "Vermietet: ohne aktuell gef\U{FC}hrtem Haushalt",
      "Ferien- und Freizeitwohnung", "Leer stehend",
      "Diplomaten-/Streitkr\U{E4}ftewohnung", "Gewerbl. Nutzung"
    ),
    english = c(
      "Occupied by owner", "Ownership: with currently managed household",
      "Ownership: without currently managed household",
      "Rented for residential purposes", "Rented: with currently managed household",
      "Rented: without currently managed household", "Holiday and leisure home",
      "Vacant", "Diplomatic/Military housing", "Commercial use"
    ),
  ),
  dwelling_ownership_home = tibble::tibble(
    code = c(1, 2, 3, 4, 99),
    german = c(
      "Privatperson/-en", "Privatwirtschaftliche Unternehmen (jur. Personen)",
      "\U{D6}ffentliche Unternehmen, Kirchen o.\U{E4}.", "Wohnungsgenossenschaft",
      "Trifft nicht zu (da keine Eigentumswohnung)"
    ),
    english = c(
      "Private person(s)", "Private sector companies (legal persons)",
      "Public companies, churches or similar", "Housing cooperative",
      "Does not apply (no condominium)"
    ),
  ),
  dwelling_ownership_property = tibble::tibble(
    code = seq(1, 8, by = 1),
    german = c(
      "Gemeinschaft von Wohnungseigent\U{FC}mern/-innen", "Privatperson/-en",
      "Wohnungsgenossenschaft", "Kommune oder Kommunales Wohnungsunternehmen",
      "Privatwirtschaftliches Wohnungsunternehmen",
      "Anderes privatwirtschaftliches Unternehmen", "Bund oder Land",
      "Organisation ohne Erwerbszweck (z.B. Kirche)"
    ),
    english = c(
      "Homeowner association", "Private person(s)", "Housing cooperative",
      "Municipality or municipal housing company", "Private sector housing company",
      "Other private sector company", "Federal or state government",
      "Non-profit organization (e.g. church)"
    ),
  ),
  floor_space = tibble::tibble(
    code = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 99),
    german = c(
      "Unter 30", "30 - 39", "40 - 49", "50 - 59", "60 - 69", "70 - 79", "80 - 89",
      "90 - 99", "100 - 109", "110 - 119", "120 - 129", "130 - 139", "140 - 149",
      "150 - 159", "160 - 169", "170 - 179", "180 und mehr", "t.n.z., gewerblich"
    ),
    english = c(
      "Under 30", "30 - 39", "40 - 49", "50 - 59", "60 - 69", "70 - 79", "80 - 89",
      "90 - 99", "100 - 109", "110 - 119", "120 - 129", "130 - 139", "140 - 149",
      "150 - 159", "160 - 169", "170 - 179", "180 and more", "n.a., commercial"
    ),
  ),
  dwelling_rooms = tibble::tibble(
    code = c(1, 2, 3, 4, 5, 6, 7, 99),
    german = c(
      "1 Raum", "2 R\U{E4}ume", "3 R\U{E4}ume", "4 R\U{E4}ume", "5 R\U{E4}ume",
      "6 R\U{E4}ume", "7 und mehr R\U{E4}ume", "t.n.z., gewerblich"
    ),
    english = c(
      "1 Room", "2 Rooms", "3 Rooms", "4 Rooms", "5 Rooms", "6 Rooms",
      "7 and more Rooms", "n.a., commercial"
    ),
  ),
  dwelling_constr_year = tibble::tibble(
    code = seq(1, 10, by = 1),
    german = c(
      "Vor 1919", "1919 - 1948", "1949 - 1978", "1979 - 1986", "1987 - 1990",
      "1991 - 1995", "1996 - 2000", "2001 - 2004", "2005 - 2008",
      "2009 und sp\U{E4}ter"
    ),
    english = c(
      "Before 1919", "1919 - 1948", "1949 - 1978", "1979 - 1986", "1987 - 1990",
      "1991 - 1995", "1996 - 2000", "2001 - 2004", "2005 - 2008", "2009 and later"
    ),
  ),
  dwelling_building_type = tibble::tibble(
    code = c(1, 11, 111, 112, 12),
    german = c(
      "Geb\U{E4}ude mit Wohnraum", "Wohngeb\U{E4}ude",
      "Wohngeb\U{E4}ude (ohne Wohnheime)", "Wohnheim",
      "Sonstiges Geb\U{E4}ude mit Wohnraum"
    ),
    english = c(
      "Building with living space", "Residential building",
      "Residential building (excluding dormitories)", "Dormitory",
      "Other building with living space"
    ),
  ),
  dwelling_building_design = tibble::tibble(
    code = seq(1, 4, by = 1),
    german = c(
      "Freistehendes Haus", "Doppelhaus H\U{E4}lfte", "Gereihtes Haus",
      "Anderer Geb\U{E4}udetyp"
    ),
    english = c("Detached house", "Semi-detached house", "Terraced house", "Other building type"),
  ),
  dwelling_building_size = tibble::tibble(
    code = seq(1, 10, by = 1),
    german = c(
      "Freistehendes Einfamilienhaus", "Einfamilienhaus: Doppelhaush\U{E4}lfte",
      "Einfamilienhaus: Reihenhaus", "Freistehendes Zweifamilienhaus",
      "Zweifamilienhaus: Doppelhaush\U{E4}lfte", "Zweifamilienhaus: Reihenhaus",
      "Mehrfamilienhaus: 3-6 Wohnungen", "Mehrfamilienhaus: 7-12 Wohnungen",
      "Mehrfamilienhaus: 13 und mehr Wohnungen", "Anderer Geb\U{E4}udetyp"
    ),
    english = c(
      "Detached single-family house", "Single-family house: semi-detached",
      "Single-family house: terraced", "Detached two-family house",
      "Two-family house: semi-detached", "Two-family house: terraced",
      "Multi-family house: 3-6 apartments", "Multi-family house: 7-12 apartments",
      "Multi-family house: 13 and more apartments", "Other building type"
    ),
  ),
  dwelling_heat_type = tibble::tibble(
    code = seq(1, 6, by = 1),
    german = c(
      "Fernheizung (Fernw\U{E4}rme)", "Etagenheizung", "Blockheizung",
      "Zentralheizung", "Einzel-/Mehrraum\U{F6}fen (auch Nachtspeicherheizung)",
      "Keine Heizung im Geb\U{E4}ude oder in den Wohnungen"
    ),
    english = c(
      "District heating (long-distance heating)", "Floor heating", "Block heating",
      "Central heating",
      "Individual/multi-room stoves (including night storage heating)",
      "No heating in the building or in the apartments"
    ),
  ),
  dwelling_heat_src = tibble::tibble(
    code = seq(1, 9, by = 1),
    german = c(
      "Gas", "Heiz\U{F6}l", "Holz(pellets)", "Biomasse (ohne Holz), Biogas",
      "Solar-/Geothermie, W\U{E4}rmepumpen", "Strom (ohne W\U{E4}rmepumpen)",
      "Kohle", "Fernw\U{E4}rme", "Kein Energietr\U{E4}ger"
    ),
    english = c(
      "Gas", "Heating oil", "Wood (pellets)", "Biomass (no wood), biogas",
      "Solar, geothermal, heat pumps", "Electric heating (no heat pumps)", "Coal",
      "District heating", "No heating"
    ),
  ),
  building_ownership_property = tibble::tibble(
    code = seq(1, 8, by = 1),
    german = c(
      "Gemeinschaft von Wohnungseigent\U{FC}mern/-innen", "Privatperson/-en",
      "Wohnungsgenossenschaft", "Kommune oder Kommunales Wohnungsunternehmen",
      "Privatwirtschaftliches Wohnungsunternehmen",
      "Anderes privatwirtschaftliches Unternehmen", "Bund oder Land",
      "Organisation ohne Erwerbszweck (z.B. Kirche)"
    ),
    english = c(
      "Homeowner association", "Private person(s)", "Housing cooperative",
      "Municipality or municipal housing company", "Private sector housing company",
      "Other private sector company", "Federal or state government",
      "Non-profit organization (e.g. church)"
    ),
  ),
  building_constr_year = tibble::tibble(
    code = seq(1, 10, by = 1),
    german = c(
      "Vor 1919", "1919 - 1948", "1949 - 1978", "1979 - 1986", "1987 - 1990",
      "1991 - 1995", "1996 - 2000", "2001 - 2004", "2005 - 2008",
      "2009 und sp\U{E4}ter"
    ),
    english = c(
      "Before 1919", "1919 - 1948", "1949 - 1978", "1979 - 1986", "1987 - 1990",
      "1991 - 1995", "1996 - 2000", "2001 - 2004", "2005 - 2008", "2009 and later"
    ),
  ),
  building_dwellings = tibble::tibble(
    code = seq(1, 5, by = 1),
    german = c(
      "1 Wohnung", "2 Wohnungen", "3 - 6 Wohnungen", "7 - 12 Wohnungen",
      "13 und mehr Wohnungen"
    ),
    english = c(
      "1 Apartment", "2 Apartments", "3 - 6 Apartments", "7 - 12 Apartments",
      "13 and more Apartments"
    ),
  ),
  building_size = tibble::tibble(
    code = seq(1, 10, by = 1),
    german = c(
      "Freistehendes Einfamilienhaus", "Einfamilienhaus: Doppelhaush\U{E4}lfte",
      "Einfamilienhaus: Reihenhaus", "Freistehendes Zweifamilienhaus",
      "Zweifamilienhaus: Doppelhaush\U{E4}lfte", "Zweifamilienhaus: Reihenhaus",
      "Mehrfamilienhaus: 3-6 Wohnungen", "Mehrfamilienhaus: 7-12 Wohnungen",
      "Mehrfamilienhaus: 13 und mehr Wohnungen", "Anderer Geb\U{E4}udetyp"
    ),
    english = c(
      "Detached single-family house", "Single-family house: semi-detached",
      "Single-family house: terraced", "Detached two-family house",
      "Two-family house: semi-detached", "Two-family house: terraced",
      "Multi-family house: 3-6 apartments", "Multi-family house: 7-12 apartments",
      "Multi-family house: 13 and more apartments", "Other building type"
    ),
  ),
  building_type = tibble::tibble(
    code = c(1, 11, 111, 112, 12),
    german = c(
      "Geb\U{E4}ude mit Wohnraum", "Wohngeb\U{E4}ude",
      "Wohngeb\U{E4}ude (ohne Wohnheime)", "Wohnheim",
      "Sonstiges Geb\U{E4}ude mit Wohnraum"
    ),
    english = c(
      "Building with living space", "Residential building",
      "Residential building (excluding dormitories)", "Dormitory",
      "Other building with living space"
    ),
  ),
  building_design = tibble::tibble(
    code = seq(1, 4, by = 1),
    german = c(
      "Freistehendes Haus", "Doppelhaus H\U{E4}lfte", "Gereihtes Haus",
      "Anderer Geb\U{E4}udetyp"
    ),
    english = c("Detached house", "Semi-detached house", "Terraced house", "Other building type"),
  ),
  building_heat_type = tibble::tibble(
    code = seq(1, 6, by = 1),
    german = c(
      "Fernheizung (Fernw\U{E4}rme)", "Etagenheizung", "Blockheizung",
      "Zentralheizung", "Einzel-/Mehrraum\U{F6}fen (auch Nachtspeicherheizung)",
      "Keine Heizung im Geb\U{E4}ude oder in den Wohnungen"
    ),
    english = c(
      "District heating (long-distance heating)", "Floor heating", "Block heating",
      "Central heating",
      "Individual/multi-room stoves (including night storage heating)",
      "No heating in the building or in the apartments"
    ),
  ),
  building_heat_src = tibble::tibble(
    code = seq(1, 9, by = 1),
    german = c(
      "Gas", "Heiz\U{F6}l", "Holz(pellets)", "Biomasse (ohne Holz), Biogas",
      "Solar-/Geothermie, W\U{E4}rmepumpen", "Strom (ohne W\U{E4}rmepumpen)",
      "Kohle", "Fernw\U{E4}rme", "Kein Energietr\U{E4}ger"
    ),
    english = c(
      "Gas", "Heating oil", "Wood (pellets)", "Biomass (no wood), biogas",
      "Solar, geothermal, heat pumps", "Electric heating (no heat pumps)", "Coal",
      "District heating", "No heating"
    ),
  )
)


make_rd_categories <- function() {
  tb <- lapply(names(categories), function(x) {
    ltx <- sinew::tabular(categories[[x]])
    ltx <- gsub("#' ?", "\t\t", ltx)
    header <- sprintf("\\code{%s}", x)
    sprintf("  \\item{%s}{\n%s}", header, ltx)
  })
  tb <- paste(tb, collapse = "\n\n\\cr")
  sprintf("\\section{Categories}{\n\\describe{\n%s\n}}", tb)
}
