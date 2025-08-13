Rails.application.routes.draw do
  resources :quizzes do    
    resources :questions, only: [:new, :destroy] do
      resources :answers, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  get 'quizzes/:share_token/public', to: 'quizzes#public_show', as: :public_quiz
  post 'quizzes/:share_token/submit_answer', to: 'answers#public_create', as: :public_quiz_answers

  # get 'quizzes/:share_token/thank_you', to: 'quizzes#thank_you', as: 'thank_you_quiz'
  
  resources :answers, only: [:create]

  devise_for :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "quizzes#index"

  # root to: redirect('/quizzes')
end
