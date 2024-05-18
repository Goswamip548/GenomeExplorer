#installing complexheatmap 
library(devtools)
install_github("jokergoo/ComplexHeatmap")

#Form the table for input
mat = read.table(textConnection(
     ",P55,P62,P71,P81,P132,P136,P63,P96,P101,P114,P128,P153,P115,P120,P127,P129,P130,P140,P152,P162,P168,P169,P67,P99,P118,P122,P124,P143,P149,P159,P166,P187T1,P187T2,P50,P91
 LRP1B,,Intron,Missense_Mutation;Intron;Splice_Site,,Intron;Silent,,,Intron,,,,Intron,Missense_Mutation,,Missense_Mutation;Intron;Frame_Shift_Ins;Nonsense_Mutation;Splice_Region,,,Silent;Intron;Missense_Mutation;Splice_Region;Five_UTR,,,,,,Intron;Missense_Mutation,,Splice_Region,Missense_Mutation,Missense_Mutation;Intron;Silent;Five_UTR,Silent,Splice_Region,,Missense_Mutation;Nonsense_Mutation;Intron,Intron;Silent,Missense_Mutation;Frame_Shift_Del;Intron;Silent,Missense_Mutation
 FAT4,,Missense_Mutation,Missense_Mutation;Silent;Intron,,Missense_Mutation;Silent;Intron,,,,Missense_Mutation;Intron,,,Intron,Missense_Mutation,,Silent;Nonsense_Mutation;Missense_Mutation,Silent;Missense_Mutation,,Missense_Mutation;Intron;Silent;Nonsense_Mutation,,,,,,Nonsense_Mutation;Missense_Mutation;Silent,,Missense_Mutation,Missense_Mutation,Missense_Mutation,Missense_Mutation,,,Missense_Mutation,Silent;Intron,Missense_Mutation,Silent;Missense_Mutation
 BIRC6,,,Nonsense_Mutation;Intron,,Frame_Shift_Del;Intron,,,Frame_Shift_Del,Frame_Shift_Ins;Intron,,,Missense_Mutation,,,Silent;Nonsense_Mutation;Missense_Mutation;Intron,Frame_Shift_Del,,Intron;Nonsense_Mutation;Missense_Mutation,,,,,,Intron;Missense_Mutation;Splice_Region,,Silent,,Frame_Shift_Del;Intron,Nonsense_Mutation,Missense_Mutation,,,Intron,Silent;Missense_Mutation;Intron,Silent;Intron
 APC,,Nonsense_Mutation,Silent;Nonsense_Mutation,,,,,,,,,,Splice_Site;Nonsense_Mutation,Nonsense_Mutation;Frame_Shift_Ins,Missense_Mutation;Intron;Silent;Nonsense_Mutation,,,Missense_Mutation;Intron;Nonsense_Mutation;Silent,,Nonsense_Mutation,Frame_Shift_Del,Frame_Shift_Del;Missense_Mutation,,Nonsense_Mutation;Missense_Mutation;Three_UTR,,,,Missense_Mutation,Intron,Missense_Mutation,,Nonsense_Mutation,Missense_Mutation,Silent;Missense_Mutation,
 NBEA,,Intron,Intron;Silent;Missense_Mutation,,Intron,,,Missense_Mutation,Intron;Silent,,,Intron,,,Silent;Frame_Shift_Ins;Missense_Mutation;Intron,Missense_Mutation,,Missense_Mutation;Intron;Nonsense_Mutation;Splice_Region;Silent,,,,,,Intron;Missense_Mutation;Nonsense_Mutation,,,,Intron,Intron;Missense_Mutation,,,,Frame_Shift_Del,Splice_Site,Frame_Shift_Del;Intron;Frame_Shift_Ins
 ZFHX3,Silent,Intron,Intron;Missense_Mutation,,,,,Silent;Missense_Mutation,,,,Five_UTR,,,Missense_Mutation;Intron,,,Intron;Missense_Mutation;Five_UTR,,,,,,,,,Silent;Missense_Mutation,Frame_Shift_Ins,,Missense_Mutation;Silent,,Frame_Shift_Del;Silent;Missene_Mutation,Frame_Shift_Del;Silent;Missene_Mutation,Missense_Mutation;Silent;Five_UTR,Frame_Shift_Del
 NCOR2,,Intron,,,Intron,,,,Frame_Shift_Ins,,,Missense_Mutation,,,Missense_Mutation,,,Intron;Missense_Mutation,,,,,,Silent,,Frame_Shift_Del,Silent,Missense_Mutation;Intron,Missense_Mutation,,,Frame_Shift_Del,Silent,Silent;Missense_Mutation,Intron
 KMT2C,,,Intron;Frame_Shift_Del;Missense_Mutation,,Intron,,,Intron,Missense_Mutation;Intron,,,Silent,,,Silent;Missense_Mutation;Nonsense_Mutation;Intron,,,Nonsense_Mutation;Intron;Missense_Mutation;Silent,,,,,,Missense_Mutation;Nonsense_Mutation;Intron,,Missense_Mutation;Intron,,Frame_Shift_Del,Missense_Mutation;Silent,,,,Splice_Region;Missense_Mutation,Missense_Mutation;Intron;Silent,Splice_Region
 CSMD3,,,Intron;Missense_Mutation;Splice_Region,,Splice_Region,,,,Intron ,,,Silent;Missense_Mutation;Intron,,,,,,Intron;Missense_Mutation;Silent;Splice_Region;Splice_Site;Nonsense_Mutation,Nonsense_Mutation;Intron,,,,,Intron;Missense_Mutation,,,,Missense_Mutation;Intron;Splice_Region,Splice_Region;Intron,Missense_Mutation,,,Intron;Silent,Missense_Mutation;Silent;Intron,Frame_Shift_Del;Intron 
 ROBO2,,Intron,Intron;Missense_Mutation;Splice_Region,,Silent,,,Intron,Silent,,,Intron,,,Intron,,,Intron;Missense_Mutation;Splice_Region,,,,,,Nonsense_Mutation;Missense_Mutation,,,,Missense_Mutation,Intron,,,,,Splice_Region,Intron
 MTOR,,Silent,Intron,,Nonsense_Mutation,,,Intron,Missense_Mutation,,,Intron,,,,,,Intron;Missense_Mutation;Nonsense_Mutation,,,,,,Intron ,,,Missense_Mutation,Intron,,,,,Silent;Missense_Mutation;Intron,Missense_Mutation,Missense_Mutation;Intron
 FAT3,,Intron,Intron;Silent;Missense_Mutation,,,,,,Silent,,,Silent;Intron,,,Missense_Mutation;Silent,,,Intron;Missense_Mutation;Splice_Region;Silent,,,,,,Missense_Mutation;Silent,,,Frame_Shift_Ins;Missense_Mutation;Silent,,,Silent,,Missense_Mutation,Silent;Intron;Missense_Mutation,Missense_Mutation,Missense_Mutation
 ERBB4,,,Intron;Silent;Missense_Mutation,,Silent;Intron,,,,Silent,,,Missense_Mutation;Splice_Region,,,Missense_Mutation;Intron,,,Intron,,,,,,Missense_Mutation;Intron,,Frame_Shift_Del,Missense_Mutation,Frame_Shift_Del,Silent,,,,Missense_Mutation,,Intron
 USP6,,Intron,Intron;Splice_Region;Missense_Mutation,,Intron,,,,,,,Intron,,,Silent;Missense_Mutation;Intron,,,Intron;Missense_Mutation;Three_UTR,,,,,,Missense_Mutation;Intron,,,,Intron,Three_UTR,Missense_Mutation,,Frame_Shift_Del,Intron,,
 MYH9,,Silent,Missense_Mutation,,Intron,,,Intron,Intron,,,Missense_Mutation;In_Frame_Del,,,Intron,,,Missense_Mutation;Intron,,,,,,,,,Silent,,,Intron;Frame_Shift_Del,,Missense_Mutation;Silent,,Intron;Missense_Mutation,
 DCC,,,Intron,,Missense_Mutation,,,Intron,,,,Frame_Shift_Del,,,Missense_Mutation;Intron,,,Intron;Missense_Mutation;Three_Flank,,,,,,Missense_Mutation;Intron,,,Intron,Silent;Nonsense_Mutation;Frame_Shift_Del,,Intron ,,,Missense_Mutation;Nonsense_Mutation;Intron,,Splice_Region
 BCL9L,,Nonsense_Mutation,,,Frame_Shift_Del,,,,Frame_Shift_Del;Intron,,,,,,,,,Silent ,,,,,,,,Frame_Shift_Del,,Missense_Mutation,Frame_Shift_Del,Missense_Mutation;Frame_Shift_Del;Silent,,Missense_Mutation,Silent;Frame_Shift_Del,Silent ,
 TCF7L2,,,Splice_Site;Intron,,Intron;Frame_Shift_Del,,,Frame_Shift_Del;Silent,Intron;Frame_Shift_Del,,,Frame_Shift_Del,,,,,,Intron;Missense_Mutation,,,,,,,,,Missense_Mutation,,,,,Frame_Shift_Del,Frame_Shift_Del;Intron,Missense_Mutation;Intron,Intron;Frame_Shift_Del
 SMARCA4,,,Intron,,,,,Frame_Shift_Del,Missense_Mutation,,,,,,Missense_Mutation,,,Missense_Mutation;Intron;Nonsense_Mutation,,,,,,,,,Silent,Intron,,,,Missense_Mutation,Intron;Missense_Mutation,Silent;Missense_Mutation;Intron,Intron
 BCL9,,,Intron,,Frame_Shift_Del;Intron,,,Frame_Shift_Ins,Splice_Region,,,,,,Missense_Mutation,,,Missense_Mutation,,,,,,Missense_Mutation,,Frame_Shift_Del,In_Frame_Ins,Missense_Mutation,Frame_Shift_Del,,,,,,
 ARID1A,,,Nonsense_Mutation,,Frame_Shift_Del;Missense_Mutation,,,Missense_Mutation;Frame_Shift_Del,Missense_Mutation,,,Frame_Shift_Del;In_Frame_Del;Missense_Mutation,,,,,,Silent;Missense_Mutation;Nonsense_Mutation,,,,,,,,,,Missense_Mutation;Silent;Frame_Shift_Del,,Frame_Shift_Ins,,,Frame_Shift_Del,Nonsense_Mutation,Intron
 RNF43,,,Intron,,,,Nonsense_Mutation,Frame_Shift_Del,,,,Missense_Mutation,,,Missense_Mutation,,,,,,,,,Nonsense_Mutation,,,,Frame_Shift_Del,,,,,Frame_Shift_Del,Frame_Shift_Del,Frame_Shift_Del;Missense_Mutation
 EPHA7,,Intron,Missense_Mutation;Intron,,,,,Missense_Mutation,Intron,,,Intron,,,Missense_Mutation;Nonsense_Mutation;Intron,,,Missense_Mutation;Intron,,,,,,Nonsense_Mutation;Missense_Mutation;Intron,,,,,Intron,,,,,Intron,
 EP300,,Silent,Splice_Region;Missense_Mutation,,Missense_Mutation,,,,Frame_Shift_Del ,,,,,,Missense_Mutation;Splice_Region;Silent,,,Missense_Mutation;Intron,,,,,,,,,Missense_Mutation,Splice_Site;Frame_Shift_Del,,Silent,,,Missense_Mutation;Intron,,
 EGFR,,Intron,Silent ,,Silent,,,,,,,,,,Missense_Mutation;Intron,,,Missense_Mutation;Intron,,,,,,Silent,,,Intron;Silent,Intron,,,,,Splice_Region,Silent,
 ATM,,,Intron;Nonsense_Mutation,,Intron,,,,,,,Silent,,,Intron,,,Intron;Missense_Mutation;Silent;Splice_Region;Nonsense_Mutation,,,,,,Silent;Missense_Mutation,,,Missense_Mutation,Intron;Frame_Shift_Del,,,,,Intron;Nonsense_Mutation,,Intron;Missense_Mutation
 ARID1B,,,,,,,,,,,,Intron,,,Silent,,,Intron;Nonsense_Mutation,,,,,,Missense_Mutation,,Splice_Site,Silent;Missense_Mutation ,Missense_Mutation,,Missense_Mutation,,,Intron;Frame_Shift_Ins;Silent,,Frame_Shift_Del
 AFDN,,,Intron,,,,,Missense_Mutation;Intron,Frame_Shift_Ins;Intron,,,Missense_Mutation,,,Intron,,,Silent;Splice_Site;Intron;Nonsense_Mutation,,,,,,Missense_Mutation;Silent,,,Silent;Missense_Mutation,,,,,,Intron,Missense_Mutation,
 FGFR1,,,Splice_Region ,,,,,Missense_Mutation,Three_UTR;Intron,,,Missense_Mutation,Intron,,,,,Splice_Region;Intron,,,,,,,,,,,,,,,Intron,Missense_Mutation,Intron
 ERBB3,,,,,Missense_Mutation,,,,,,,Intron,,,,,,Intron,,,,,,,,Intron,,Missense_Mutation,Missense_Mutation,,,Intron,,Intron,Intron
 TP53,,,Nonsense_Mutation,,,,Missense_Mutation,,,,,Intron,Frame_Shift_Del,,,Missense_Mutation,,,Nonsense_Mutation ,Nonsense_Mutation,,,,,,,,,,,,,,,
 GNAS,,Silent,Intron,,,,,,,,,,,,,,,Splice_Region;Intron,,,,,,Missense_Mutation;Intron,,,,,,,,,,,
 AKT1,,,,,,,,,,,,Missense_Mutation,,,,,,,,,,,,,,,,,Three_UTR,,,,Intron,Missense_Mutation,"), row.names = 1, header = TRUE, sep = ",", stringsAsFactors = FALSE)
> mat = as.matrix(mat)
> col <- c(Nonsense_Mutation = "red3", Missense_Mutation = "darkblue", Frame_Shift_Ins = "chartreuse", Frame_Shift_Del = "darkgreen", In_Frame_Del = "darkolivegreen2", In_Frame_Ins = "darkolivegreen", Intron = "orange", Splice_Region = "cornflowerblue", Silent = "cyan3", Splice_Site = "brown4", Three_Flank = "coral2", Three_UTR = "orchid1", Five_UTR = "darkmagenta")


#Dimensions for each type of mutations, if h is 90%, y-h would be half of (100-90)%
> alter_fun = list(
     background = function(x, y, w, h) {
         grid.rect(x, y, w-unit(2, "pt"), h-unit(2, "pt"), 
                   gp = gpar(fill = "#CCCCCC", col = NA))
     }, 
     Nonsense_Mutation = function(x, y, w, h) {
         grid.rect(x, y, w-unit(2, "pt"), h-unit(2, "pt"),
                   gp = gpar(fill = col["Nonsense"], col = NA))
     },
     Missense_Mutation = function(x, y, w, h) {
         grid.rect(x, y-h*0.05, w-unit(2, "pt"), h*0.90, 
                   gp = gpar(fill = col["Missense"], col = NA))
     },
     Frame_Shift_Ins = function(x, y, w, h) {
         grid.rect(x, y-h*0.0875, w-unit(2, "pt"), h*0.825,
                   gp = gpar(fill = col["Frameshift_Insertion"], col = NA))
     },
     Frame_Shift_Del = function(x, y, w, h) {
         grid.rect(x, y-h*0.125, w-unit(2, "pt"), h*0.75,
                   gp = gpar(fill = col["Frameshift_Deletion"], col = NA))
     },
     In_Frame_Del = function(x, y, w, h) {
         grid.rect(x, y-h*0.1625, w-unit(2, "pt"), h*0.675,
                   gp = gpar(fill = col["Frameshift_Deletion"], col = NA))
     },
     In_Frame_Ins = function(x, y, w, h) {
         grid.rect(x, y-h*0.2, w-unit(2, "pt"), h*0.6,
                   gp = gpar(fill = col["Frameshift_Deletion"], col = NA))
     },
     Intron = function(x, y, w, h) {
         grid.rect(x, y-h*0.2375, w-unit(2, "pt"), h*0.525, 
                   gp = gpar(fill = col["Intron"], col = NA))
     },
     Splice_Region = function(x, y, w, h) {
         grid.rect(x, y-h*0.275, w-unit(2, "pt"), h*0.45,
                   gp = gpar(fill = col["Splice_Region"], col = NA))
     },
     Silent = function(x, y, w, h) {
         grid.rect(x, y-h*0.3125, w-unit(2, "pt"), h*0.375,
                   gp = gpar(fill = col["Silent"], col = NA))
     },
     Splice_Site = function(x, y, w, h) {
         grid.rect(x, y-h*0.35, w-unit(2, "pt"), h*0.3, 
                   gp = gpar(fill = col["Splice_Site"], col = NA))
     },
     Three_Flank = function(x, y, w, h) {
         grid.rect(x, y-h*0.3875, w-unit(2, "pt"), h*0.225, 
                   gp = gpar(fill = col["Three_Flank"], col = NA))
     },
     Five_UTR = function(x, y, w, h) {
         grid.rect(x, y-h*0.425, w-unit(2, "pt"), h*0.15, 
                   gp = gpar(fill = col["Five_UTR"], col = NA))
     },
     Three_UTR = function(x, y, w, h) {
         grid.rect(x, y-h*0.4625, w-unit(2, "pt"), h*0.075, 
                   gp = gpar(fill = col["Three_UTR"], col = NA))
     }  
 )
#define the legends and labels
> heatmap_legend_param = list(title = "Alterations", at = c("Nonsense_Mutation", "Missense_Mutation", "Frame_Shift_Ins", "Frame_Shift_Del", "In_Frame_Ins", "In_Frame_Del", "Intron", "Splice_Region", "Silent", "Splice_Site", "Three_Flank", "Three_UTR", "Five_UTR" ), 
                             labels = c("Nonsense_Mutation", "Missense_Mutation", "Frame_Shift_Ins", "Frame_Shift_Del", "In_Frame_Ins", "In_Frame_Del", "Intron", "Splice_Region", "Silent", "Splice_Site", "Three_Flank", "Three_UTR", "Five_UTR"))

#define sample order as per column names
> sample_order <- colnames(mat)
> oncoPrint(mat, show_column_names = TRUE, column_order = sample_order,
           alter_fun = alter_fun, col = col, 
           column_title = column_title, heatmap_legend_param = heatmap_legend_param)
