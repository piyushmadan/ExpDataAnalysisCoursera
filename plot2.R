NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

sample <- NEI[sample(nrow(NEI), size = 5000, replace = F), ]

MD <- subset(NEI, fips == '24510')

png(filename = 'plot2.png')
barplot(tapply(X = MD$Emissions, INDEX = MD$year, FUN = sum), main = 'Total Emission in Baltimore City, MD',  ylab = expression('PM'[2.5], xlab = 'Year'))
dev.off()