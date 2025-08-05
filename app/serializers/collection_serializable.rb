module Hotebase
  module Serializers
    module CollectionSerializable
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def serialize_collection(collection)
          collection.map do |item|
            new(item).serialize
          end.to_json
        end
      end
    end
  end
end
