#' @export
generate_mcq <- function(
    question = "What is the capital of Germany?",
    answers = c(
        "Berlin" = TRUE,
        "Frankfurt" = FALSE,
        "Dortmund" = FALSE
    ),
    button_label = "Check",
    allow_multiple_answers = TRUE,
    button_id = uuid::UUIDgenerate(),
    radio_buttons_id = uuid::UUIDgenerate()
) {

    type <- ifelse(allow_multiple_answers, "checkbox", "radio")

    add_answer <- function(value, answer) {
        value <- ifelse(value, "true", "false")
        htmltools::tags$label(
            htmltools::tags$input(
                type = type,
                name = radio_buttons_id,
                value = value,
                answer
            )
        )
    }

    htmltools::tags$div(
        class = "quiz",
        htmltools::tags$div(class = "question", question),
        purrr::map2(.x = answers, .y = names(answers), add_answer),
        htmltools::tags$button(
            class = "check",
            id = button_id,
            onclick = paste0(
                "checkAnswer('", button_id, "', '", radio_buttons_id, "');"
            ),
            button_label
        )
    )

}
