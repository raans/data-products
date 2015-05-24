library(ggplot2)

data(mtcars)

sample.df <- data.frame(hp=120, vs=0)

# use a generalized linar model, family binomial
glm <- glm(data=mtcars, formula=vs ~ hp, family=binomial(link="logit"))

# print graph
p <- ggplot(mtcars, aes(x=hp, y=vs))
p <- p + geom_point()
p <- p + labs(title="Miles per Gallon and V-Engine/Straight Engine", x="Miles per Gallon (mpg)", y="Type of Engine (vs)")
p <- p + geom_point(data=sample.df, aes(x=hp, y=vs), color="red", size=6)
