# frozen_string_literal: true

Rails.application.routes.draw do
  apipie
  scope :api, defaults: { format: :json } do
    scope '(:version)' do
      resources :images, only: %i[create show]
    end
  end
  get '*path', to: 'errors#index', via: :all
end
