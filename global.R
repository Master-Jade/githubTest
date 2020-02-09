rm(list = ls())

library(shiny)
library(shinydashboard)
library(visNetwork)

# Libraries ---------------------------------------------------------------
library(visNetwork)
library(igraph)

idGenerator <- function(n = 50) {
  a <- do.call(paste0, replicate(3, sample(LETTERS, n, TRUE), FALSE))
  paste0(a, sprintf("%04d", sample(9999, n, TRUE)), sample(LETTERS, n, TRUE))
}

# Data Preparation --------------------------------------------------------
notes_id = idGenerator(30)
edges_id = idGenerator(50)

nodes_initial = data.frame(id = notes_id,
                           label = notes_id,
                           stringsAsFactors = F)
edges_initial = data.frame(id = edges_id,
                           from = sample(notes_id, 50, replace = T), 
                           to = sample(notes_id, 50, replace = T),
                           stringsAsFactors = F)

# Save nodes and edges for shiny app
save(nodes_initial, file = "nodes.RData")
save(edges_initial, file = "edges.RData")
