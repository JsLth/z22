# Decode and translate features and categories

Replace category codes with their labels.

## Usage

``` r
z22_decode(codes, feature, lang = c("english", "german"))
```

## Arguments

- codes:

  A vector of character codes, possibly prefixed with `"cat_"`.

- feature:

  A grid feature that the category `codes` belong to.

- lang:

  Specifies the language of the output description. Can be either
  `"english"` (default) or `"german"`. Note that the English
  descriptions are only ad-hoc translations based off the German
  originals.

## Value

`.data` with category codes decoded to labels.

## Examples

``` r
# retrieves a the translation of cat codes directly
z22_decode(1, "marital_status")
#> [1] "Single"

# recycles codes
z22_decode(c(1, 1, 1), "marital_status")
#> [1] "Single" "Single" "Single"

# undefined codes are returned as NA
z22_decode(c(1, 2, 3), feature = "sex")
#> [1] "Male"   "Female" NA      

# special case: cat_* strings
z22_decode("cat_2", feature = "sex")
#> [1] "Female"
```
