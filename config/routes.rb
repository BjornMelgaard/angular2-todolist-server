Rails.application.routes.draw do
  scope "api", defaults: { format: :json } do

    devise_for :users,
      defaults: { format: :json },
      controllers: {
        omniauth_callbacks: 'users/omniauth_callbacks',
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      },
      # path: 'auth',
      path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'register',
      }

    resources :projects, defaults: { format: :json }

    resources :tasks, defaults: { format: :json } do
      put :done, on: :member
      put :sort, on: :member
      put :deadline, on: :member
    end

    resources :comments, defaults: { format: :json }, only: [:create, :destroy]

    resources :attachments, defaults: { format: :json }, only: [:create]
  end
end
