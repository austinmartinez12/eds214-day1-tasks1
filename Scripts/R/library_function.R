# This makes it so that you don't have to manually have to type library() for each package
load_library <- function(packages) {
  for (p in packages) {
    library(p, character.only = TRUE)
  }
}
