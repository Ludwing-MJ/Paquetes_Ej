# Ejemplo práctico uso de paquetes
# NOTA: Antes de trabajar hay que crear y guardar un nuevo script.
# Instalación y carga de paquetes esenciales

## Incluye ggplot2, dplyr, tidyr
if (!require("tidyverse")) install.packages("tidyverse")
## Diseños experimentales agrícolas
if (!require("agricolae")) install.packages("agricolae")
## Importación de archivos Excel
if (!require("readxl")) install.packages("readxl")    
## Exportación a Excel
if (!require("writexl")) install.packages("writexl")    
## Establecer directorio de trabajo automaticamente
if (!require("rstudioapi")) install.packages("rstudioapi")

# Importar datos desde un archivo Excel
altura_pino <- read_excel("datos_arboles.xlsx")

# Análisis de varianza
modelo_anova <- aov(altura_ft ~ tratamiento, data = altura_pino)
summary(modelo_anova)

# Prueba de Tukey
comparacion_tukey <- HSD.test(modelo_anova, "tratamiento")
print(comparacion_tukey)

# Visualización de resultados
ggplot(altura_pino, aes(x = tratamiento, y = altura_ft, fill = tratamiento)) +
  geom_boxplot() +
  labs(title = "Altura por Tratamiento",
       x = "Tratamiento",
       y = "Altura en pies")+
  theme_minimal()+ # Establece el tema del gráfico 
  theme(legend.position = "none")  # Remueve la leyenda redundante

# Exportar resultados a Excel
write_xlsx(comparacion_tukey$groups, "resultados_tukey.xlsx", col_names = T, format_headers = T, use_zip64 = F)

# Exportar gráficos
ggsave("ggplot_pino.png")
