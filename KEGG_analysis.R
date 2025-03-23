library(clusterProfiler)
library(org.Hs.eg.db)

# 读取输入数据文件
file_path <- "C:/Users/Lamarck/Desktop/UP_genes_ENSEMBL_ENTREZID.csv"
data <- read.csv(file_path, header = TRUE)

# 提取基因列表（ENTREZID）
gene <- data$ENTREZID

# KEGG 富集分析
kegg_result <- enrichKEGG(
  gene = gene,
  organism = "hsa",
  pvalueCutoff = 1,
  qvalueCutoff = 1
)

# 结果转为数据框
kegg_frame <- as.data.frame(kegg_result)
rownames(kegg_frame) <- 1:nrow(kegg_frame)

# 添加排序变量（用于后续可视化）
kegg_frame$order <- factor(rev(seq_len(nrow(kegg_frame))), labels = rev(kegg_frame$Description))

# 保存结果
output_path <- "C:/Users/Lamarck/Desktop/kegg_frame.csv"
write.csv(kegg_frame, file = output_path, row.names = FALSE)
