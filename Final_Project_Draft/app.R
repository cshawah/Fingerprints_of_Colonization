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
                           
                 # First tab, Economy, outputs GDP scatter plot based on checkboxes and line plot based on dropdown selector     
                                
                 tabPanel("Economy", mainPanel(h4("GDP per capita in 2018 by Independence Year"), 
                                               plotOutput("plot_gdp"), 
                                               h4("GDP tracker since 1990"), 
                                               plotOutput("plot_gdp_lines")), 
                                      sidebarPanel(checkboxGroupInput("gdp_select",
                                                   "Occupying Countries to show:",
                                                   choices = country_list,
                                                   selected = country_list)), 
                                      sidebarPanel(selectInput("gdp_select_2", 
                                                    label = "Track GDP of countries last occupied by:", 
                                                    choices = country_list,
                                                    selected = "England"))),
                 
                 # Second tab, Health, outputs mortality scatter plot based on checkboxes and line plot based on dropdown selector   
                 
                 tabPanel("Health", mainPanel(h4("Child Mortality Rate in 2018 by Independence Year"), 
                                               plotOutput("plot_cm"), 
                                               h4("Child Mortality Rate tracker since 1960"), 
                                               plotOutput("plot_cm_lines")), 
                          sidebarPanel(checkboxGroupInput("cm_select",
                                                          "Occupying Countries to show:",
                                                          choices = country_list,
                                                          selected = country_list)), 
                          sidebarPanel(selectInput("cm_select_2", 
                                                   label = "Track Child Mortality Rate of countries last occupied by:", 
                                                   choices = country_list,
                                                   selected = "England"))),
                 
                 # Third tab, Literacy, outputs literacy rate scatter plot based on checkboxes and line plot based on dropdown selector   
                 
                 tabPanel("Literacy", mainPanel(h4("Literacy Rate in 2018 by Independence Year"), 
                                              plotOutput("plot_lit"), 
                                              h4("Literacy Rate tracker since 1970"), 
                                              plotOutput("plot_lit_lines")), 
                          sidebarPanel(checkboxGroupInput("lit_select",
                                                          "Occupying Countries to show:",
                                                          choices = country_list,
                                                          selected = country_list)), 
                          sidebarPanel(selectInput("lit_select_2", 
                                                   label = "Track Literacy Rate of countries last occupied by:", 
                                                   choices = country_list,
                                                   selected = "England"))),
                 
                 # Fourth tab, HDI, outputs HDI scatter plot based on checkboxes and line plot based on dropdown selector   
                 
                 tabPanel("Human Dev. Index", mainPanel(h4("Human Development Index in 2017 by Independence Year"), 
                                                plotOutput("plot_hdi"), 
                                                h4("HDI tracker since 1990"), 
                                                plotOutput("plot_hdi_lines")), 
                          sidebarPanel(checkboxGroupInput("hdi_select",
                                                          "Occupying Countries to show:",
                                                          choices = country_list,
                                                          selected = country_list)), 
                          sidebarPanel(selectInput("hdi_select_2", 
                                                   label = "Track HDI of countries last occupied by:", 
                                                   choices = country_list,
                                                   selected = "England"))),
                 
                 # Fifth tab, About, contains text about data sources and author 
                 
                 tabPanel("About", 
                          mainPanel(
                            h4("Project and Sources:"),
                            p("To look at the colonial history and independence years of world nations, I used the", a("Colonial History Data Set", href = "www.paulhensel.org/icowcol.html"), "from the Issue Correlates of War Project (ICOW) led by Paul R. Hensel at the University of North Texas. This data set contains the year and month that nations gained their independence, as well as the government/nation they gained their independence from."),
                            p("To investigate whether/how these colonial histories have impacts today, I chose four indicators of different kinds of the stability or success of a nation."),
                            p("1) Gross Domestic Product, per capita in PPP. I obtained this data from the", a("World Bank", href = "https://data.worldbank.org/indicator/NY.GDP.MKTP.PP.CD"), "."),
                            p("2) Child Mortality Rate, under 5 y/o deaths per 1000 live births. I obtained this data from the", a("World Bank", href = "https://data.worldbank.org/indicator/SH.DYN.MORT)"), "."),
                            p("3) Literacy Rate, percentage of people ages 15 and above. I obtained this data from the", a("World Bank", href = "https://data.worldbank.org/indicator/SE.ADT.LITR.ZS?end=2018&start=1999&view=chart"), "."),
                            p("4) Human Development Index (HDI), a metric which incorporates life expectancy, education, and standard of living. This dataset is created and accessed from the", a("United Nations Development Programme", href = "http://hdr.undp.org/en/content/human-development-index-hdi"), "."),
                            h4("About Me:"),
                            p("My name is Chloe Shawah, and I member of Harvard College's Class of 2022. I am concentrating in Applied Mathematics with an application to Government, and I am pursuing a secondary field in Ethnicity, Migration, and Rights."),
                            p("email: chloeshawah@college.harvard.edu")
                            ))))

# Define server logic

server <- function(input, output) {
  
  # Data Read In -----------------------------------------------------------------------------------------------------
  # Read in plot data generated from Markdown
  
  x <- read.csv("plot_data.csv")
  g <- read.csv("gdp_line_data.csv")
  c <- read.csv("cm_line_data.csv")
  l <- read.csv("lit_line_data.csv")
  i <- read.csv("hdi_line_data.csv") 
  
  # Scatter Plots ----------------------------------------------------------------------------------------------------
  # Creates GDP scatter plot
  
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
  
  # Creates HDI scatter plot
  
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
  
  # Creates child mortality scatter plot
  
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
  
  # Creates literacy rate scatter plot
  
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
  
  # Line Plots -------------------------------------------------------------------------------------------------------
  
  # Creates GDP line plots
  
  output$plot_gdp_lines<-renderPlot({
    
    # Filters data based on input
    
    h <- g %>% 
      filter(named_ind_from == input$gdp_select_2) 
    
    # Plots GDP by year, colors by country
    
    ggplot(h) +
      aes(x = year, y = gdp, color = name) +
      geom_line() +
      scale_y_log10(limits = c(1e+7, 1e+14)) +
      xlim(1990, 2018) +
      theme(legend.position="right") +
      labs(color = "Country") +
      xlab("Year") +
      ylab("Log of GDP per capita")},
    height = 400,
    width = 800)
  
  # Creates mortality rate line plot
  
  output$plot_cm_lines<-renderPlot({
    
    # Filters data according to input
    
    d <- c %>% 
      filter(named_ind_from == input$cm_select_2) 
    
    # Plots mortality rate by year, colors by country
    
    ggplot(d) +
      aes(x = year, y = cm_rate, color = name) +
      geom_line() +
      ylim(0,400) +
      xlim(1960, 2018) +
      theme(legend.position="right") +
      labs(color = "Country") +
      xlab("Year") +
      ylab("Child Mortality Rate")},
    height = 400,
    width = 800)
  
# Creates literacy rate line plot
  
  output$plot_lit_lines<-renderPlot({
    
    # Filters according to input
    
    m <- l %>% 
      filter(named_ind_from == input$lit_select_2) 
    
    # Plots literacy rate by year, colors by country
    
    ggplot(m) +
      aes(x = year, y = lit_rate, color = name) +
      geom_line() +
      ylim(25,100) +
      xlim(2000, 2018) +
      theme(legend.position="right") +
      labs(color = "Country") +
      xlab("Year") +
      ylab("Literacy Rate")},
    height = 400,
    width = 800)
  
  # Creates HDI line plot
  
  output$plot_hdi_lines<-renderPlot({
   
    # Filters data according to input
     
    j <- i %>% 
      filter(named_ind_from == input$hdi_select_2) 
    
    # Plots HDI by year, colors by country
    
    ggplot(j) +
      aes(x = year, y = hdi, color = name) +
      geom_line() +
      ylim(0,1) +
      xlim(1990, 2017) +
      theme(legend.position="right") +
      labs(color = "Country") +
      xlab("Year") +
      ylab("HDI Index")},
    height = 400,
    width = 800)
  
}

# Run the application 
shinyApp(ui = ui, server = server)

