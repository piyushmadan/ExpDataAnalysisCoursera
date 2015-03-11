library(ggplot2)

NEI <- readRDS("data/summarySCC_PM25.rds")
NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))
SCC <- readRDS("data/Source_Classification_Code.rds")

onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

sum <- aggregate(onroad[, 'Emissions'], by = list(onroad$year), sum)
colnames(sum) <- c('year', 'emissions')

png('plot5.png')
ggplot(data = sum, aes(x = year, y = emissions)) + geom_bar(aes(fill = year), stat = "identity") + guides(fill = F) + ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + geom_text(aes(label = round(emissions, 0), size = 1, hjust = 0.5, vjust = 2)) +  ylab(expression('PM'[2.5])) + xlab('Year') 
dev.off()