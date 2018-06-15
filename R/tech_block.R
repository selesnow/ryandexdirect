# тех функция для авторизации в других функциях
tech_auth <-  function(login = NULL, token = NULL, AgencyAccount = NULL, TokenPath = NULL) {

  # Если задан токен то пропускаем проверку
  if (! is.null(token) ) {
    # Определяем класс объекта содержащего токен
    if(class(token) == "list") {
      Token <- token$access_token 
    } else {
      Token <- token
    }
  # Если токен не задан то необходимо его получить
  } else {
    # определяем тип аккаунта, агентский или клиентский
    load_login <- ifelse(is.null(AgencyAccount) || is.na(AgencyAccount), login, AgencyAccount)
    # загружаем токен
    Token <- yadirAuth(Login = load_login, TokenPath = TokenPath, NewUser = FALSE)$access_token
  }
  
  # возвразаем токен
  return(Token)
}