add_js <- function() {

    # copy javascript.html
    system.file("javascript.html", package = "jsquiz") %>%
        file.copy(getwd())

    # copy quiz.js
    system.file("quiz.js", package = "jsquiz") %>%
        file.copy(getwd())

    # copy checkOrder.js
    system.file("checkOrder.js", package = "jsquiz") %>%
        file.copy(getwd())

    # copy dragndrop.js
    system.file("dragndrop.js", package = "jsquiz") %>%
        file.copy(getwd())

    # modify _output.yml
    output_yaml <- "_output.yml"
    config <- yaml::read_yaml(output_yaml)

    if (!("javascript.html" %in%
          config$`bookdown::gitbook`$includes$in_header)) {
        config$`bookdown::gitbook`$includes$in_header <- append(
            config$`bookdown::gitbook`$includes$in_header,
            "javascript.html"
        )
    }

    yaml::write_yaml(config, output_yaml)
}
