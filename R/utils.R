vector_to_array <- function(x) {
    paste0('[' , paste0('"', x, '"', collapse = ", "), "]")
}
