# tamale party fundraising
# http://www.evite.com/event/020FCVNEZTZW24TRWEPEYUGHJEU2EM
#

# bring in data
# see tamale-party-2015.csv
df <- read.csv("~/Documents/GITHUB/TamaleParty/TamaleParty2015/tamale-party-2015.csv", header=TRUE, stringsAsFactors=FALSE)

# add row for totals given so far
# total in all
totalamt <- sum(df$amt)
newrow = c(totalamt, "totalcharity")
df = rbind(df,newrow)
# total angel
totalamt <- sum(as.numeric(df$amt[df$charity=="The Angel Foundation"]))
newrow = c(totalamt, "totalangel")
df = rbind(df,newrow)
# total LFWA
totalamt <- sum(as.numeric(df$amt[df$charity=="The Little Falls Watershed Alliance"]))
newrow = c(totalamt, "totalLF")
df = rbind(df,newrow)

# amt is a number
df$amt <- as.numeric(df$amt)
# charity is a factor
df$charity <- factor(df$charity) #levels(df$charity)

# pull out the three rows I want
tmp <- nrow(df)
dftotals <- df[c(tmp-2, tmp-1, tmp), ]
dftotals$nicename <- c("Total Raised", "The Angel Foundation", "The Little Falls Watershed Alliance")

# make graph
library(ggplot2)

# where / how to save in this loop
setwd("~/Documents/GITHUB/TamaleParty/TamaleParty2015/")
png(file = "tamale-party-2015-money-raised.png",width=8,height=5,units="in",res=150)

# include date updated
curdate <- Sys.Date()
datetmp <- paste ("Figure updated", curdate)

# graph
barpositions <- c("The Angel Foundation", "The Little Falls Watershed Alliance", "Total Raised")
ggplot(data=dftotals, aes(x=nicename, y=amt, fill=charity)) + geom_bar(colour="black", stat="identity") + guides(fill=FALSE) + scale_x_discrete(limits = barpositions) + ggtitle("Amount Raised Thus Far!") + labs(x="", y="$") + annotate("text", x = 1.1, y = max(dftotals$amt)+40, label = datetmp)

dev.off()




