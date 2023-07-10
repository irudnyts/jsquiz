vector_to_array <- function(x) {
    paste0('[' , paste0('"', x, '"', collapse = ", "), "]")
}

set_default_id <- function(id) {
    if (is.null(id))
        id <- uuid::UUIDgenerate()
    id
}

set_default_ids <- function(ids, n) {
    if (is.null(ids))
        ids <- uuid::UUIDgenerate(n = length(elements))
    ids
}
