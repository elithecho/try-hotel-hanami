module Hotebase
  module Hotel
    module Stores
      module Acme
        module Entity
          def self.build(data)
            {
              id: data['Id']
            }
          end
        end
      end
    end
  end
end
