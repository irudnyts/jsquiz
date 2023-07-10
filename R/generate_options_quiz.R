#' @export
generate_options_quiz <- function(
    question = "What is the capital of Germany?",
    answers = c(
        "Berlin" = TRUE,
        "Frankfurt" = FALSE,
        "Dortmund" = FALSE
    ),
    allow_multiple_answers = FALSE,
    button_label = NULL,
    success_messages = NULL,
    failure_messages = NULL
) {

    button_id <- uuid::UUIDgenerate()
    radio_buttons_id <- uuid::UUIDgenerate()

    if (is.null(button_label))
        button_label <- jsquiz_global$button_label

    if (is.null(success_messages))
        success_messages <- jsquiz_global$success_messages

    if (is.null(failure_messages))
        failure_messages <- jsquiz_global$failure_messages

    type <- ifelse(allow_multiple_answers, "checkbox", "radio")

    button <- if (allow_multiple_answers) {
        tags$button(
            class = "check",
            id = button_id,
            onclick = HTML(paste0(
                'checkOptions("', button_id, '", "',
                radio_buttons_id, '", ',
                vector_to_array(success_messages), ', ',
                vector_to_array(failure_messages), ');'
            )),
            button_label
        )
    } else {
        tags$button(
            class = "check",
            id = button_id,
            onclick = HTML(paste0(
                'checkOptions("', button_id, '", "',
                radio_buttons_id, '", ',
                vector_to_array(success_messages), ', ',
                vector_to_array(failure_messages), ');'
            )),
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
