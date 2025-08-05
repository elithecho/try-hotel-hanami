namespace :hotel_fill do
  desc "Crawl hotels from the API and store them in the database"
  task request: :environment do

    Hotebase::Hotel::Warehouse.new.fetch
  end
end
