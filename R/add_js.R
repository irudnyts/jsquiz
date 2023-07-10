add_js <- function() {

    # copy javascript.html
    javascript_html <- system.file("javascript.html", package = "jsquiz")
    file.copy(javascript_html, getwd())

    # copy quiz.js
    quiz_js <- system.file("quiz.js", package = "jsquiz")
    file.copy(quiz_js, getwd())

    # copy checkOrder.js
    checkOrder <- system.file("checkOrder.js", package = "jsquiz")
    file.copy(checkOrder, getwd())

    # copy dragndrop.js
    dragndrop <- system.file("dragndrop.js", package = "jsquiz")
    file.copy(dragndrop, getwd())

    # modify _output.yml
    output_yaml <- "_output.yml"
    config <- yaml::read_yaml(output_yaml)

    config$`bookdown::gitbook`$includes$in_header <- append(
        config$`bookdown::gitbook`$includes$in_header,
        "javascript.html"
    )

    yaml::write_yaml(config, output_yaml)
}
