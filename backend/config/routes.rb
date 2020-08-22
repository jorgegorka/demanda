# frozen_string_literal: true

Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'
  resources :attachments, only: %i[create delete]

  root to: 'graphql#execute'
end
