server = function(input, output) 
{
  load("nodes_initial.RData")
  load("edges_initial.RData")
  
  # `graph_data` is a list of two data frames: one of nodes, one of edges.
  graph_data = reactiveValues(
    nodes = nodes_initial,
    edges = edges_initial
  )
  
  output$editable_network <- renderVisNetwork(
  {
    visNetwork(graph_data$nodes, graph_data$edges) %>%
      visIgraphLayout(layout = "layout_in_circle") %>% 
        visOptions(manipulation = T)
  })
  
  observeEvent(input$editable_network_graphChange, {
    # If the user added a node, add it to the data frame of nodes.
    if(input$editable_network_graphChange$cmd == "addNode") 
    {
      temp = bind_rows(
        graph_data$nodes,
        data.frame(id = input$editable_network_graphChange$id,
                   label = input$editable_network_graphChange$label,
                   stringsAsFactors = F)
      )
      graph_data$nodes = temp
    }
    
    # If the user added an edge, add it to the data frame of edges.
    else if(input$editable_network_graphChange$cmd == "addEdge") {
      temp = bind_rows(
        graph_data$edges,
        data.frame(from = input$editable_network_graphChange$from,
                   to = input$editable_network_graphChange$to,
                   stringsAsFactors = F)
      )
      graph_data$edges = temp
    }
    
    # If the user edited a node, update that record.
    else if(input$editable_network_graphChange$cmd == "editNode") {
      temp = graph_data$nodes
      temp$label[temp$id == input$editable_network_graphChange$id] = input$editable_network_graphChange$label
      graph_data$nodes = temp
    }
    
    # If the user edited an edge, update that record.
    else if(input$editable_network_graphChange$cmd == "editEdge") {
      temp = graph_data$edges
      temp$from[temp$id == input$editable_network_graphChange$id] = input$editable_network_graphChange$from
      temp$to[temp$id == input$editable_network_graphChange$id] = input$editable_network_graphChange$to
      graph_data$edges = temp
    }
    
    # If the user deleted something, remove those records.
    else if(input$editable_network_graphChange$cmd == "deleteElements") {
      for(node.id in input$editable_network_graphChange$nodes) {
        temp = graph_data$nodes
        temp = temp[temp$id != node.id,]
        graph_data$nodes = temp
      }
      for(edge.id in input$editable_network_graphChange$edges) {
        temp = graph_data$edges
        temp = temp[temp$id != edge.id,]
        graph_data$edges = temp
      }
    }
  })
  
  # Render the table showing all the nodes in the graph.
  output$all_nodes = renderTable({
    graph_data$nodes
  })
  
  # Render the table showing all the edges in the graph.
  output$all_edges = renderTable({
    graph_data$edges
  })
}