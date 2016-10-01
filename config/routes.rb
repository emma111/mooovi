TechReviewSite::Application.routes.draw do
  devise_for :users
  resources :products, only: :show do #products_controllerに対してのresourcesメソッド
    resources :reviews, only: [:new, :create]
    #reviews_controllerに対してのresourcesメソッド
     collection do
      get 'search'
    end
  end
  root 'products#index'

end