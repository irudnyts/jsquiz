#' @export
generate_bucket_quiz <- function(
        question = "Drag cities into the correct buckets:",
        elements = c(
            "Berlin" = "Germany",
            "Paris" = "France",
            "Lyon" = "France",
            "Frankfurt" = "Germany",
            "Stuttgat" = "Germany",
            "Bonn" = "Germany",
            "Florence" = "Italy",
            "Milan" = "Italy",
            "Marcelle" = "France",
            "Grenoble" = "France"
        ),
        buckets = c("France", "Germany", "Italy"),
        between = NULL,
        button_label = NULL,
        success_messages = NULL,
        failure_messages = NULL
) {

    buckets_ids <- uuid::UUIDgenerate(n = length(buckets))
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
        if (!is.null(between)) HTML(between),
        tags$div(
            class = "elements_pool",
            id = elements_pool_id,
            purrr::map2(elements_ids, names(elements), add_element)
        ),
        tags$div(
            class = "buckets",
            purrr::map2(
                buckets,
                buckets_ids,
                function(x, y) {
                    htmltools::tags$div(
                        class = "column",
                        htmltools::tags$span(x),
                        htmltools::tags$div(
                            class = "bucket",
                            id = y,
                            ondrop="drop(event)",
                            ondragover="allowDrop(event)"
                        )
                    )
                }

            )
        ),
        tags$button(
            class = "check",
            id = button_id,
            onclick = HTML(paste0(
                'checkBucket("', button_id, '", ',
                vector_to_array(buckets_ids), ', ',
                complex_array(buckets, elements, elements_ids), ', ',
                vector_to_array(success_messages), ', ',
                vector_to_array(failure_messages), ');'
            )),
            disabled = "disabled",
            button_label
        )
    )

    # JavaScript
    js <- system.file("enableBucket.js", package = "jsquiz") %>%
        readLines() %>%
        paste(collapse = "\n") %>%
        str_replace("elements_name", elements_name) %>%
        str_replace("button_id", button_id) %>%
        str_replace("elements_pool_id", elements_pool_id) %>%
        HTML() %>%
        tags$script()

    htmltools::tagList(html, js)

}

complex_array <- function(buckets, elements, elements_ids) {
    names(elements) <- elements_ids
    inner_arrays <- c()
    for (bucket in buckets) {
        inner_arrays <- append(
            inner_arrays,
            vector_to_array(names(elements)[elements == bucket])
        )
    }

    vector_to_array(inner_arrays, "")

}
