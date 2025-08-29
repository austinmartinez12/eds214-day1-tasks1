# this makes it so that you don't have to manually have to type library() for each package
load_library <- function(packages) {
  for (pkg in packages) {
    library(pkg, character.only = TRUE)
  }
}