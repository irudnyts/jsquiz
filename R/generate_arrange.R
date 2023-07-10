#' @export
generate_arrange <- function(
        question = "Arrange colors in RGB order:",
        elements = c(
            "Blue" = 3,
            "Red" = 1,
            "Green" = 2
        ),
        button_label = "Check",
        answer_pool_id = uuid::UUIDgenerate(),
        elements_pool_id = uuid::UUIDgenerate(),
        elements_ids = uuid::UUIDgenerate(n = length(elements)),
        elements_name = uuid::UUIDgenerate(),
        button_id = uuid::UUIDgenerate()
) {

    add_element <- function(id, content) {
        htmltools::tags$div(
            class = "element",
            name = elements_name,
            id = id,
            draggable = "true",
            ondragstart = "drag(event)",
            htmltools::HTML(content)
        )
    }

    wrap_elements_id <- function(elements_ids) {
        paste0(
            "[" ,
            paste0("'", elements_ids[order(elements)], "'", collapse = ", "),
            "]"
        )
    }

    # HTML
    html <- htmltools::tags$div(
        class = "quiz",
        htmltools::tags$div(class = "question", htmltools::HTML(question)),
        htmltools::tags$div(
            class = "answer_pool",
            id = answer_pool_id,
            ondrop="drop(event)",
            ondragover="allowDrop(event)"
        ),
        htmltools::tags$div(
            class = "elements_pool",
            id = elements_pool_id,
            purrr::map2(elements_ids, names(elements), add_element)
        ),
        htmltools::tags$button(
            class = "check",
            id = button_id,
            onclick = htmltools::HTML(paste0(
                "checkOrder('", button_id, "', '", answer_pool_id, "', ",
                wrap_elements_id(elements_ids), ");"
            )),
            disabled = "disabled",
            button_label
        )
    )

    # JavaScript

    enableArrange_js <- system.file("enableArrange.js", package = "jsquiz")
    enableArrange <- paste(readLines(enableArrange_js), collapse = "\n")

    enableArrange <- stringr::str_replace(enableArrange, "elements_name", elements_name)
    enableArrange <- stringr::str_replace(enableArrange, "button_id", button_id)
    enableArrange <- stringr::str_replace(enableArrange, "elements_pool_id", elements_pool_id)

    js <- htmltools::tags$script(
        htmltools::HTML(enableArrange)
    )

    htmltools::tagList(html, js)

}
