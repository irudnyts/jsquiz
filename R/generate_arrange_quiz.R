#' @export
generate_arrange_quiz <- function(
        question = "Arrange colors in RGB order:",
        elements = c(
            "Blue" = 3,
            "Red" = 1,
            "Green" = 2
        ),
        button_label = NULL,
        success_messages = NULL,
        failure_messages = NULL
) {

    answer_pool_id <- uuid::UUIDgenerate()
    elements_pool_id <- uuid::UUIDgenerate()
    elements_ids <- uuid::UUIDgenerate(n = length(elements))
    elements_name <- uuid::UUIDgenerate()
    button_id <- uuid::UUIDgenerate()

    if (is.null(button_label))
        button_label <- jsquiz_global$button_label

    if (is.null(success_messages))
        success_messages <- jsquiz_global$success_messages

    if (is.null(failure_messages))
        failure_messages <- jsquiz_global$failure_messages

    add_element <- function(id, content) {
        tags$div(
            class = "element",
            name = elements_name,
            id = id,
            draggable = "true",
            ondragstart = "drag(event)",
            HTML(content)
        )
    }

    # HTML
    html <- tags$div(
        class = "quiz",
        tags$div(class = "question", HTML(question)),
        tags$div(
            class = "answer_pool",
            id = answer_pool_id,
            ondrop="drop(event)",
            ondragover="allowDrop(event)"
        ),
        tags$div(
            class = "elements_pool",
            id = elements_pool_id,
            purrr::map2(elements_ids, names(elements), add_element)
        ),
        tags$button(
            class = "check",
            id = button_id,
            onclick = HTML(paste0(
                'checkArrange("', button_id, '", "',
                answer_pool_id, '", ',
                vector_to_array(elements_ids[order(elements)]), ', ',
                vector_to_array(success_messages), ', ',
                vector_to_array(failure_messages), ');'
            )),
            disabled = "disabled",
            button_label
        )
    )

    # JavaScript
    js <- system.file("enableArrange.js", package = "jsquiz") %>%
        readLines() %>%
        paste(collapse = "\n") %>%
        str_replace("elements_name", elements_name) %>%
        str_replace("button_id", button_id) %>%
        str_replace("elements_pool_id", elements_pool_id) %>%
        HTML() %>%
        tags$script()

    htmltools::tagList(html, js)

}
