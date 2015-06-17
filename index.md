---
title       : Manual Transmission Prediction of Cars
subtitle    : A logistic regression model
author      : R. Ansorg
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction

* The `mtcars` dataset is used
* Task: using a logistic regression to determine the probability if a car fits the model
* Parameter used for the model: horse power (hp) and weight (wt)

---

## Graphical user interface (Shiny app)

* User input: horse power (hp) and weight (wt)
* Output: A probabilty if a car fits the model
* Graph output: The point of the user's input

---

## Graphical user interface (con't)

<img src="assets/fig/unnamed-chunk-1-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" style="display: block; margin: auto;" />

---

## Model

* Using a generalized linear model of the binomial family


```r
glm <- glm(data=mtcars, formula=am ~ hp + wt, family=binomial(link="logit"))
```

* Predict a value


```r
newdata <- data.frame(hp=120, wt=2.8) # hp=horse power, wt=weight [lbs/1000]
predict(glm, newdata, type="response")
```

```
##         1 
## 0.6418125
```

* Result

The probability of the car (horse power 120, weight 2800 lbs) being fitted with a manual transmission is about **64.18%**.
