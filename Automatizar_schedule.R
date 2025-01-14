library(taskscheduleR)
fichero <- "C:\\Users\\20416597295\\Documents\\Santiago\\R\\Automatizar_bcra_m.R"

start_date <- format(Sys.time(), "%d-%m-%Y")  # Date format in "dd/mm/yyyy"
start_time <- format(Sys.time(), "%H:%M:%S")  # Time format in "HH:MM:SS"

taskscheduler_create(
  taskname = "Automatizar_bcra_m.R", 
  rscript = fichero,
  schedule = "MINUTE",
  starttime = start_time, 
  startdate = start_date
)

#taskscheduler_stop(taskname = "Automatizar_bcra_m")
#taskscheduler_delete(taskname = "Automatizar_bcra_m.R")


