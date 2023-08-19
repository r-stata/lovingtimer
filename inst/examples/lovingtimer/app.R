#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(colourpicker)
library(wordcloud2)
library(hwordcloud)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Word Cloud Example"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput(
                inputId = "theme",
                label = "Choose A Theme",
                choices = c("darkgreen",
                            "darkblue",
                            "avocado",
                            "darkunica",
                            "gray",
                            "gridlight",
                            "grid",
                            "sandsignika",
                            "sunset"),
                selected = "sandsignika"
            ),
            textInput(
                inputId = "title",
                label = "Input Chart Title: ",
                placeholder = "Word Cloud",
                value = "Word Cloud"
            ),
            selectInput(
                inputId = "titleAlign",
                label = "Title Alignment: ",
                choices = c("left", "center", "right"),
                selected = 'center'
            ),
            textInput(
                inputId = "titleSize",
                label = "Title Size: ",
                placeholder = "20px",
                value = "20px"
            ),
            colourInput(
                inputId = "titleColor",
                label = "Title Color: ",
                value = "#333333",
                showColour = "background",
                allowTransparent = TRUE
            ),
            textInput(
                inputId = "subtitle",
                label = "Input Subtitle ",
                placeholder = "https://czxa.top",
                value = ""
            ),
            selectInput(
                inputId = "subtitleAlign",
                label = "Subtitle Alignment: ",
                choices = c("left", "center", "right"),
                selected = "center"
            ),
            textInput(
                inputId = "subtitleSize",
                label = "Subtitle Size: ",
                placeholder = "10px",
                value = ""
            ),
            colourInput(
                inputId = "subtitleColor",
                label = "Subtitle Color: ",
                value = "#666666",
                showColour = "background",
                allowTransparent = TRUE
            ),
            textInput(
                inputId = "iterm",
                label = "Attribute in toolbox: ",
                placeholder = "count",
                value = "count"
            ),
            textInput(
                inputId = "height",
                label = "Hight: ",
                placeholder = "500px",
                value = "500px"
            ),
            textInput(
                inputId = "width",
                label = "Width: ",
                placeholder = "100%",
                value = "100%"
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           hwordcloud::hwordcloudOutput("shinyhwordcloud", height = "500px")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    df <- head(demoFreq, 50)
    output$shinyhwordcloud <- renderHwordcloud({
        hwordcloud(text = df$word, size = df$freq,
             theme = input$theme,
             itermName = input$iterm,
             width = input$width,
             height = input$height,
             title = input$title,
             titleAlign = input$titleAlign,
             titleSize = input$titleSize,
             titleColor = input$titleColor,
             subtitle = input$subtitle,
             subtitleAlign = input$subtitleAlign,
             subtitleSize = input$subtitleSize,
             subtitleColor = input$subtitleColor
        )
    })
}

# Run the application
shinyApp(ui = ui, server = server)
