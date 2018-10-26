Rails.application.routes.draw do
  get "/" => "tops#index"
  get "/mypage/:id" => "users#detail"
  get "/signup" => "users#signup"
  post "/create" => "users#create"
  get "/meal/self_search" => "meals#self_search"
  get "/meal/out_search" => "meals#out_search"
  post "/meal/submit" => "meals#submit"
  get "/meal/select" => "meals#select"
end
