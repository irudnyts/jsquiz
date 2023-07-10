
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
devtools::install_github("irudnyts/jsquiz")
```

## Example

To use the package, one needs to initialize it first by `init()`
function. This function will add all necessary CSS and JavaScript files.
This function is supposed to be run from the console **only one time**:

``` r
init()
```

## Multiple choice question (options quiz): `generate_options_quiz()`

Then, MCQ quizzes can be added by using function
`generate_options_quiz()` in a separate code chunks. This function will
generate HTML tags for multiple-choice questions:

```` markdown
```{r, results='asis', message=FALSE, echo=FALSE}
jsquiz::generate_options_quiz()
```
````

If you want to generate multiple-choice question and allow for multiple
options, you can set `allow_multiple_answers = TRUE`. In the following
example, we set all argument values to non-default values:

```` markdown
```{r, results='asis', message=FALSE, echo=FALSE}
jsquiz::generate_options_quiz(
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

It is recommended to load `{jsquiz}` somewhere (and to stop using
namespace prefix `jsquiz::`). Further, please mind the following values
of chunk’s options:

- `results='asis'`
- `message=FALSE`
- `echo=FALSE`

## Arrange quiz: `generate_arrange_quiz()`

```` markdown
```{r, results='asis', message=FALSE, echo=FALSE}
jsquiz::generate_arrange_quiz()
```
````

## Setting custom success/failure messages and submit button label

One can set global (for the entire `{bookdown}` document) custom
success/failure messages and submit button label. Please use
`set_success_messages()`, `set_failure_messages()`, and
`set_button_label()` for this purpose somewhere in at the begining of
your book:

``` r
jsquiz::set_button_label("Submit")

jsquiz::set_success_messages(c("Good job!", "Bravo!"))

jsquiz::set_failure_messages(c("Oops!", "Try again!"))
```

This feature can be used, if your book in other than English language.

Further, it is also possible to set success/failure messages and submit
button label individually for each question. It cover very specific
cases and generaly makes very little sense.
