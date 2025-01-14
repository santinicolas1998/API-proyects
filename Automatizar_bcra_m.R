library(taskscheduleR)
library(lubridate)
library(httr)
library(jsonlite)
library(openxlsx)

setwd("C:\\Users\\20416597295\\Documents\\Santiago\\R")

# Credenciales
username <- ""****""
password <- "****"
token <- "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3Njc3MTcwMTIsInR5cGUiOiJleHRlcm5hbCIsInVzZXIiOiJydWl6c2FudGlhZ29uaWNvbGFzN0BnbWFpbC5jb20ifQ.ZjyboyfZos7cj3WPO8vIc6A72E-e4BwtGXwa15GYaqYD5hpBwuQGUMELvFAlM5uHW3sXdsftRfKaiZIq-PBS_g"

# URL del endpoint de las estadísticas BCRA
url <- "https://api.bcra.gob.ar/estadisticas/v3.0/monetarias"

# Encabezados con el token de autorización
headers <- add_headers(Authorization = paste("BEARER", token))

# Solicitud GET
response <- GET(url, headers)

# Verificar la respuesta
if (status_code(response) == 200) {
  # Procesar la respuesta JSON
  data <- fromJSON(content(response, "text", encoding = "UTF-8"))
  df <- data$results
  
  # Convertir los resultados en un dataframe
  df2 <- as.data.frame(df)
  
  # Ruta a la carpeta
  folder_path <- "C:\\Users\\20416597295\\Documents\\Santiago\\R\\Datos_automatizados_bcra_monetarios"
  
  # Crear la carpeta si no existe
  if (!dir.exists(folder_path)) {
    dir.create(folder_path)
  }
  
  # Obtener la fecha actual en formato "YYYY-MM-DD_HH-MM-SS"
  fecha_actual <- format(Sys.time(), "%Y-%m-%d_%H-%M-%S")
  
  # Definir la ruta completa del archivo Excel
  file_path <- file.path(folder_path, paste0("datos_monetarios_bcra_", fecha_actual, ".xlsx"))
  
  # Guardar el dataframe como un archivo Excel en la carpeta especificada
  write.xlsx(df2, file_path)
  
  print(paste("Archivo guardado como datos_monetarios_bcra_", fecha_actual, ".xlsx", sep = ""))
} else {
  # Manejar errores
  print(paste("Error:", status_code(response), "-", content(response, "text", encoding = "UTF-8")))
}

