# frozen_string_literal: true

module Hotebase
  class Routes < Hanami::Routes
    # Add your  routes here. See https://guides.hanamirb.org/routing/overview/ for details.
    root to: 'home.index'
    get '/api/v1/hotels', to: 'hotels.index'
  end
end
