require 'sidekiq/web'
require 'sidekiq-scheduler/web'
require 'sidekiq_unique_jobs/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # SideKiq
  Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
  authenticate :admin_user, lambda{ |u| u.present? } do
    mount Sidekiq::Web => '/admin/sidekiq'
  end
end
