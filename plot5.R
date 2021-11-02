library(dplyr)
library(ggplot2)

df <- readRDS("data/summarySCC_PM25.rds")
baltimore.df <- filter(df, fips == "24510" & df$type == "ON-ROAD")

net.vehicle.emissions <- baltimore.df %>% group_by(year) %>% summarise(total_emissions = sum(Emissions))

#Draw the plot and save png
png("plot5.png", width=480, height=480)

g <- ggplot(net.vehicle.emissions, aes(factor(year),total_emissions)) + 
        geom_bar(stat = "identity") +
        labs(title = "Toal Emissions using vehicle from 1999 to 2008") +
        labs(x = "Year", y = expression("Total " * PM[2.5] * " Emissions"))
print(g)

dev.off()
