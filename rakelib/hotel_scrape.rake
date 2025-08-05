namespace :hotel_populate do
  desc "Crawl hotels from the API and store them in the database"
  task crawl: :environment do
    require 'hotebase/crawler/hotel'

    crawler = Hotebase::Crawler::Hotel.new
    crawler.crawl_hotels
  end
end
