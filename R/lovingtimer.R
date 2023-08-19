#' @title lovingtimer: Create a loving timer in R
#'
#' @import htmlwidgets
#' @import htmltools
#'
#' @param title Title.
#' @param firstday The first day of love. For example, "2023-01-01 01:00:00".
#' @param titlefontfamily Title font family.
#' @param timerfontfamily Timer font family.
#' @param spanfontfamily Font for numbers.
#' @param height height.
#' @param width weight.
#'
#' @examples
#' library(lovingtimer)
#' if (interactive()) {
#'   lovingtimer()
#' }
#' @export
lovingtimer <- function(
  title = "From the first day to the future",
  firstday = "2023-01-01 01:00:00",
  titlefontfamily = "Source Han Serif",
  timerfontfamily = "Source Han Serif !important",
  spanfontfamily = "Helvetica,Arial,sans-serif",
  width = NULL,
  height = NULL
) {
  x <- list()

  # create widget
  htmlwidgets::prependContent(
    htmlwidgets::appendContent(
      htmlwidgets::prependContent(
        htmlwidgets::createWidget(
          name = "lovingtimer",
          x,
          width = width,
          height = height,
          package = "lovingtimer"
        ),
        htmltools::div(
          class = "container",
          htmltools::div(
            class = "content",
            htmltools::h2(title),
            htmltools::div(
              id = "DateCountdown",
              datadate = firstday
            )
          )
        )
      ),
      htmltools::tag("script",
                     varArgs = '$("#DateCountdown").TimeCircles();')
    ),
    htmltools::tag("style", paste0(
      "body{-webkit-font-smoothing:antialiased;font-family:Helvetica Neue,Helvetica,Hiragino Sans GB,Microsoft YaHei,Arial,sans-serif;background-color:#8dd3c7;}.container{-webkit-text-size-adjust:100%;-webkit-tap-highlight-color:rgba(0,0,0,0);font-size:14px;line-height:1.428571429;color:#333;-webkit-font-smoothing:antialiased;font-family:Helvetica Neue,Helvetica,Hiragino Sans GB,Microsoft YaHei,Arial,sans-serif;box-sizing:border-box;padding-right:15px;padding-left:15px;margin-right:auto;max-width:970px;width:800px;height:340px;position:absolute;left:50%;top:50%;margin-left:-400px;margin-top:-170px;}h2{text-align:center;font-family:", titlefontfamily, "}h4{text-align:center;font-family:", timerfontfamily, "}span{text-align:center;font-family:", spanfontfamily, "}"
    ))
    )
}

#' Shiny bindings for lovingtimer
#'
#' Output and render functions for using lovingtimer within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a lovingtimer
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name lovingtimer-shiny
#'
#' @export
lovingtimerOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "lovingtimer", width, height, package = "lovingtimer")
}

#' @rdname lovingtimer-shiny
#' @export
renderLovingtimer <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  htmlwidgets::shinyRenderWidget(expr, lovingtimerOutput, env, quoted = TRUE)
}

#' lovingtimer package
#' @description Create a loving timer in R
#' @section \code{\link{lovingtimer}}: Create a loving timer in R
#' @docType package
#' @name lovingtimer
NULL
