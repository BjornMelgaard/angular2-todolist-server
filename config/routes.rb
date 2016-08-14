Rails.application.routes.draw do
  devise_for :users,
    controllers: { sessions: 'users/sessions' },
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'register',
    }

  get 'test/members_only' =>  "test#members_only"
end
