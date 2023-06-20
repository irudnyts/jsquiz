
<!-- README.md is generated from README.Rmd. Please edit that file -->

# jsquiz

<!-- badges: start -->
<!-- badges: end -->

`{jsquiz}` generates quizzes in a form of multiple-choice questions. The
business logic is implemented using JavaScript, therefore, no back-end
required (e.g., Shiny). This package was developed to allow for
exercises in `{bookdown}` books. Currently, works only with `{bookdown}`
projects, but with a slight modification, one can include those
exercises into regular R Markdown and Quatro documents.

**Note:** Please treat this package just as a proof of concept!

## Installation

You can install the development version of `{jsquiz}` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("irudnyts/jsquiz")
```

## Example

To use the package, one needs to initialize it first by `initialize()`
function. This function will add all necessary CSS and JavaScript files.
This function is supposed to be run from the console **only one time**:

``` r
initialize()
```

Then, quizzes can be added by using function `generate_mcq()` in a
separate code chunks. This function will generate HTML tags for
multiple-choice questions:

```` markdown
```{r, results='asis', message=FALSE, echo=FALSE}
library(jsquiz)
jsquiz::generate_mcq()
```
````

If you want to generate multiple-choice question and allow for multiple
options, you can set `allow_multiple_answers = TRUE`. In the following
example, we set all argument values to non-default values:

```` markdown
```{r, results='asis', message=FALSE, echo=FALSE}
jsquiz::generate_mcq(
    question = "Select programming langauges:",
    answers = c(
        "Python" = TRUE,
        "C++" = TRUE,
        "RStudio" = FALSE
    ),
    button_label = "Submit",
    allow_multiple_answers = TRUE
)
```
````

Please do not forget to load `{jsquiz}` somewhere and mind the following
values of chunk’s options:

- `results='asis'`
- `message=FALSE`
- `echo=FALSE`
