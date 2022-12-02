Rails.application.routes.draw do
  root to: "pages#home"

  resources :spots, only: %i[index show new] do
    resources :pages, only: %i[index new]
  end
end
