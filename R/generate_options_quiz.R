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
    button_id = UUIDgenerate(),
    radio_buttons_id = UUIDgenerate()
) {

    type <- ifelse(allow_multiple_answers, "checkbox", "radio")

    button <- if (allow_multiple_answers) {
        tags$button(
            class = "check",
            id = button_id,
            onclick = paste0(
                "checkOptions('", button_id, "', '", radio_buttons_id, "');"
            ),
            button_label
        )
    } else {
        tags$button(
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
        tags$label(
            tags$input(
                type = type,
                name = radio_buttons_id,
                value = value,
                HTML(answer)
            )
        )
    }

    # HTML
    html <- tags$div(
        class = "quiz",
        tags$div(class = "question", HTML(question)),
        purrr::map2(.x = answers, .y = names(answers), add_answer),
        button
    )

    # JavaScript
    js <- if (allow_multiple_answers) {
        NULL
    } else {
        system.file("enableOptions.js", package = "jsquiz") %>%
            readLines() %>%
            paste(collapse = "\n") %>%
            str_replace("options_ids", radio_buttons_id) %>%
            str_replace("button_id", button_id) %>%
            HTML() %>%
            tags$script()
    }

    htmltools::tagList(html, js)

}
