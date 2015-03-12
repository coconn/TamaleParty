# tamale party fundraising
# http://www.evite.com/event/020FCVNEZTZW24TRWEPEYUGHJEU2EM
#

# bring in data
# see tamale-party-2015.txt
df <- read.table("~/Desktop/Personal/TamaleParty2015/tamale-party-2015.txt", header=TRUE, stringsAsFactors=FALSE)

# add row for total given so far
totalamt <- sum(df$amt)
newrow = c("endrow", totalamt, "totalcharity")
df = rbind(df,newrow)

# charity is a factor
df$charity <- factor(df$charity) #levels(df$charity)
# amt is a number
df$amt <- as.numeric(df$amt)
# name is a character
df$name <- as.character(df$name)

# make graph
library(ggplot2)

# where / how to save in this loop
setwd("~/Desktop/Personal/TamaleParty2015/")
png(file = "tamale-party-2015-money-raised.png",width=5,height=3,units="in",res=150)

# graph
barpositions <- c("Angels", "WAMU", "Watershed", "totalcharity")
ggplot(data=df, aes(x=charity, y=amt, fill=charity)) + geom_bar(colour="black", stat="identity") + guides(fill=FALSE) + scale_x_discrete(limits = barpositions)

dev.off()




