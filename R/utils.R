vector_to_array <- function(x, wrap = '"') {
    paste0('[' , paste0(wrap, x, wrap, collapse = ", "), "]")
}
