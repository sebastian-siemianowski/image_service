Rails.application.routes.draw do
  apipie
  scope :api, defaults: { format: :json } do
    scope '(:version)' do
      resources :auxiliary_data, only: %i[show]
      resources :card_definitions, only: %i[index]
      resources :card_definitions_schema, only: %i[index]
      resources :cv_lists, only: %i[show]
      resources :events, only: %i[create]
      resources :generic_searches, only: %i[show]
      resources :search_forms, only: %i[show]
      resource :generic_search_results, only: %i[create]
      resource :federated_searches, only: %i[create]
      resources :got_it_notes, only: %i[show]
      resources :terms_and_conditions, only: %i[index]
      resource :token, only: %i[create]
      resource :user_preferences, only: %i[show update]
      resources :workflows, only: %i[index]
      resource :yellow_pages, only: %i[show]
      resource :user_details, only: %i[show]
      resources :risk_assessments, only: %i[show]
      resources :production_documents, only: %i[create]
      resources :data_source_lookups, only: %i[index]
      resources :unique_references, only: %i[create]
      resources :pqt_grid_descriptors, only: %i[show]
      resources :link_types, only: %i[index]
      resource :unit_lookup_searches, only: %i[create]
      resources :attachments, only: %i[create]
      resources :employee_lookups, only: %i[show]
      resources :gazetteer_searches, only: %i[create]
      resources :queue_messages, only: %i[create]
      resources :rails_server_statuses, only: %i[index]
      resource :logs, only: %i[update show]
    end
  end
  get '*path', to: 'errors#index', via: :all
end
