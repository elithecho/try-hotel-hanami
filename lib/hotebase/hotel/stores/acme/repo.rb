require_relative '../api'

module Hotebase
  module Hotel
    module Stores
      module Acme
        class Repo < ::Hotebase::Hotel::Stores::Api
          BASE_URL = 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme'
        end
      end
    end
  end
end
