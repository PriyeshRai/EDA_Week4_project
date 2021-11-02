library(ggplot2)
path <- file.path(getwd(), "data")

# READ the data
NEI <- readRDS(file.path(path, "summarySCC_PM25.rds"))
SCC <- readRDS(file.path(path, "Source_Classification_Code.rds"))

# baltimore.df <- NEI[NEI$fips == "24510", ]
# grp.df <- tapply(baltimore.df$Emissions, list(baltimore.df$year, baltimore.df$type), sum)
# 
# plot(grp.df[,1], type = "line")
# plot(grp.df[,2], type = "line")
# plot(grp.df[,3], type = "line")
# plot(grp.df[,4], type = "line")
# 
baltimore_NEI <- NEI[NEI$fips=="24510", ]

# Aggregate by sum the total emissions by year
aggregatedTotalByYear <- aggregate(Emissions ~ year + type , baltimore_NEI, sum)

# Draw plot and save png

# png("plot3.png",width=480,height=480)

g <- ggplot(aggregatedTotalByYear, aes(year, Emissions, color = type))

g <- g + geom_line() +
        xlab("year") +
        ylab("Total PM 2.5 Emissions") +
        ggtitle("Total Emissions in Baltimore City from 1999 to 2008")
print(g)
