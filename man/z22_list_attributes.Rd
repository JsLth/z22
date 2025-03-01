% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/list_attributes.R
\name{z22_list_attributes}
\alias{z22_list_attributes}
\title{List available attributes}
\usage{
z22_list_attributes(
  topic = NULL,
  feature = NULL,
  res = "100m",
  decode = FALSE,
  lang = c("english", "german")
)
}
\arguments{
\item{topic}{A character vector containing topics to filter by. If provided,
only features are returned that belong to the specified topics. Ignored
if \code{res} is \code{"1km"}.}

\item{feature}{A character vector containing features to filter by. If
provided, only categories are returned that belong to the specified feature.
Ignored if \code{res} is \code{"1km"}.}

\item{res}{Resolution of the grid dataset. Can be \code{"100m"}
or \code{"1km"}.}

\item{decode}{Whether to add descriptive labels for features and categories.}

\item{lang}{Specifies the language of the output description. Can be
either \code{"english"} (default) or \code{"german"}. Note that the
English descriptions are only ad-hoc translations based off the German
originals.}
}
\value{
If \code{res} is \code{"100m"}, returns a tibble containing the
attributes topics, features, and categories. If \code{res} is \code{"1km"},
returns a tibble with one column containing the attribute name.

If \code{decode} is \code{TRUE}, binds two more columns containing the
labels for each feature and category.
}
\description{
Retrieve a list of available attributes for either the 100m or 1km grid.
}
\examples{
# List all high-res attributes
z22_list_attributes()

# List only attributes about the heating type
z22_list_attributes(feature = "heating_type")

# List low-res attributes
z22_list_attributes(res = "1km")

# Add additional label information to the list
z22_list_attributes(decode = TRUE)
}
