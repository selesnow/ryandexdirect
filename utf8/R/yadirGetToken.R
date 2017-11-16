yadirGetToken <-
function(){
  browseURL("https://oauth.yandex.ru/authorize?response_type=token&client_id=365a2d0a675c462d90ac145d4f5948cc")
  token <- readline(prompt = "Enter your token: ")
  return(token)
}
