#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.

# Load necessary libraries

library(shiny)
library(tidyverse)
library(shinythemes)

# Define a list of countries to be used with checkboxes

country_list <-  c("England", "France", "Spain", "Netherlands", "Portugal", "Russia", 
                   "Turkey", "United States", "Other", "No Colonizer")

# Define UI for application, use Navbar

ui <- fluidPage(navbarPage("Fingerprints of Colonization",
                           
                 theme = shinytheme("journal"),
                           
                 tabPanel("About", mainPanel(h3("Visualizing the Effect of Colonization"),
                                             p("The project seeks to determine if there are effects of foreign colonization/occupation traceable today by tracking indicators of the economic prosperity, health, and education in world nations over time."),
                                             p("When viewing this project, it is important to remembers that there are challenges and subjective judgement calls that arise when trying to make something as complicated as colonial history fit into a tidy dataset. Sometimes, it is difficult to determine which foreign power to call the “colonizer” and to mark an exact year when a country became independent. My project defers to all of the judgement calls made in Paul Hensel’s dataset (see Sources tab for more information), but I encourage viewers to keep in mind that many intricacies are eliminated when forcing a very complicated history into a data frame, and to think critically about which countries have been listed under which colonizing powers and whether or not you would make the same categorizations."), 
                                             p("Further, as I began labeling the visualizations in my project I realized that there were also subjective judgement calls to made with the the terminology. While the title of my project is still investigating the effect of colonization, in my plots, I changed the label “colonizers” to the more general “foreign occupiers,” as it did not seem appropriate in all cases to call the occupying country a “colonizer.”"),
                                             p("I hope you enjoy looking at my project as much as I enjoyed making it, and that it leaves you with some food for thought about how countries around the world have arrived in their current state.")
                                             )),
                           
                 # First tab, Economy, outputs GDP scatter plot based on checkboxes and line plot based on dropdown selector     
                                
                 tabPanel("Economy", mainPanel(h3("Looking at the Lasting Effect of Foreign Occupation in 2018:"),
                                               h4("GDP per capita in 2018 by Year of Independence/Formation"), 
                                               plotOutput("plot_gdp"), 
                                               h3("Looking at the Effect of Foreign Occupation over Time:"), 
                                               h4("Tracking GDP of occupied countries since 1990"),
                                               plotOutput("plot_gdp_lines"),
                                               h3("Comparing Occupying Countries:"), 
                                               h4("Tracking average GDP over time of countries last occupied by different occupiers"),
                                               plotOutput("mean_gdp")), 
                                      sidebarPanel(checkboxGroupInput("gdp_select",
                                                   "Occupying Countries to show:",
                                                   choices = country_list,
                                                   selected = country_list)), 
                                      sidebarPanel(selectInput("gdp_select_2", 
                                                    label = "Track GDP of countries last occupied by:", 
                                                    choices = country_list,
                                                    selected = "England"))),
                 
                 # Second tab, Health, outputs mortality scatter plot based on checkboxes and line plot based on dropdown selector   
                 
                 tabPanel("Health", mainPanel(h3("Looking at the Lasting Effect of Foreign Occupation in 2018:"),
                                               h4("Child Mortality Rate in 2018 by Year of Independence/Formation"), 
                                               plotOutput("plot_cm"),
                                               h3("Looking at the Effect of Foreign Occupation over Time:"),
                                               h4("Tracking Child Mortality Rate of occupied countries since 1960"), 
                                               plotOutput("plot_cm_lines"),
                                               h3("Comparing Occupying Countries:"),
                                               h4("Tracking average Child Mortality Rate over time of countries last occupied by different occupiers"),
                                               plotOutput("mean_cm")),
                          sidebarPanel(checkboxGroupInput("cm_select",
                                                          "Occupying Countries to show:",
                                                          choices = country_list,
                                                          selected = country_list)), 
                          sidebarPanel(selectInput("cm_select_2", 
                                                   label = "Track Child Mortality Rate of countries last occupied by:", 
                                                   choices = country_list,
                                                   selected = "England"))),
                 
                 # Third tab, Education, outputs literacy rate scatter plot based on checkboxes and line plot based on dropdown selector   
                 
                 tabPanel("Education", mainPanel(h3("Looking at the Lasting Effect of Foreign Occupation in 2018:"),
                                              h4("Literacy Rate in 2018 by Year of Independence/Formation"), 
                                              plotOutput("plot_lit"), 
                                              h3("Looking at the Effect of Foreign Occupation over Time:"),
                                              h4("Tracking Literacy Rate of occupied countries since 1970"), 
                                              plotOutput("plot_lit_lines"),
                                              h6("Unfortunately there is not enough data points to take averages over time by last occupier.")), 
                          sidebarPanel(checkboxGroupInput("lit_select",
                                                          "Occupying Countries to show:",
                                                          choices = country_list,
                                                          selected = country_list)), 
                          sidebarPanel(selectInput("lit_select_2", 
                                                   label = "Track Literacy Rate of countries last occupied by:", 
                                                   choices = country_list,
                                                   selected = "England"))),
                 
                 # Fourth tab, HDI, outputs HDI scatter plot based on checkboxes and line plot based on dropdown selector   
                 
                 tabPanel("Quality of Life", mainPanel(h3("Looking at the Lasting Effect of Foreign Occupation in 2017:"),
                                                        h4("Human Development Index in 2017 by Year of Independence/Formation"),
                                                        plotOutput("plot_hdi"), 
                                                        h3("Looking at the Effect of Foreign Occupation over Time:"),
                                                        h4("Tracking HDI of occupied countries since 1990"), 
                                                        plotOutput("plot_hdi_lines"),
                                                        h3("Comparing Occupying Countries:"),
                                                        h4("Tracking average HDI over time of countries last occupied by different occupiers"),
                                                        plotOutput("mean_hdi")),
                          sidebarPanel(checkboxGroupInput("hdi_select",
                                                          "Occupying Countries to show:",
                                                          choices = country_list,
                                                          selected = country_list)), 
                          sidebarPanel(selectInput("hdi_select_2", 
                                                   label = "Track HDI of countries last occupied by:", 
                                                   choices = country_list,
                                                   selected = "England"))),
                 
                 # Fifth tab, About, contains text about data sources and author 
                 
                 tabPanel("Sources", 
                          mainPanel(
                            h4("Sources:"),
                            p("To look at the colonial history and independence years of world nations, I used the", a("Colonial History Data Set", href = "https://www.paulhensel.org/icowcol.html"), "from the Issue Correlates of War Project (ICOW) led by Paul R. Hensel at the University of North Texas. This data set contains the year and month that nations gained their independence, as well as the government/nation they gained their independence from."),
                            p("To investigate whether/how these colonial histories have impacts today, I chose four indicators of different kinds of the stability or success of a nation."),
                            p("1) Gross Domestic Product, per capita in PPP. I obtained this data from the", a("World Bank", href = "https://data.worldbank.org/indicator/NY.GDP.MKTP.PP.CD"), "."),
                            p("2) Child Mortality Rate, under 5 y/o deaths per 1000 live births. I obtained this data from the", a("World Bank", href = "https://data.worldbank.org/indicator/SH.DYN.MORT)"), "."),
                            p("3) Literacy Rate, percentage of people ages 15 and above. I obtained this data from the", a("World Bank", href = "https://data.worldbank.org/indicator/SE.ADT.LITR.ZS?end=2018&start=1999&view=chart"), "."),
                            p("4) Human Development Index (HDI), a metric which incorporates life expectancy, education, and standard of living. This dataset is created and accessed from the", a("United Nations Development Programme", href = "http://hdr.undp.org/en/content/human-development-index-hdi"), "."),
                            h4("About Me:"),
                            p("My name is Chloe Shawah, and I member of Harvard College's Class of 2022. This is my final project for GOV1005: Data. I am concentrating in Applied Mathematics with an application to Government, and I am pursuing a secondary field in Ethnicity, Migration, and Rights."),
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
  d <- read.csv("mean_gdp.csv")
  q <- read.csv("mean_cm.csv")
  r <- read.csv("mean_lit.csv")
  e <- read.csv("mean_hdi.csv")
  
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
    
    k <- d %>% 
      filter(named_ind_from == input$gdp_select_2)
    
    # Plots GDP by year, colors by country
    
    ggplot() +
      geom_line(data = k, aes(x = year, y = mean_gdp), color = "black", size = 1) +
      geom_line(data = h, aes(x = year, y = gdp, color = name)) +
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
    
    o <- q %>% 
      filter(named_ind_from == input$cm_select_2)
    
    # Plots mortality rate by year, colors by country
    
    ggplot() +
      geom_line(data = d, aes(x = year, y = cm_rate, color = name)) +
      geom_line(data = o, aes(x = year, y = mean_cm), color = "black", size = 1) +
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
    
    w <- r %>% 
      filter(named_ind_from == input$lit_select_2) 
    
    # Plots literacy rate by year, colors by country
    
    ggplot() +
      geom_line(data = m, aes(x = year, y = lit_rate, color = name)) +
     # geom_line(data = w, aes(x = year, y = mean_lit), color = "black", size = 1) +
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
    
    n <- e %>% 
      filter(named_ind_from == input$hdi_select_2) 
      
    # Plots HDI by year, colors by country
    
    ggplot() +
      geom_line(data = j, aes(x = year, y = hdi, color = name)) +
      geom_line(data = n, aes(x = year, y = mean_hdi), color = "black", size = 1) +
      ylim(0,1) +
      xlim(1990, 2017) +
      theme(legend.position="right") +
      labs(color = "Country") +
      xlab("Year") +
      ylab("HDI Index")},
    height = 400,
    width = 800)
  
  # Mean Line Plots -------------------------------------------------------------------------------------------------
  
  # Mean GDP Line Plot
  
  output$mean_gdp<-renderPlot({
  
    ggplot() +
      geom_line(data = d, aes(x = year, y = mean_gdp, color = named_ind_from), size = 1) +
      scale_y_log10(limits = c(1e+9, 1e+13)) +
      xlim(1990, 2018) +
      theme(legend.position="right") +
      labs(color = "Last Occupier") +
      xlab("Year") +
      ylab("Average Log of GDP per capita for countries formerly occupied")},
    height = 400,
    width = 800)
  
  # Mean Child Mortality Rate Line Plot
  
  output$mean_cm<-renderPlot({
    
    ggplot() +
      geom_line(data = q, aes(x = year, y = mean_cm, color = named_ind_from), size = 1) +
      ylim(0,300) +
      xlim(1960, 2018) +
      theme(legend.position="right") +
      labs(color = "Last Occupier") +
      xlab("Year") +
      ylab("Average Child Mortality Rate for countries formerly occupied")},
    height = 400,
    width = 800)
  
  # Mean HDI Line Plot
  
  output$mean_hdi<-renderPlot({
    
    ggplot() +
      geom_line(data = e, aes(x = year, y = mean_hdi, color = named_ind_from), size = 1) +
      ylim(0.25,0.9) +
      xlim(1990, 2017) +
      theme(legend.position="right") +
      labs(color = "Country") +
      xlab("Year") +
      ylab("Average HDI Index of countries formerly occupied")},
    height = 400,
    width = 800)
  
}

# Run the application 
shinyApp(ui = ui, server = server)

