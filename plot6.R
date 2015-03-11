
library(ggplot2)

NEI <- readRDS("data/summarySCC_PM25.rds")
NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))
SCC <- readRDS("data/Source_Classification_Code.rds")

onroad_md <- subset(NEI,   type=='ON-ROAD' & fips== '24510')
onroad_ca <- subset(NEI,  type=='ON-ROAD' & fips=='06037')

md_df <- aggregate(onroad_md[, 'Emissions'],by=list(onroad_md$year), sum)
colnames(md_df) <- c('year', 'Emissions')
md_city <- paste(rep('MD', 4))

ca_df <- aggregate(onroad_ca[, 'Emissions'], by = list(onroad_ca$year), sum)
colnames(ca_df ) <- c('year', 'Emissions')
ca_df $City <- paste(rep('CA', 4))

df <- as.data.frame(rbind(md_df, ca_df ))

png('plot6.png')
ggplot(data = df, aes(x = year, y = Emissions)) + geom_bar(aes(fill = year),stat = "identity") + guides(fill = F) + ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none') + facet_grid(. ~ City)  + geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1)) 
dev.off() 