library(AnnotationDbi)
library(org.Hs.eg.db)  # 加载人类基因注释包
library(clusterProfiler)  # 用于基因集富集分析（如 KEGG 和 GO 分析）
library(dplyr)  # 提供数据操作功能
library(ggplot2)  # 用于数据可视化
library(biomaRt)  # 提供与生物信息学数据库的交互

# 读取输入数据文件
file_path <- "C:/Users/Lamarck/Desktop/UP_genes_ENSEMBL_ENTREZID.csv"
data <- read.csv(file_path, header = TRUE)

# 提取基因列表
gene <- data$ENTREZID

# 进行 KEGG 富集分析（未筛选p值和q值  后续手动筛选）
kegg_result <- enrichKEGG(
  gene = gene,
  keyType = "kegg",
  organism = "human",
  qvalueCutoff = 1,
  pvalueCutoff = 1
)

# 将分析结果转为数据框
kegg_frame <- as.data.frame(kegg_result)
rownames(kegg_frame) <- 1:nrow(kegg_frame)

# 添加排序变量
kegg_frame$order <- factor(rev(as.integer(rownames(kegg_frame))), labels = rev(kegg_frame$Description))

# 将结果保存为 CSV 文件
output_path <- "C:/Users/Lamarck/Desktop/kegg_frame.csv"
write.csv(kegg_frame, file = output_path, row.names = FALSE)


