#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.

# Load necessary libraries

library(shiny)
library(tidyverse)

# Define a list of countries to be used with checkboxes

country_list <-  c("England", "France", "Spain", "Netherlands", "Portugal", "Russia", 
                   "Turkey", "United States", "Other", "No Colonizer")

# Define UI for application, use Navbar

ui <- fluidPage(navbarPage("Fingerprints of Colonization",
                           
                 # First tab, Economy, outputs GDP plot based on checkboxes in sidePanel     
                                
                 tabPanel("Economy", mainPanel(h4("GDP per capita by Independence Year"), plotOutput("plot_gdp")), sidebarPanel(checkboxGroupInput("gdp_select",
                                                                                                    "Occupying Countries to show:",
                                                                                                    choices = country_list,
                                                                                                    selected = country_list))),
                 
                 # Second tab, Health, outputs child mortality plot based on checkboxes in sidePanel  
                 
                 tabPanel("Health", mainPanel(h4("Child Mortality Rate by Independence Year"), plotOutput("plot_cm")), sidebarPanel(checkboxGroupInput("cm_select", 
                                                                                                                "Occupying Countries to show:",
                                                                                                                choices = country_list,
                                                                                                                selected = country_list))),
                 
                 # Third tab, Literacy, outputs literacy rate plot based on checkboxes in sidePanel  
                 
                             tabPanel("Literacy", mainPanel(h4("Literacy Rate by Independence Year"), plotOutput("plot_lit")), sidebarPanel(checkboxGroupInput("lit_select", 
                                                                                                          "Occupying Countries to show:",
                                                                                                          choices = country_list,
                                                                                                          selected = country_list))),
                 
                 # Fourth tab, HDI, outputs HDI plot based on checkboxes in sidePanel  
                 
                 tabPanel("Human Dev. Index", mainPanel(h4("Human Development Index by Independence Year"), plotOutput("plot_hdi")), sidebarPanel(checkboxGroupInput("hdi_select", 
                                                                                                    "Occupying Countries to show:",
                                                                                                    choices = country_list,
                                                                                                    selected = country_list))), 
                 
                 # Fifth tab, About, contains text about data sources and author 
                 
                 tabPanel("About", 
                          mainPanel(
                            h4("Project and Sources:"),
                            p("To look at the colonial history and independence years of world nations, I used the", a("Colonial History Data Set", href = "www.paulhensel.org/icowcol.html"), "from the Issue Correlates of War Project (ICOW) led by Paul R. Hensel at the University of North Texas. This data set contains the year and month that nations gained their independence, as well as the government/nation they gained their independence from."),
                            p("To investigate whether/how these colonial histories have impacts today, I chose four indicators of different kinds of the stability or success of a nation."),
                            p("1) Gross Domestic Product, per capita in PPP in the year 2018. I obtained this data from the", a("World Bank", href = "https://data.worldbank.org/indicator/NY.GDP.MKTP.PP.CD"), "."),
                            p("2) Child Mortality Rate, under 5 y/o deaths per 1000 live births in the year 2018. I obtained this data from the", a("World Bank", href = "https://data.worldbank.org/indicator/SH.DYN.MORT)"), "."),
                            p("3) Literacy Rate, percentage of people ages 15 and above in the year 2018. I obtained this data from the", a("World Bank", href = "https://data.worldbank.org/indicator/SE.ADT.LITR.ZS?end=2018&start=1999&view=chart"), "."),
                            p("4) Human Development Index (HDI), a metric which incorporates life expectancy, education, and standard of living, in the year 2018. This dataset is created and accessed from the", a("United Nations Development Programme", href = "http://hdr.undp.org/en/content/human-development-index-hdi"), "."),
                            h4("About Me:"),
                            p("My name is Chloe Shawah, and I member of Harvard College's Class of 2022. I am concentrating in Applied Mathematics with an application to Government, and I am pursuing a secondary field in Ethnicity, Migration, and Rights."),
                            p("email: chloeshawah@college.harvard.edu")
                            ))))

# Define server logic

server <- function(input, output) {
  
  # Read in plot data generated from Markdown
  
  x <- read.csv("plot_data.csv")
  
  # Creates GDP Plot
  
  output$plot_gdp<-renderPlot({
    
    # Filters data to respond to checkbox inputs
    
    y <- x %>%
      filter(named_ind_from %in% input$gdp_select)
    
    # Plots GDP by independence year, colors by last occupier
    # Sets x and y limits so that scales do not change with checkboxes
    # Scales y with log10
    
    ggplot(y ,aes(x = ind_date, y = gdp_val, color = named_ind_from)) + 
      geom_point(size = 2.5) +
      xlim(900, 2100) +
      scale_y_log10(limits = c(1e+8, 2e+13)) +
      labs(color = "Last Occupier") +
      xlab("Year of Independence") +
      ylab("Log of GDP per capita")},
        height = 400,
        width = 600)
  
  # Creates HDI plot
  
  output$plot_hdi<-renderPlot({
    
    # Filters data to respond to checkbox inputs
    
    y <- x %>%
      filter(named_ind_from %in% input$hdi_select)
    
    # Plots HDI by independence year, colors by last occupier
    # Sets x and y limits so that scales do not change with checkboxes
    
    ggplot(y ,aes(x = ind_date, y = hdi_val, color = named_ind_from)) + 
      geom_point(size = 2.5) +
      xlim(900, 2100) +
      ylim(0.3, 1) +
      labs(color = "Last Occupier") +
      xlab("Year of Independence") +
      ylab("HDI Index")},
    height = 400,
    width = 600)
  
  # Creates child mortality plot
  
  output$plot_cm<-renderPlot({
    
    # Filters data to respond to checkbox inputs
    
    y <- x %>%
      filter(named_ind_from %in% input$cm_select)
    
    # Plots child mortality rate by independence year, colors by last occupier
    # Sets x and y limits so that scales do not change with checkboxes
    
    ggplot(y ,aes(x = ind_date, y = cm_val, color = named_ind_from)) + 
      geom_point(size = 2.5) +
      xlim(900, 2100) +
      ylim(0, 125) +
      labs(color = "Last Occupier") +
      xlab("Year of Independence") +
      ylab("Child Mortality Rate")},
    height = 400,
    width = 600)
  
  # Creates literacy rate plot
  
  output$plot_lit<-renderPlot({
    
    # Filters data to respond to checkbox inputs
    
    y <- x %>%
      filter(named_ind_from %in% input$lit_select)
    
    # Plots literacy rate by independence year, colors by last occupier
    # Sets x and y limits so that scales do not change with checkboxes
    
    ggplot(y ,aes(x = ind_date, y = lit_val, color = named_ind_from)) + 
      geom_point(size = 2.5) +
      xlim(900, 2100) +
      ylim(0, 100) +
      labs(color = "Last Occupier") +
      xlab("Year of Independence") +
      ylab("Literacy Rate")},
    height = 400,
    width = 600)
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

