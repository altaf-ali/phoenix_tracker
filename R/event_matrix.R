
event_summary <- get_event_summary2(events, country_centroids, periodFROM = 17, periodTO = 0)

actors <- unique(c(event_summary$edges$SideA,event_summary$edges$SideB))

actors <- sort(actors)

head(actors)

event_matrix <- matrix(0,length(actors),length(actors))

colnames(event_matrix) <- rownames(event_matrix) <- actors

for(i in 1:dim(event_summary$edges)[1]){
  temp.actor.1 <- which(colnames(event_matrix)%in%event_summary$edges$SideA[i])
  temp.actor.2 <- which(rownames(event_matrix)%in%event_summary$edges$SideB[i])
  
  event_matrix[temp.actor.1,temp.actor.2] <- event_summary$edges$EventCount[i]
  event_matrix[temp.actor.2,temp.actor.1] <- event_summary$edges$EventCount[i]
}


event_matrix_DT <- event_matrix

event_summary <- get_event_summary2(events, country_centroids, periodFROM = 35, periodTO = 18)

actors <- unique(c(event_summary$edges$SideA,event_summary$edges$SideB))

actors <- sort(actors)

head(actors)

event_matrix <- matrix(0,length(actors),length(actors))

colnames(event_matrix) <- rownames(event_matrix) <- actors

for(i in 1:dim(event_summary$edges)[1]){
  temp.actor.1 <- which(colnames(event_matrix)%in%event_summary$edges$SideA[i])
  temp.actor.2 <- which(rownames(event_matrix)%in%event_summary$edges$SideB[i])
  
  event_matrix[temp.actor.1,temp.actor.2] <- event_summary$edges$EventCount[i]
  event_matrix[temp.actor.2,temp.actor.1] <- event_summary$edges$EventCount[i]
}


event_matrix_BO <- event_matrix





library(igraph)

net <- graph_from_adjacency_matrix(event_matrix_DT, mode="undirected")
plot(net, layout=layout_in_circle,edge.curved=.3,vertex.size=2,edge.width=log(E(net)$weight+1))


net <- graph_from_adjacency_matrix(event_matrix_BO, mode="undirected",weighted=TRUE)
plot(net, layout=layout_in_circle,edge.curved=.3,vertex.size=2,edge.width=log(E(net)$weight+1))


