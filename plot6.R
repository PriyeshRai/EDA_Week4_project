library(dplyr)
library(ggplot2)

df <- readRDS("data/summarySCC_PM25.rds")
balt_los.df <- filter(df, (fips == "24510" | fips == "06037") & df$type == "ON-ROAD")


balt_los.emissions <- balt_los.df %>% group_by(fips, year) %>% summarise(total_emissions = sum(Emissions))
balt_los.emissions$city <- balt_los.emissions$fips %>% recode("06037" = "LosAngles", 
                                                         "24510" = "Baltimore")

#Draw the plot and save png
png("plot6.png", width=480, height=480)

g <- ggplot(balt_los.emissions, aes(year,total_emissions, color = city)) + 
        geom_line() +
        geom_point() +
        labs(title = expression(Total_Emissions[vehicle]*" from 1999 to 2008 in Baltimore Vs LosAngles")) +
        labs(x = "Year", y = expression("Total " * PM[2.5] * " Emissions"))
print(g)

dev.off()

# baltimore.df <- filter(df, fips == "24510" & df$type == "ON-ROAD")
# losangles.df <- filter(df, fips == "06037" & df$type == "ON-ROAD")
# baltimore.emissions <- baltimore.df %>% group_by(fips, year) %>% summarise(total_emissions = sum(Emissions))
# losangles.emissions <- losangles.df %>% group_by(fips, year) %>% summarise(total_emissions = sum(Emissions))

# rng <- range(baltimore.emissions$total_emissions, losangles.emissions$total_emissions)
# plot(x=baltimore.emissions$year, y=baltimore.emissions$total_emissions, 
#      type = "p", pch = 20, col = "blue", ylim = rng)
# lines(x=baltimore.emissions$year, y=baltimore.emissions$total_emissions, col = "blue")
# 
# points(x=losangles.emissions$year, y=losangles.emissions$total_emissions, pch = 20, col="red")
# lines(x=losangles.emissions$year, y=losangles.emissions$total_emissions, col = "red")
# 
# legend("right", legend = c("LosAngles", "Baltimore"), pch = 20, lty=1, col = c("red", "blue"), title = "City")
