require("httr")
library("rjson")
#https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html


getDataFromEVA <- function(endpoint){
  username <- "apisdi"
  password <- "Qwert123"
  
  base <- "https://dev.evaplus.com/EvaCloudAPI/"
  
  login_ep <- "login"
  logout_ep <- "logout"
  
  #login
  call1 <- paste(base,login_ep, sep="")
  r<-POST(call1,body=list('username' = username, 'password' = password),encode = "json",verbose())
  warn_for_status(r)
  #print(r$status_code)
  token<-content(r)$token
  
  #get data
  calldata <- paste(base,endpoint, sep="")
  data_r <- GET(calldata, add_headers(content_type_json(),Authorization = token))
  warn_for_status(data_r)
  #print(data_r$status_code)
  
  #logout
  call2 <- paste(base,logout_ep, sep="")
  logout_r <- POST(call2, add_headers(Authorization = token))
  warn_for_status(logout_r)
  #print(logout_r$status_code)
  
  return(data_r)
}

r=getDataFromEVA(endpoint = "getVehicleFleet")
http_status(r)
http_type(r)
content(r)
df_fleet<-fromJSON(content(r)) 
str(df_fleet)
df_fleet$fleet[1]
df_fleet$vehicle[2]
plot(lengths(df_fleet$vehicle))

