library(tibble)

list(
  tibble(
    feature = "ALTER_10JG",
    code = 1:9,
    german = c("Unter 10", "10 - 19", "20 - 29", "30 - 39", "40 - 49", "50 - 59", "60 - 69", "70 - 79", "80 und älter"),
    english = c("Under 10", "10 to 19", "20 to 29", "30 to 39", "40 to 49", "50 to 59", "60 to 69", "70 to 79", "80 and older")
  ),
  tibble(
    feature = "ALTER_KURZ",
    code = 1:5,
    german = c("Unter 18", "18 - 29", "30 - 49", "50 - 64", "65 und älter"),
    english = c("Under 18", "18 to 29", "30 to 49", "50 to 64", "65 and older")
  ),
  tibble(
    feature = "FAMSTND_AUSF",
    code = 1:8,
    german = c("Ledig", "Verheiratet", "Verwitwet", "Geschieden", "Eingetr. Lebenspartnerschaft", "Eingetr. Lebenspartner/-in verstorben", "Eingetr. Lebenspartnerschaft aufgehoben", "Ohne Angabe"),
    english = c("Single", "Married", "Widowed", "Divorced", "Registered partnership", "Registered partner deceased", "Registered partnership annulled", "No information")
  ),
  tibble(
    feature = "GEBURTLAND_GRP",
    code = c(1, 21, 22, 23, 24),
    german = c("Deutschland", "EU27-Land", "Sonstiges Europa", "Sonstige Welt", "Sonstige"),
    english = c("Germany", "EU27 country", "Other Europe", "Other World", "Other")
  ),
  tibble(
    feature = "GESCHLECHT",
    code = 1:2,
    german = c("Männlich", "Weiblich"),
    english = c("Male", "Female")
  ),
  tibble(
    feature = "RELIGION_KURZ",
    code = 1:3,
    german = c("Römisch-katholische Kirche", "Evangelische Kirche", "Sonstige, keine, ohne Angabe"),
    english = c("Roman Catholic Church", "Evangelical Church", "Other, none, no information")
  ),
  tibble(
    feature = "STAATSANGE_GRP",
    code = c(1, 21, 22, 23, 24),
    german = c("Deutschland", "EU27-Land", "Sonstiges Europa", "Sonstige Welt", "Sonstige"),
    english = c("Germany", "EU27 Country", "Other Europe", "Other World", "Other")
  ),
  tibble(
    feature = "STAATSANGE_HLND",
    code = 1:14,
    german = c("Deutschland", "Bosnien und Herzegowina", "Griechenland", "Italien", "Kasachstan", "Kroatien", "Niederlande", "Österreich", "Polen", "Rumänien", "Russische Föderation", "Türkei", "Ukraine", "Sonstige"),
    english = c("Germany", "Bosnia and Herzegovina", "Greece", "Italy", "Kazakhstan", "Croatia", "Netherlands", "Austria", "Poland", "Romania", "Russian Federation", "Turkey", "Ukraine", "Other")
  ),
  tibble(
    feature = "STAATSANGE_KURZ",
    code = 1:2,
    german = c("Deutschland", "Ausland"),
    english = c("Germany", "Foreign")
  ),
  STAATZHL = tibble(
    code = 1:4,
    german = c("Eine Staatsangehörigkeit", "Mehrere, deutsch und ...", "Mehrere, nur ausländische", "Nicht bekannt"),
    english = c("One citizenship", "Several, German and ...", "Several, only foreign", "Unknown")
  )
)
