#' @export
generate_short_quiz <- function(
        question = "What is the capital of France?",
        correct_answer = "Paris",
        placeholder = NULL,
        button_label = NULL,
        success_messages = NULL,
        failure_messages = NULL
) {

    button_id <- uuid::UUIDgenerate()
    input_id <- uuid::UUIDgenerate()

    if (is.null(button_label))
        button_label <- jsquiz_global$button_label

    if (is.null(success_messages))
        success_messages <- jsquiz_global$success_messages

    if (is.null(failure_messages))
        failure_messages <- jsquiz_global$failure_messages

    if (is.null(placeholder))
        placeholder <- jsquiz_global$placeholder

    # HTML
    html <- tags$div(
        class = "quiz",
        tags$div(class = "question", HTML(question)),
        tags$input(
            id = input_id,
            type = "text",
            placeholder = placeholder,
        ),
        tags$button(
            class = "check",
            id = button_id,
            disabled = "disabled",
            button_label,
            onclick = HTML(paste0(
                'checkShort("', button_id, '", "',
                input_id, '", "',
                correct_answer, '", ',
                vector_to_array(success_messages), ', ',
                vector_to_array(failure_messages), ');'
            )),
        )
    )

    # JavaScript
    js <- system.file("enableShort.js", package = "jsquiz") %>%
        readLines() %>%
        paste(collapse = "\n") %>%
        str_replace("input_id", input_id) %>%
        str_replace("button_id", button_id) %>%
        HTML() %>%
        tags$script()

    htmltools::tagList(html, js)

}
