library(tibble)

categories <- list(
  ALTER_10JG = tibble(
    code = 1:9,
    german = c(
      "Unter 10", "10 - 19", "20 - 29", "30 - 39", "40 - 49", "50 - 59",
      "60 - 69", "70 - 79", "80 und älter"
    ),
    english = c(
      "Under 10", "10 to 19", "20 to 29", "30 to 39", "40 to 49", "50 to 59",
      "60 to 69", "70 to 79", "80 and older"
    )
  ),

  ALTER_KURZ = tibble(
    code = 1:5,
    german = c("Unter 18", "18 - 29", "30 - 49", "50 - 64", "65 und älter"),
    english = c("Under 18", "18 to 29", "30 to 49", "50 to 64", "65 and older")
  ),

  FAMSTND_AUSF = tibble(
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
    )
  ),

  GEBURTLAND_GRP = tibble(
    code = c(1, 21, 22, 23, 24),
    german = c("Deutschland", "EU27-Land", "Sonstiges Europa", "Sonstige Welt", "Sonstige"),
    english = c("Germany", "EU27 country", "Other Europe", "Other World", "Other")
  ),

  GESCHLECHT = tibble(
    code = 1:2,
    german = c("Männlich", "Weiblich"),
    english = c("Male", "Female")
  ),

  RELIGION_KURZ = tibble(
    code = 1:3,
    german = c("Römisch-katholische Kirche", "Evangelische Kirche", "Sonstige, keine, ohne Angabe"),
    english = c("Roman Catholic Church", "Evangelical Church", "Other, none, no information")
  ),

  STAATSANGE_GRP = tibble(
    code = c(1, 21, 22, 23, 24),
    german = c("Deutschland", "EU27-Land", "Sonstiges Europa", "Sonstige Welt", "Sonstige"),
    english = c("Germany", "EU27 Country", "Other Europe", "Other World", "Other")
  ),

  STAATSANGE_HLND = tibble(
    code = 1:14,
    german = c(
      "Deutschland", "Bosnien und Herzegowina", "Griechenland", "Italien",
      "Kasachstan", "Kroatien", "Niederlande", "Österreich", "Polen",
      "Rumänien", "Russische Föderation", "Türkei", "Ukraine", "Sonstige"
    ),
    english = c(
      "Germany", "Bosnia and Herzegovina", "Greece", "Italy", "Kazakhstan",
      "Croatia", "Netherlands", "Austria", "Poland", "Romania",
      "Russian Federation", "Turkey", "Ukraine", "Other"
    )
  ),

  STAATSANGE_KURZ = tibble(
    code = 1:2,
    german = c("Deutschland", "Ausland"),
    english = c("Germany", "Foreign")
  ),

  STAATZHL = tibble(
    code = 1:4,
    german = c(
      "Eine Staatsangehörigkeit", "Mehrere, deutsch und ...",
      "Mehrere, nur ausländische", "Nicht bekannt"
    ),
    english = c(
      "One citizenship", "Several, German and ...",
      "Several, only foreign", "Unknown"
    )
  ),

  FAMTYP_KIND = tibble(
    code = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13),
    german = c("Ehepaare ohne Kind",
               "Ehepaare, mind. 1 Kind < 18",
               "Ehepaare alle Kinder \u2265 18",
               "Eingetr. Lebenspartnerschaften ohne Kind",
               "Eingetr. Lebenspartnerschaften mind. 1 Kind < 18",
               "Eingetr. Lebenspartnerschaften alle Kinder \u2265 18",
               "Nichteheliche Lebensgem. ohne Kind",
               "Nichteheliche Lebensgem. mind. 1 Kind < 18",
               "Nichteheliche Lebensgem. alle Kinder \u2265 18",
               "Alleinerziehende Väter mind. 1 Kind < 18",
               "Alleinerziehende Väter alle Kinder \u2265 18",
               "Alleinerziehende Mütter mind. 1 Kind < 18",
               "Alleinerziehende Mütter alle Kinder \u2265 18"),
    english = c("Couples without child",
                "Couples, at least 1 child < 18",
                "Couples all children \u2265 18",
                "Registered civil partnerships without child",
                "Registered civil partnerships, at least 1 child < 18",
                "Registered civil partnerships all children \u2265 18",
                "Non-marital partnerships without child",
                "Non-marital partnerships, at least 1 child < 18",
                "Non-marital partnerships all children \u2265 18",
                "Single fathers, at least 1 child < 18",
                "Single fathers all children \u2265 18",
                "Single mothers, at least 1 child < 18",
                "Single mothers all children \u2265 18")
  ),

  FAMGROESS_KLASS = tibble(
    code = c(1, 2, 3, 4, 5),
    german = c("2 Personen", "3 Personen", "4 Personen", "5 Personen", "6 und mehr Personen"),
    english = c("2 Persons", "3 Persons", "4 Persons", "5 Persons", "6 and more Persons")
  ),

  HHTYP_SENIOR_HH = tibble(
    code = c(1, 2, 3),
    german = c("Haushalte mit ausschließlich Senioren/-innen",
               "Haushalte mit Senioren/-innen und Jüngeren",
               "Haushalte ohne Senioren/-innen"),
    english = c("Households with only seniors",
                "Households with seniors and younger people",
                "Households without seniors")
  ),

  HHTYP_FAM = tibble(
    code = c(1, 2, 3, 4, 5),
    german = c("Einpersonenhaushalte (Singlehaushalte)",
               "Paare ohne Kind(er)",
               "Paare mit Kind(ern)",
               "Alleinerziehende Elternteile",
               "Mehrpersonenhaushalte ohne Kernfamilie"),
    english = c("One-person households (Single households)",
                "Couples without child(ren)",
                "Couples with child(ren)",
                "Single parents",
                "Multi-person households without core family")
  ),

  HHTYP_LEB = tibble(
    code = c(1, 2, 3, 4, 5, 6, 7),
    german = c("Einpersonenhaushalte (Singlehaushalte)",
               "Ehepaare",
               "Eingetr. Lebenspartnerschaften",
               "Nichteheliche Lebensgemeinschaften",
               "Alleinerziehende Mütter",
               "Alleinerziehende Väter",
               "Mehrpersonenhaushalte ohne Kernfamilie"),
    english = c("One-person households (Single households)",
                "Married couples",
                "Registered civil partnerships",
                "Non-marital partnerships",
                "Single mothers",
                "Single fathers",
                "Multi-person households without core family")
  ),

  HHGROESS_KLASS = tibble(
    code = c(1, 2, 3, 4, 5, 6),
    german = c("1 Person", "2 Personen", "3 Personen", "4 Personen", "5 Personen", "6 und mehr Personen"),
    english = c("1 Person", "2 Persons", "3 Persons", "4 Persons", "5 Persons", "6 and more Persons")
  ),

  NUTZUNG_DETAIL_HHGEN = tibble(
    code = c(1, 11, 12, 2, 21, 22, 3, 4, 5, 99),
    german = c("Von Eigentümer/-in bewohnt",
               "Eigentum: mit aktuell geführtem Haushalt",
               "Eigentum: ohne aktuell geführtem Haushalt",
               "Zu Wohnzwecken vermietet",
               "Vermietet: mit aktuell geführtem Haushalt",
               "Vermietet: ohne aktuell geführtem Haushalt",
               "Ferien- und Freizeitwohnung",
               "Leer stehend",
               "Diplomaten-/Streitkräftewohnung",
               "Gewerbl. Nutzung"),
    english = c("Occupied by owner",
                "Ownership: with currently managed household",
                "Ownership: without currently managed household",
                "Rented for residential purposes",
                "Rented: with currently managed household",
                "Rented: without currently managed household",
                "Holiday and leisure home",
                "Vacant",
                "Diplomatic/Military housing",
                "Commercial use")
  ),

  WOHNEIGENTUM = tibble(
    code = c(1, 2, 3, 4, 99),
    german = c("Privatperson/-en",
               "Privatwirtschaftliche Unternehmen (jur. Personen)",
               "Öffentliche Unternehmen, Kirchen o.ä.",
               "Wohnungsgenossenschaft",
               "Trifft nicht zu (da keine Eigentumswohnung)"),
    english = c("Private person(s)",
                "Private sector companies (legal persons)",
                "Public companies, churches or similar",
                "Housing cooperative",
                "Does not apply (no condominium)")
  ),

  WOHNFLAECHE_10S = tibble(
    code = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 99),
    german = c(
      "Unter 30", "30 - 39", "40 - 49", "50 - 59", "60 - 69", "70 - 79",
      "80 - 89", "90 - 99", "100 - 109", "110 - 119", "120 - 129",
      "130 - 139", "140 - 149", "150 - 159", "160 - 169", "170 - 179",
      "180 und mehr", "t.n.z., gewerblich"
    ),
    english = c(
      "Under 30", "30 - 39", "40 - 49", "50 - 59", "60 - 69", "70 - 79",
      "80 - 89", "90 - 99", "100 - 109", "110 - 119", "120 - 129",
      "130 - 139", "140 - 149", "150 - 159", "160 - 169", "170 - 179",
      "180 and more", "n.a., commercial"
    )
  ),

  RAUMANZAHL = tibble(
    code = c(1, 2, 3, 4, 5, 6, 7, 99),
    german = c(
      "1 Raum", "2 Räume", "3 Räume", "4 Räume", "5 Räume", "6 Räume",
      "7 und mehr Räume", "t.n.z., gewerblich"
    ),
    english = c(
      "1 Room", "2 Rooms", "3 Rooms", "4 Rooms", "5 Rooms", "6 Rooms",
      "7 and more Rooms", "n.a., commercial"
    )
  ),

  GEBAEUDEART_SYS = tibble(
    code = c(1, 11, 111, 112, 12),
    german = c(
      "Gebäude mit Wohnraum", "Wohngebäude", "Wohngebäude (ohne Wohnheime)",
      "Wohnheim", "Sonstiges Gebäude mit Wohnraum"
    ),
    english = c(
      "Building with living space", "Residential building",
      "Residential building (excluding dormitories)", "Dormitory",
      "Other building with living space"
    )
  ),

  BAUJAHR_MZ = tibble(
    code = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
    german = c(
      "Vor 1919", "1919 - 1948", "1949 - 1978", "1979 - 1986",
      "1987 - 1990", "1991 - 1995", "1996 - 2000", "2001 - 2004",
      "2005 - 2008", "2009 und später"
    ),
    english = c(
      "Before 1919", "1919 - 1948", "1949 - 1978", "1979 - 1986",
      "1987 - 1990", "1991 - 1995", "1996 - 2000", "2001 - 2004",
      "2005 - 2008", "2009 and later"
    )
  ),

  EIGENTUM = tibble(
    code = c(1, 2, 3, 4, 5, 6, 7, 8),
    german = c("Gemeinschaft von Wohnungseigentümern/-innen",
               "Privatperson/-en",
               "Wohnungsgenossenschaft",
               "Kommune oder Kommunales Wohnungsunternehmen",
               "Privatwirtschaftliches Wohnungsunternehmen",
               "Anderes privatwirtschaftliches Unternehmen",
               "Bund oder Land",
               "Organisation ohne Erwerbszweck (z.B. Kirche)"),
    english = c("Homeowner association",
                "Private person(s)",
                "Housing cooperative",
                "Municipality or municipal housing company",
                "Private sector housing company",
                "Other private sector company",
                "Federal or state government",
                "Non-profit organization (e.g. church)")
  ),

  GEBTYPBAUWEISE = tibble(
    code = c(1, 2, 3, 4),
    german = c("Freistehendes Haus", "Doppelhaus Hälfte", "Gereihtes Haus", "Anderer Gebäudetyp"),
    english = c("Detached house", "Semi-detached house", "Terraced house", "Other building type")
  ),

  GEBTYPGROESSE = tibble(
    code = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
    german = c(
      "Freistehendes Einfamilienhaus",
      "Einfamilienhaus: Doppelhaushälfte",
      "Einfamilienhaus: Reihenhaus",
      "Freistehendes Zweifamilienhaus",
      "Zweifamilienhaus: Doppelhaushälfte",
      "Zweifamilienhaus: Reihenhaus",
      "Mehrfamilienhaus: 3-6 Wohnungen",
      "Mehrfamilienhaus: 7-12 Wohnungen",
      "Mehrfamilienhaus: 13 und mehr Wohnungen",
      "Anderer Gebäudetyp"
    ),
    english = c(
      "Detached single-family house",
      "Single-family house: semi-detached",
      "Single-family house: terraced",
      "Detached two-family house",
      "Two-family house: semi-detached",
      "Two-family house: terraced",
      "Multi-family house: 3-6 apartments",
      "Multi-family house: 7-12 apartments",
      "Multi-family house: 13 and more apartments",
      "Other building type"
    )
  ),

  HEIZTYP = tibble(
    code = c(1, 2, 3, 4, 5, 6),
    german = c(
      "Fernheizung (Fernwärme)", "Etagenheizung", "Blockheizung",
      "Zentralheizung", "Einzel-/Mehrraumöfen (auch Nachtspeicherheizung)",
      "Keine Heizung im Gebäude oder in den Wohnungen"
    ),
    english = c(
      "District heating (long-distance heating)", "Floor heating",
      "Block heating", "Central heating",
      "Individual/multi-room stoves (including night storage heating)",
      "No heating in the building or in the apartments"
    )
  ),

  ZAHLWOHNGN_HHG = tibble(
    code = c(1, 2, 3, 4, 5),
    german = c(
      "1 Wohnung", "2 Wohnungen", "3 - 6 Wohnungen",
      "7 - 12 Wohnungen", "13 und mehr Wohnungen"
    ),
    english = c(
      "1 Apartment", "2 Apartments", "3 - 6 Apartments",
      "7 - 12 Apartments", "13 and more Apartments"
    )
  )
)

categories <- dplyr::bind_rows(categories, .id = "feature")
categories$code <- as.integer(categories$code)
usethis::use_data(categories, overwrite = TRUE, compress = FALSE)
