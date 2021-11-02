library(dplyr)
library(ggplot2)

df <- readRDS("data/summarySCC_PM25.rds")
src.df <- readRDS("data/Source_Classification_Code.rds")

#grep -> gives the indices into char vector if pattern is found
#grepl-> gives the boolean vector of same length as input
isCoalSrc <- grepl("coal", src.df$EI.Sector, ignore.case = TRUE)
coal.df <- filter(src.df, isCoalSrc)

coalSrc.emissions <- merge(df, coal.df, by = "SCC")
net.coal.emissions <- coalSrc.emissions %>% group_by(year) %>% summarise(total_emissions = sum(Emissions))

#Draw the plot and save png
png("plot4.png", width=480, height=480)

g <- ggplot(net.coal.emissions, aes(factor(year),total_emissions)) + 
        geom_bar(stat = "identity") +
        labs(title = "Toal Emissions using coal from 1999 to 2008") +
        labs(x = "Year", y = expression("Total " * PM[2.5] * " Emissions"))
print(g)

dev.off()
