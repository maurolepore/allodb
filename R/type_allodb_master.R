#' Create objects of class allodb.
#'
#' This function creates S3 objects of class "allodb". Compared with the data
#' directly delivered in the __allodb__ package, objects of class "allodb" have
#' two main differences:
#' * The column types are not all text but the types that is most useful for
#' computations.
#' * Missing values are represented in a single way: with `NA`.
#'
#' The datasets directly delivered by __allodb__ are optimized for delivering
#' the greatest amount of information in the most robust and flexible way. All
#' values are stored as text. This allows, for example, different to store
#' different representation of missing values. The trade-off is that text values
#' don't allow direct computation. First  they may need to be converted to other
#' types of data, such as integers.
#'
#' @param x A dataframe from __allodb__.
#'
#' @family functions to interact with the database
#'
#' @return A dataframe subclass "allodb".
#' @export
#'
#' @examples
#' set_type(allodb::equations)
#' class(set_type(allodb::equations))
set_type <- function(x) {
  allodb_na <- unique(allodb::missing_values_metadata$Code)
  expected_na <- c("", "NA", allodb_na[!is.na(allodb_na)])
  x <- suppressWarnings(
    readr::type_convert(x, col_types = type_allodb_master(), na = expected_na)
  )
  new_allodb(x)
}

new_allodb <- function(x) {
  structure(x, class = c("allodb", class(x)))
}



#' Help read allodb data safely.
#'
#' For details see [`fgeo.tool::type_fgeo()`](https://goo.gl/gVSMT8).
#'
#' Types' reference (see [`readr::read_csv()`](https://goo.gl/DtDvXq).
#' * c = character.
#' * i = integer.
#' * n = number.
#' * d = double.
#' * l = logical.
#' * D = date.
#' * T = date time.
#' * t = time.
#' * ? = guess.
#' * _/- to skip the column.
#' @keywords internal
type_allodb_master <- function() {
  list(
    site = 'c',
    family = 'c',
    species = 'c',
    species_code = 'c',
    life_form = 'c',
    wsg = 'd',
    wsg_id = 'c',
    wsg_specificity = 'c',
    a = 'd',
    b = 'd',
    c = 'd',
    d = 'd',
    dbh_min_cm = 'd',
    dbh_max_cm = 'd',
    sample_size = 'i',
    dbh_units_original = 'c',
    biomass_units_original = 'c',
    allometry_development_method = 'c',
    site_dbh_unit = 'c',
    equation_id = 'c',
    equation_form = 'c',
    equation_allometry = 'c',
    equation_group = 'c',
    independent_variable = 'c',
    regression_model = 'c',
    other_equations_tested = 'c',
    log_biomass = 'c',
    bias_corrected = 'c',
    bias_correction_factor = 'c',
    notes_fitting_model = 'c',
    dependent_variable_biomass_component = 'c',
    allometry_specificity = 'c',
    development_species = 'c',
    geographic_area = 'c',
    biomass_equation_source = 'c',
    ref_id = 'c',
    wsg_source = 'c',
    ref_wsg_id = 'c',
    original_data_availability = 'c',
    notes_on_species = 'c',
    warning = 'c'
  )
}

