# Load the libraries
library(arules)
library(arulesViz)
library(datasets)

# Load the data set
data(Groceries)

itemFrequencyPlot(Groceries, top=20, type="absolute")

# minimum support = 0.01
# min confidence = 0.80 (.1 @ both ends)
# display top 5 rules

rules <- apriori(Groceries, parameter=list(supp=0.001, conf = 0.8))

# Show top 5 rules, only 2 digits
options(digits=2)
inspect(rules[1:5])

# get summary of rules
summary(rules)

# sorting rules by confidence
rules <- sort(rules, by="confidence", decreasing=TRUE)
inspect(rules[1:5])

# 4 rules are too many in this scenario since all conf = 1, reduce to a max of 3 rules
rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.8,maxlen=3))
inspect(rules[1:5])

# sort on confdience again to see what's up
rules <- sort(rules, by="confidence", decreasing=TRUE)
inspect(rules[1:5])
# 
# removing redundancies
subset.matrix <- is.subset(rules, rules, sparse = FALSE)  # added sparce from https://stackoverflow.com/questions/47279819/getting-error-in-pruning-apriori-rules-in-grocery-dataset

subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
rules.pruned <- rules[!redundant]
rules<-rules.pruned

rules <- sort(rules, by="confidence", decreasing=TRUE)
inspect(rules[1:5])


# targeting items
# answering questions like:

# "What are customers likely to buy before buying whole milk?
rules <- apriori(data=Groceries, parameter=list(supp=0.001, conf=0.80),
                appearance = list(default="lhs",rhs="whole milk"),
                control = list(verbose=F))
rules <- sort(rules, decreasing=TRUE, by="confidence")
inspect(rules[1:5])

# What are custoers like to by if they purchase whole milk?

rules <- apriori(data=Groceries, parameter=list(supp=0.001, conf=0.15),
                 appearance = list(default="rhs",lhs="whole milk"),
                 control = list(verbose=F))
rules <- sort(rules, decreasing=TRUE, by="confidence")
inspect(rules[1:5])

# plotting it out
plot(rules,method="graph",engine="interactive")
