library(ggplot2)

data(mtcars)

sample.hp <- 120
sample.wt <- 2.8 # lb/1000

# use a generalized linar model, family binomial
glm <- glm(data=mtcars, formula=am ~ hp + wt, family=binomial(link="logit")) # wt = lb/1000

# sample data to predict
sample.df <- data.frame(hp=sample.hp, wt=sample.wt)
logit.df <- data.frame(hp=seq(from=0, to=500, length.out=500), wt=seq(from=1, t=6, length.out=500))
#logit.df <- data.frame(hp=seq(from=0, to=500, length.out=500), wt=rep(2.8, 500))

# apply model to dataset
pred <- predict(glm, sample.df, type="response")
pred.logit <- predict(glm, logit.df, type="response")
pred.df <- data.frame(hp=seq(from=0, to=500, length.out=500), wt=seq(from=1, t=6, length.out=500), response=pred.logit)

# print graph
p <- ggplot(mtcars, aes(x=hp, y=wt*1000))
p <- p + geom_point()
p <- p + labs(title="Horse power vs. Weight", x="Horse power", y="Weight [lb]")
p <- p + geom_point(data=sample.df, aes(x=hp, y=wt*1000), color="red", size=6)
#p <- p + stat_smooth(data=mydf, aes(x = position, y = response),  method="glm", family="binomial", se=F)
#p <- p + geom_point(data=pred.logit, aes(x=hp, y=wt*1000))
