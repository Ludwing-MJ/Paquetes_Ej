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


# Carga de datos
altura_pino <- read_excel("datos_arboles.xlsx")

# Análisis de varianza y comparaciones múltiples
modelo_anova <- aov(altura_ft ~ tratamiento, data = altura_pino)
summary (modelo_anova)
comparacion_tukey <- HSD.test(modelo_anova, "tratamiento")
comparacion_tukey$groups
# Visualización de resultados
ggplot(altura_pino, aes(x = tratamiento, y = altura_ft, fill = tratamiento)) +
  geom_boxplot() +
  labs(title = "Altura por Tratamiento",
       x = "Tratamiento",
       y = "Altura en pies") +
  theme_minimal() +
  theme(legend.position = "none")

# Exportación de resultados
write_xlsx(comparacion_tukey$groups, "resultados_tukey.xlsx")
ggsave("ggplot_pino.png")