## app.R ##

# Pakiety
install.packages("rsconnect")
install.packages("shiny")
install.packages("shinydashboard")
install.packages("AER")
install.packages("tidyverse")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("scales")
install.packages("treemapify")
install.packages("lessR")
install.packages("fontawesome")
library("rsconnect")
library("shiny")
library("shinydashboard")
library("AER")
library("tidyverse")
library("dplyr")
library("ggplot2")
library("scales")
library("treemapify")
library("lessR")
library("fontawesome")

# Wczytanie danych
dane <- readRDS("dane.rds")
wykres1 <- readRDS("wykres1.rds")
wykres2a <- readRDS("wykres2a.rds")
wykres2b <- readRDS("wykres2b.rds")
wykres3a <- readRDS("wykres3a.rds")
wykres3b <- readRDS("wykres3b.rds")
wykres4a <- readRDS("wykres4a.rds")
wykres4b <- readRDS("wykres4b.rds")
wykres4c <- readRDS("wykres4c.rds")
wykres5 <- readRDS("wykres5.rds")
wykres6 <- readRDS("wykres6.rds")
wykres7 <- readRDS("wykres7.rds")
wykres8 <- readRDS("wykres8.rds")
prod <- readRDS("prod.rds")
przych <- readRDS("przych.rds")
sumkli <- readRDS("sumkli.rds")


## Frontend ##
ui <- dashboardPage(
  
  dashboardHeader(title = "Pulpit nawigacyjny",
                  dropdownMenu(type = "messages",
                               messageItem(
                                 from = "Dział Sprzedaży",
                                 message = "Sprzedaż jest na odpowiednim poziomie."
                               ),
                               messageItem(
                                 from = "Nowy użytkownik",
                                 message = "Jak mogę się zarejestrować?",
                                 icon = icon("question"),
                                 time = "13:45"
                               ),
                               messageItem(
                                 from = "Wspracie",
                                 message = "Nowy serwer jest gotowy.",
                                 icon = icon("lif==-ring"),
                                 time = "2022-06-01"
                               )
                  ),
                  dropdownMenu(type = "notifications",
                               notificationItem(
                                 text = "5 nowych użytkowników",
                                 icon("users")
                               ),
                               notificationItem(
                                 text = "12 dostarczonych zamówień",
                                 icon("truck"),
                                 status = "success"
                               ),
                               notificationItem(
                                 text = "Szybkość serwera 85%",
                                 icon = icon("exclamation-triangle"),
                                 status = "warning"
                               )
                  ),
                  dropdownMenu(type = "tasks", badgeStatus = "success",
                               taskItem(value = 90, color = "green",
                                        "Dokumentacja"
                               ),
                               taskItem(value = 17, color = "aqua",
                                        "Weryfikacja zgłoszeń"
                               ),
                               taskItem(value = 75, color = "yellow",
                                        "Instalacja nowego serwera"
                               ),
                               taskItem(value = 80, color = "red",
                                        "Zatwierdzenie faktur"
                               )
                  )),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Sprzedaż ogółem", tabName = "dashboard1", icon = icon("dashboard")),
      menuItem("Sprzedaż terytorialna", tabName = "dashboard2", icon = icon("dashboard")),
      menuItem("Informacje", tabName = "info", icon = icon("info"))
    )
  ),
  
  dashboardBody(
    tabItems(
      # Pierwsza zakładka
      tabItem(tabName = "dashboard1",
              
              fluidRow(
                infoBox("Sprzedane produkty", prod, icon = icon("box"), color = "light-blue"),
                infoBox("Całkowity dochód", "619 168.20 $", icon = icon("money-bill"), color = "light-blue"),
                infoBox("Suma klientów", sumkli, icon = icon("users"), color = "light-blue")
              ),

              fluidRow(
                
                box(title="Sprzedaż w czasie", 
                    status = "primary", 
                    plotOutput("wykres8", height = 250)),
                
                
                box(title="Segmenty", 
                    status = "primary", 
                    plotOutput("wykres5", height = 250)),
                
              ),
              
              fluidRow(
                
                box(title="Klienci", 
                    status = "primary", 
                    plotOutput("wykres1", height = 250)),
              
                tabBox(
                  title = "Kategorie",
                  id = "tabset3", height = 250,
                  tabPanel("Furniture", plotOutput("wykres4a", height = 250)),
                  tabPanel("Office Supplies", plotOutput("wykres4b", height = 250)),
                  tabPanel("Technology", plotOutput("wykres4c", height = 250)))
      
              )
      ),
      
      # Druga zakładka
      tabItem(tabName = "dashboard2",
              
              fluidRow(
                box(title="Regiony", 
                    status = "primary", 
                    plotOutput("wykres6", height = 300)),
                
                box(title="Sposób dostawy", 
                    status = "primary", 
                    plotOutput("wykres7", height = 300))
              ),
              
              fluidRow(
                tabBox(
                  title = "Stany",
                  id = "tabset1", height = 300,
                  tabPanel("Powyżej średniej", plotOutput("wykres2a", height = 300)),
                  tabPanel("Poniżej średniej", plotOutput("wykres2b", height = 300))),
                
                tabBox(
                  title = "Miasta",
                  id = "tabset2", height = 300,
                  tabPanel("Najwyższa sprzedaż", plotOutput("wykres3a", height = 300)),
                  tabPanel("Najniższa sprzedaż", plotOutput("wykres3b", height = 300)))
              )
      ),
      
      # Trzecia zakładka
      tabItem(tabName = "info",
              h2("Informacje na temat projektu"),
              p("Aplikacja napisana na potrzeby pracy dyplomowej pt.", dQuote("Zastosowanie języka R do analizy i wizualizacji danych na przykładzie pulpitu nawigacyjnego")," służąca do analizy i wizualizacji danych sprzedażowych fikcyjnego sklepu SuperStore w postaci panelu nawigacyjnego. Projekt stworzony z wykorzystaniem języka R, środowiska RStudio oraz pakietu Shiny Apps."),
              p("Autor: Zuzanna Piekarczyk"),
              p("© 2022")
      )
    )
  )
)

server <- function(input, output, session) {
  
  output$wykres1 <- renderPlot({
    wykres1
  })

  output$tabset1Selected <- renderText({
    input$tabset1
  })
  output$wykres2a <- renderPlot({
    wykres2a
  })
  output$wykres2b <- renderPlot({
    wykres2b
  })
  
  
  output$tabset2Selected <- renderText({
    input$tabset2
  })
  output$wykres3a <- renderPlot({
    wykres3a
  })
  output$wykres3b <- renderPlot({
    wykres3b
  })
  
  
  output$tabset3Selected <- renderText({
    input$tabset2
  })
  output$wykres4a <- renderPlot({
    wykres4a
  })
  output$wykres4b <- renderPlot({
    wykres4b
  })
  output$wykres4c <- renderPlot({
    wykres4c
  })
  
  output$wykres5 <- renderPlot({
    wykres5
  })
  
  output$wykres6 <- renderPlot({
    wykres6
  })
  
  output$wykres7 <- renderPlot({
    wykres7
  })
  
  output$wykres8 <- renderPlot({
    wykres8
  })
  
}

shinyApp(ui, server)