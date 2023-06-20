add_js <- function() {

    # copy javascript.html
    javascript_html <- system.file("javascript.html", package = "jsquiz")

    file.copy(javascript_html, getwd())

    # copy quiz.js
    quiz_js <- system.file("quiz.js", package = "jsquiz")

    file.copy(quiz_js, getwd())

    # modify _output.yml
    output_yaml <- "_output.yml"
    config <- yaml::read_yaml(output_yaml)

    if (!is.null(config$`bookdown::gitbook`$includes$in_header)) {

        config$`bookdown::gitbook`$includes$in_header <- appned(
            config$`bookdown::gitbook`$includes$in_header,
            "javascript.html"
        )

    }

    yaml::write_yaml(output_yaml, output_yaml)
}
