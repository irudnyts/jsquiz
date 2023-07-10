add_js <- function() {

    copy_file("javascript.html")

    copy_file("quiz.js")

    copy_file("checkOrder.js")

    copy_file("dragndrop.js")

    # add javascript.html to header
    output_yaml <- "_output.yml"
    config <- yaml::read_yaml(output_yaml)

    if (!("javascript.html" %in%
          config$`bookdown::gitbook`$includes$in_header)) {
        config$`bookdown::gitbook`$includes$in_header <- append(
            config$`bookdown::gitbook`$includes$in_header,
            "javascript.html"
        )
        ui_done("Adding {ui_value('javascript.html')} to {ui_fild('header')}")
    }

    yaml::write_yaml(config, output_yaml)
}

copy_file <- function(file) {
    system.file(file, package = "jsquiz") %>%
        file.copy(getwd())
    ui_done("Copying {ui_value(file)}")
}
