Rails.application.routes.draw do
  get "/" => "tops#index"
  get "/mypage/:id" => "users#detail"
  get "/signup" => "users#signup"
  post "/create" => "users#create"
  get "/meal" => "meals#search"
  post "/meal/submit" => "meals#submit"
end
