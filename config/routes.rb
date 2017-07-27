Rails.application.routes.draw do
  root to: "lines#index"

  resources :lines, only: [ :index, :show ]
end
