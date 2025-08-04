namespace :hotel_populate do
  desc "Crawl hotels from the API and store them in the database"
  task crawl: :environment do
    require 'hotebase/crawler/hotel'

    crawler = Hotebase::Crawler::Hotel.new
    crawler.crawl_hotels
  end

  desc "Delete all hotels from the database"
  task delete_all: :environment do
    require 'hotebase/relations/hotel'

    Hotebase::Relations::Hotel.delete_all
  end
end
