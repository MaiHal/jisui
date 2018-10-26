Rails.application.routes.draw do
  get "/" => "tops#index"
  get "/mypage/:id" => "users#detail"
end
