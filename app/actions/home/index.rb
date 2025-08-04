# frozen_string_literal: true

module Hotebase
  module Actions
    module Home
      class Index < Hotebase::Action
        def handle(request, response)

          response.format = :json
          response.body = {
            ok: true
          }.to_json
        end
      end
    end
  end
end

