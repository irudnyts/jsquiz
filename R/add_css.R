add_css <- function() {

    exs_css <- system.file("exs.css", package = "jsquiz")
    style <- readLines(exs_css)

    if (file.exists("style.css")) {
        write(style, file = "style.css", append = TRUE)
    } else {
        message("Could not locate style.css, please add CSS manually")
    }
}
