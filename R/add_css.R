add_css <- function() {

    quizzes_style <- system.file("quizzes.css", package = "jsquiz") %>%
        readLines()

    if (file.exists("style.css")) {
        write(quizzes_style, file = "style.css", append = TRUE)
        ui_done("Adding quizzes styles to {ui_value('style.css')}")
    } else {
        ui_oops("Could not locate style.css, please add CSS manually")
    }

}
