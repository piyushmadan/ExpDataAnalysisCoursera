require(ggplot2)

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

coal <- SCC[ grepl("coal", SCC$Short.Name), ]

merge <- merge(x = NEI, y = coal, by = 'SCC')
merge_agg <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum)
colnames(merge_agg) <- c('year', 'emission')

png(filename = 'plot4.png')

ggplot(data = merge_agg, aes(x = year, y = emission/1000)) + geom_line(aes(group = 1, col = emission)) + scale_colour_gradient(low = 'black', high = 'red') + geom_point(aes(size = 2, col = emission))  + ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) +  ggtitle(expression('Total Emissions of PM'[2.5])) + geom_text(aes(label = round(emission / 1000, digits = 2), size = 2, hjust = 1.5, vjust = 1.5)) + theme(legend.position = 'none') 
dev.off()