Rails.application.routes.draw do
  devise_for :users,
    defaults: { format: :json },
    controllers: {
      # omniauth_callbacks: 'users/omniauth_callbacks',
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    },
    path: 'auth',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'register',
    }

  get 'test/members_only' =>  "test#members_only"
end
