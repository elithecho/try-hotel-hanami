# frozen_string_literal: true

module Hotebase
  module Relations
    class Hotels < Hotebase::DB::Relation
      schema :hotels, infer: true
    end
  end
end
