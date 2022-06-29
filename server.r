shinyServer(function(input, output, session) {
  
  observe({
    # Para ler o ficheiro de input
    file1 = input$id_file
    req(file1)
    data1 = read.csv(file1$datapath)
    
    # reactive data
    datax <- reactive({
      
      data1[, input$var1]
      
    })
    datay <- reactive({
      
      data1[, input$var2]
      
    })
    dataz <- reactive({
      
      data1[, input$var3]
      
    })
    
    # Para dar updates do button das variaveis
    observeEvent(input$id_file,{
      vars <- names(data1)
      updateRadioButtons(session, "var1",
                         choices = vars,
      )
      updateRadioButtons(session, "var2",
                         choices = vars,
      )
      updateRadioButtons(session, "var3",
                         choices = vars,
      )
    })
    
    output$hist <- renderPlot({
      
      ggplot(data1, aes(x=data1[, input$var1])) + 
        geom_histogram( binwidth=input$bins +1, fill=input$color, color="#e9ecef", alpha=0.9)+
        labs(x = input$var1)+
        ggtitle(input$title)
    })
    
    output$boxplot <- renderAmCharts({
      
      x <-  datax()
      amBoxplot(x, col = input$color, main = "Boxplot", export = TRUE, zoom = TRUE)
        
    })
    
    # boxplot
    
    output$boxplot2 <- renderPlot({
      ggplot(data1 ,aes(x=data1[, input$var1], y=data1[, input$var2], fill=data1[, input$var1])) +
      geom_boxplot() +
      #geom_jitter(color=input$color, size=0.4, alpha=0.9) +
      ggtitle(input$title) +
      xlab(input$var1)+
      ylab(input$var2)
    })
    
    ## grafico de barras
    
    output$barras <- renderPlotly({
    plot_ly(data1, x = ~data1[, input$var1], y = ~data1[, input$var2], type = 'bar')%>%
        layout(title = input$title,xaxis = list(title = input$var1),yaxis = list(title = 'Count'), barmode = 'group')
    })
    
    ## grafico de densidade
    output$densidade <- renderPlot({
      data1 %>%
        ggplot( aes(x=data1[,input$var1])) +
        geom_density(fill=input$color, color="#e9ecef", alpha=0.8)+
        ggtitle(input$title)+
        labs(x = input$var1)
    })
    
    ## ggplot
    output$grafico <- renderPlot({
      ggplot(data1, aes(x = data1[, input$var1], y = data1[, input$var2])) +
        geom_point()+
        labs(y = input$var2, x = input$var1)+
        ggtitle(input$title)
    })
    
    ## grafico temporal
    output$pltly <- renderPlotly({
      
      plot_ly(data1,x = ~data1[, input$var1], y = ~data1[, input$var2],type = 'scatter', mode = 'lines')%>%
        layout(title =input$title,xaxis = list(title = input$var1), yaxis = list(title = input$var2))
    })
    
    ## scatter plot
    output$plot <- renderPlotly({
      
      plot_ly(data1, x = ~data1[, input$var1], y = ~data1[, input$var2], color = ~data1[, input$var3], colors = data1[, input$var3])%>%
      layout(title = input$title, xaxis = list(title = input$var1), 
             yaxis = list(title = input$var2), legend = list(title=list(text=input$var3)))
    })
    
    # output$detailed_plot <- renderPlotly({
    #   data1 %>%
    #     plot_ly(
    #       x = ~data1[, input$var1],
    #       y = ~data1[, input$var2],
    #       frame = data1[, input$var3],
    #       type = 'scatter',
    #       mode = 'markers',
    #       marker = list(size = 20),
    #       showlegend = FALSE
    #     )%>%
    #     layout(xaxis = list(title = input$var1), yaxis = list(title = input$var2))
    # })
    
    ## grafico animado
    output$animated_plot <- renderPlotly({
      data1 %>%
        plot_ly(
          x = ~data1[, input$var1],
          y = ~data1[, input$var2],
          frame = data1[, input$var1],
          type = 'scatter',
          mode = 'point',
          #mode = 'lines',
          marker = list(size = 20),
          showlegend = FALSE
        ) %>% 
        animation_button(visible = FALSE) %>%
        onRender("
        function(el,x){
          $('#anim').on('click', function(){Plotly.animate(el);});
        }")%>%
        layout(title =input$title,xaxis = list(title = input$var1), yaxis = list(title = input$var2))
    })
    
    ##
    
    # summary
    output$summary <- renderPrint({
      summary(data1)
    })
    
    # table
    output$table <- renderDataTable({
      data1
    })
    
  })
  
})