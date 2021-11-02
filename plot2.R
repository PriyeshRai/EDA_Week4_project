library(dplyr)
path <- file.path(getwd(), "data")

# READ the data
NEI <- readRDS(file.path(path, "summarySCC_PM25.rds"))
SCC <- readRDS(file.path(path, "Source_Classification_Code.rds"))

baltimore.df <- NEI[NEI$fips == "24510", ]
total.emission.blt <- aggregate(Emissions ~ year, baltimore.df, sum)

#PLOT
png("plot2.png", width=480, height=480)
barplot(total.emission.blt$Emissions, 
        names.arg=total.emission.blt$year,
        main = "Total PM 2.5 emissions at Baltimore City from 1999 to 2008",
        xlab = "Years", 
        ylab = "Total PM 2.5 emissions (Tons)")
dev.off()