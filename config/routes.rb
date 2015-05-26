Rails.application.routes.draw do
  root 'sites#home'

  devise_for :users
 
  get 'sites/home', to: 'sites#signout'
  get '/budgets/:id/barchart', to: 'budgets#bar_chart', as: "budgetchart"
  get '/months/:id/piechart', to: 'months#pie_chart', as: "monthchart"

  resources :users, only: [:show, :edit, :update, :destroy], shallow: true do
    # get '/profile', on: :member, to: 'users#show'
    resources :budgets, only: [:show, :edit, :update] do
      resources :months, only: [:new, :create, :show, :edit, :update, :destroy] do
        resources :categories, only: [:create, :update, :destroy]
      end
    end
  end
  
end


=begin

 Prefix Verb   URI Pattern                              Controller#Action
                    root GET    /                                        sites#home
              sites_home GET    /sites/home(.:format)                    sites#home
        month_categories POST   /months/:month_id/categories(.:format)   categories#create
                category PATCH  /categories/:id(.:format)                categories#update
                         PUT    /categories/:id(.:format)                categories#update
                         DELETE /categories/:id(.:format)                categories#destroy
           budget_months POST   /budgets/:budget_id/months(.:format)     months#create
        new_budget_month GET    /budgets/:budget_id/months/new(.:format) months#new
              edit_month GET    /months/:id/edit(.:format)               months#edit
                   month GET    /months/:id(.:format)                    months#show
                         PATCH  /months/:id(.:format)                    months#update
                         PUT    /months/:id(.:format)                    months#update
                         DELETE /months/:id(.:format)                    months#destroy
             edit_budget GET    /budgets/:id/edit(.:format)              budgets#edit
                  budget GET    /budgets/:id(.:format)                   budgets#show
                         PATCH  /budgets/:id(.:format)                   budgets#update
                         PUT    /budgets/:id(.:format)                   budgets#update
               edit_user GET    /users/:id/edit(.:format)                users#edit
                    user GET    /users/:id(.:format)                     users#show
                         PATCH  /users/:id(.:format)                     users#update
                         PUT    /users/:id(.:format)                     users#update
                         DELETE /users/:id(.:format)                     users#destroy
        new_user_session GET    /users/sign_in(.:format)                 devise/sessions#new
            user_session POST   /users/sign_in(.:format)                 devise/sessions#create
    destroy_user_session DELETE /users/sign_out(.:format)                devise/sessions#destroy
           user_password POST   /users/password(.:format)                devise/passwords#create
       new_user_password GET    /users/password/new(.:format)            devise/passwords#new
      edit_user_password GET    /users/password/edit(.:format)           devise/passwords#edit
                         PATCH  /users/password(.:format)                devise/passwords#update
                         PUT    /users/password(.:format)                devise/passwords#update
cancel_user_registration GET    /users/cancel(.:format)                  devise/registrations#cancel
       user_registration POST   /users(.:format)                         devise/registrations#create
   new_user_registration GET    /users/sign_up(.:format)                 devise/registrations#new
  edit_user_registration GET    /users/edit(.:format)                    devise/registrations#edit
                         PATCH  /users(.:format)                         devise/registrations#update
                         PUT    /users(.:format)                         devise/registrations#update
                         DELETE /users(.:format)                         devise/registrations#destroy


=end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

