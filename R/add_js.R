add_js <- function() {

    copy_file("javascript.html")

    copy_file("checkOptions.js")

    copy_file("checkArrange.js")

    copy_file("dragDrop.js")

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
