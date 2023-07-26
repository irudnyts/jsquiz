add_js <- function() {

    copy_file("javascript.html")

    copy_file("checkOptions.js")

    copy_file("checkArrange.js")

    copy_file("checkShort.js")

    copy_file("checkBucket.js")

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
        ui_done("Adding {ui_value('javascript.html')} to {ui_field('header')}")
    }

    yaml::write_yaml(config, output_yaml)
}

copy_file <- function(file) {

    if (file.exists(file)) {
        ui_oops("Ignoring copying file {ui_value(file)} -- already exists")
    } else {
        system.file(file, package = "jsquiz") %>%
            file.copy(getwd())
        ui_done("Copying {ui_value(file)}")
    }

}
