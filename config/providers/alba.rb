Hanami.app.register_provider :alba do
  prepare do
    require "alba"
    require "oj"
  end

  start do
    Alba.backend = :oj
  end
end
