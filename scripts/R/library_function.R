#' Load libraries
#'
#' A little function that read in packages for you. With this function you wont have to retype library() everytime you
#' want to read in a package.
#' 
#' @param packages This indicates which packages you want to load in.
#'
#' @returns
#' @export
#'
#' @examples
#' load_library(c("dplyr", "tidyverse", "slider", "here"))

# This makes it so that you don't have to manually have to type library() for each package
load_library <- function(packages) {
  for (p in packages) {
    library(p, character.only = TRUE)
  }
}
