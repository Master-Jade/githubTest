sidebar = dashboardSidebar(
  sidebarMenu(
    menuItem("Clients information", tabName = "client", icon = icon("building")),
    menuItem("Apartment information", tabName = "apartment", icon = icon("address-card")),
    menuItem("Matches", tabName = "match", icon = icon("connectdevelop"))
  )
)

body = dashboardBody(
  tabItems(
    tabItem(tabName = "client",
            h2("Display the clients' information"),
            tableOutput("all_nodes")),
    tabItem(tabName = "apartment",
            h2("Display the apartments' information")),
    tabItem(tabName = "match",
            class = "active",
            h2("Display the matches"),
            fluidRow(
              box(
                visNetworkOutput("editable_network", height = "600px")),
              box(
                # Display two tables: one with the nodes, one with the edges.
                tags$h1("Nodes in the graph:"),
                tableOutput("all_nodes")),
              box(
                tags$h1("Edges in the graph:"),
                tableOutput("all_edges")))
            )
  )
)

dashboardPage(
  skin = "blue",
  dashboardHeader(title = "For An Zhou"),
  sidebar,
  body
)