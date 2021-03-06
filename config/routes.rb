Rails.application.routes.draw do
  get "/" => "tops#index"
  get "/mypage/:id" => "users#detail"
  get "/signup" => "users#signup"
  post "/create" => "users#create"
  get "/meal/self_search" => "meals#self_search"
  get "/meal/out_search" => "meals#out_search"
  post "/meal/out_submit" => "meals#out_submit"
  post "/meal/in_submit" => "meals#in_submit"
  get "/meal/select" => "meals#select"
  post "/meal/confirm" => "meals#confirm"
  get "/meal/menu/detail" => "meals#recipe_detail"
  post "/meal/in_confirm" => "meals#in_confirm"
  post "/meal/compare" => "meals#compare"
  post "/meal/create" => "meals#create"
  get "/meal/history" => "meals#index"
  post "meals/:id/destroy" => "meals#destroy"
end
