Rails.application.routes.draw do
  root to: "pages#home"

  resources :spots, only: %i[index show]
end
