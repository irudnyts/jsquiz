#' @export
generate_options_quiz <- function(
    question = "What is the capital of Germany?",
    answers = c(
        "Berlin" = TRUE,
        "Frankfurt" = FALSE,
        "Dortmund" = FALSE
    ),
    button_label = "Check",
    allow_multiple_answers = FALSE,
    button_id = uuid::UUIDgenerate(),
    radio_buttons_id = uuid::UUIDgenerate()
) {

    type <- ifelse(allow_multiple_answers, "checkbox", "radio")

    button <- if (allow_multiple_answers) {
        htmltools::tags$button(
            class = "check",
            id = button_id,
            onclick = paste0(
                "checkOptions('", button_id, "', '", radio_buttons_id, "');"
            ),
            button_label
        )
    } else {
        htmltools::tags$button(
            class = "check",
            id = button_id,
            onclick = paste0(
                "checkOptions('", button_id, "', '", radio_buttons_id, "');"
            ),
            disabled = "disabled",
            button_label
        )
    }

    add_answer <- function(value, answer) {
        value <- ifelse(value, "true", "false")
        htmltools::tags$label(
            htmltools::tags$input(
                type = type,
                name = radio_buttons_id,
                value = value,
                htmltools::HTML(answer)
            )
        )
    }

    # HTML
    html <- htmltools::tags$div(
        class = "quiz",
        htmltools::tags$div(class = "question", htmltools::HTML(question)),
        purrr::map2(.x = answers, .y = names(answers), add_answer),
        button
    )

    # JavaScript
    js <- if (allow_multiple_answers) {
        NULL
    } else {
        enable_js <- system.file("enableOptions.js", package = "jsquiz")
        enable <- paste(readLines(enable_js), collapse = "\n")

        enable <- stringr::str_replace(enable, "options_ids", radio_buttons_id)
        enable <- stringr::str_replace(enable, "button_id", button_id)

        htmltools::tags$script(
            htmltools::HTML(enable)
        )
    }

    htmltools::tagList(html, js)

}
