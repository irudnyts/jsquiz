#' @export
get_success_messages <- function() {
    jsquiz_global$success_messages
}

#' @export
set_success_messages <- function(messages) {
    jsquiz_global$success_messages <- messages
}

#' @export
get_failure_messages <- function() {
    jsquiz_global$failure_messages
}

#' @export
set_failure_messages <- function(messages) {
    jsquiz_global$failure_messages <- messages
}
