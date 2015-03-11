NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

NEIsample <- NEI[sample(nrow(NEI), size = 1000, replace = F), ]

em <- aggregate(NEI[, 'Emissions'], by = list(NEI$year), FUN = sum)
em$PM <- round(em[, 2] / 1000, 2)

png(filename = "plot1.png")
barplot(em$PM, names.arg = em$Group.1, main = expression('Total Emission of PM'[2.5]), xlab = 'Year', ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.off()