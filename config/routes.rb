# == Route Map
#
#                        Prefix Verb   URI Pattern                                             Controller#Action
#                          root GET    /                                                       home#index
#                  home_message GET    /home/message(.:format)                                 home#message
#              new_user_session GET    /users/sign_in(.:format)                                users/sessions#new
#                  user_session POST   /users/sign_in(.:format)                                users/sessions#create
#          destroy_user_session DELETE /users/sign_out(.:format)                               users/sessions#destroy
#             new_user_password GET    /users/password/new(.:format)                           users/passwords#new
#            edit_user_password GET    /users/password/edit(.:format)                          users/passwords#edit
#                 user_password PATCH  /users/password(.:format)                               users/passwords#update
#                               PUT    /users/password(.:format)                               users/passwords#update
#                               POST   /users/password(.:format)                               users/passwords#create
#      cancel_user_registration GET    /users/cancel(.:format)                                 users/registrations#cancel
#         new_user_registration GET    /users/sign_up(.:format)                                users/registrations#new
#        edit_user_registration GET    /users/edit(.:format)                                   users/registrations#edit
#             user_registration PATCH  /users(.:format)                                        users/registrations#update
#                               PUT    /users(.:format)                                        users/registrations#update
#                               DELETE /users(.:format)                                        users/registrations#destroy
#                               POST   /users(.:format)                                        users/registrations#create
#         new_user_confirmation GET    /users/confirmation/new(.:format)                       users/confirmations#new
#             user_confirmation GET    /users/confirmation(.:format)                           users/confirmations#show
#                               POST   /users/confirmation(.:format)                           users/confirmations#create
#               new_user_unlock GET    /users/unlock/new(.:format)                             devise/unlocks#new
#                   user_unlock GET    /users/unlock(.:format)                                 devise/unlocks#show
#                               POST   /users/unlock(.:format)                                 devise/unlocks#create
#            users_edit_details GET    /users/edit_details(.:format)                           users/registrations#edit_details
#            users_save_details PATCH  /users/save_details(.:format)                           users/registrations#save_details
#                         posts POST   /posts(.:format)                                        posts#create
#                      new_post GET    /posts/new(.:format)                                    posts#new
#                     edit_post GET    /posts/:id/edit(.:format)                               posts#edit
#                          post GET    /posts/:id(.:format)                                    posts#show
#                               PATCH  /posts/:id(.:format)                                    posts#update
#                               PUT    /posts/:id(.:format)                                    posts#update
#                               DELETE /posts/:id(.:format)                                    posts#destroy
#                          user GET    /:username(.:format)                                    users#show {:username=>/\w+/}
# rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format) action_mailbox/ingresses/postmark/inbound_emails#create

Rails.application.routes.draw do
  root "home#index"

  get "home/message"

  devise_for :users, controllers: {
    sessions: "users/sessions", # explicitly defining controllers
    passwords: "users/passwords",
    registrations: "users/registrations",
    confirmations: "users/confirmations"
  }

  # /app/views/devise/registration/edit_details.html.erb
  devise_scope :user do
    get "users/edit_details" => "users/registrations#edit_details"
    patch "users/save_details" => "users/registrations#save_details"
    # delete "users/destroy_avatar" => "users/registrations#destroy_avatar"
    # delete "users/destroy_avatar_background" => "users/registrations#destroy_avatar_background"
  end

  resources :posts, except: [:index]

  # resources :users, only: [:show]
  get ":username", to: "users#show", as: "user", constraints: { username: User::USERNAME_REGEX }
end
