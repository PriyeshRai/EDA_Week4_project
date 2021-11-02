library(dplyr)
path <- file.path(getwd(), "data")

# READ the data
NEI <- readRDS(file.path(path, "summarySCC_PM25.rds"))
SCC <- readRDS(file.path(path, "Source_Classification_Code.rds"))

total_emission1 <- aggregate(NEI$Emissions, by = list(year = NEI$year), FUN=sum)
total_emission <- aggregate(Emissions ~ year, NEI, sum)

tibble(total_emission)

tl_emisn <- tapply(NEI$Emissions, NEI$year, FUN = sum)
tibble(tl_emisn)

#plot
png("plot1.png", width = 480, height = 480)
plot(total_emission$year, total_emission$Emissions, type = "l",
     main = "Total Emissions of PM2.5",
     ylab = "Total Emissions of PM2.5 (tons)",
     xlab = "Year")

barplot(total_emission$Emissions,
        names.arg=total_emission$year, 
             main = "Total Emissions of PM2.5",
             ylab = "Total Emissions of PM2.5 (tons)",
             xlab = "Year")
dev.off()