Rails.application.routes.draw do
  get '/list', to: 'currencies#list'
end
