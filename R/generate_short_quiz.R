#' @export
generate_short_quiz <- function(
        question = "What is the capital of France?",
        answer = "Paris",
        placeholder = "Type here...",
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
            button_label
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
