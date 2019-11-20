#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.

library(shiny)
library(tidyverse)

# Define UI for application, use Navbar

country_list <-  c("England", "France", "Spain", "Netherlands", "Portugal", "Russia", 
                   "Turkey", "United States", "Other", "No Colonizer")

ui <- fluidPage(navbarPage("Fingerprints of Colonization", 
                 tabPanel("GDP", mainPanel(plotOutput("plot_gdp")), sidebarPanel(checkboxGroupInput("gdp_select",
                                                                                                    "Colonizing Countries to show:",
                                                                                                    choices = country_list,
                                                                                                    selected = country_list))), 
                 tabPanel("HDI", mainPanel(plotOutput("plot_hdi")), sidebarPanel(checkboxGroupInput("hdi_select", 
                                                                                                    "Colonizing Countries to show:",
                                                                                                    choices = country_list,
                                                                                                    selected = country_list))), 
                 tabPanel("Child Mortality", mainPanel(plotOutput("plot_cm")), sidebarPanel(checkboxGroupInput("cm_select", 
                                                                                                    "Colonizing Countries to show:",
                                                                                                    choices = country_list,
                                                                                                    selected = country_list))),
                 tabPanel("About", 
                          mainPanel(
                            p("About my proj!"),
                            p("My name is Chloe Shawah, and I am a sophomore at the College concentrating 
                              in Applied Math to Government with a secondary field in Ethnicity, Migration, and Rights. 
                              My email is chloeshawah@college.harvard.edu.")))))

# Define server logic, renders image

server <- function(input, output) {
  
  x <- read.csv("plot_data.csv")
  
  output$plot_gdp<-renderPlot({
    
    y <- x %>%
      filter(named_ind_from %in% input$gdp_select)
    
    ggplot(y ,aes(x = ind_date, y = gdp_val, color = named_ind_from)) + 
      geom_point(size = 2.5) +
      xlim(900, 2100) +
      scale_y_log10(limits = c(1e+8, 2e+13)) +
      labs(title = "GDP by Indepence Year and Colonizer", color = "Last Colonizer") +
      xlab("Year of Independence") +
      ylab("Log of GDP *year*")},
        height = 400,
        width = 600)
  
  
  output$plot_hdi<-renderPlot({
    
    y <- x %>%
      filter(named_ind_from %in% input$hdi_select)
    
    ggplot(y ,aes(x = ind_date, y = hdi_val, color = named_ind_from)) + 
      geom_point(size = 2.5) +
      xlim(900, 2100) +
      ylim(0.3, 1) +
      labs(title = "HDI by Indepence Year and Colonizer", color = "Last Colonizer") +
      xlab("Year of Independence") +
      ylab("HDI Index")},
    height = 400,
    width = 600)
  
  output$plot_cm<-renderPlot({
    
    y <- x %>%
      filter(named_ind_from %in% input$cm_select)
    
    ggplot(y ,aes(x = ind_date, y = cm_val, color = named_ind_from)) + 
      geom_point(size = 2.5) +
      xlim(900, 2100) +
      ylim(0, 125) +
      labs(title = "Child Mortality by Indepence Year and Colonizer", color = "Last Colonizer") +
      xlab("Year of Independence") +
      ylab("Child Mortality Rate")},
    height = 400,
    width = 600)
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

