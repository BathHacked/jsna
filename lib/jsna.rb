require 'open-uri'

module BathHacked
  class JSNA < Sinatra::Base

    configure do |app|
      set :views, settings.root + '/../views'
      set :updates, "http://www.bathnes.gov.uk/services/your-council-and-democracy/local-research-and-statistics/wiki/jsna-updates"
      set :index, "http://www.bathnes.gov.uk/services/your-council-and-democracy/local-research-and-statistics/wiki/joint-strategic-needs-z"
    end

    get "/rss" do
      @items = fetch_updates
      builder :rss
    end

    get "/data" do
      items = fetch_updates
      content_type "application/json"
      items.to_json
    end

    not_found do
      'Not Found'
    end

    def fetch_updates
      items = []
      begin
        doc = Nokogiri::HTML( open( settings.updates ) )
        rows = doc.search("table tr")[1..-1]
        rows.each do |row|
          description = row.search("p").text
          date = row.search("td")[1].text
          row.search("td[3] a").each do |title|
            items << {
                title: title.text,
                url: title["href"],
                description: description,
                date: date
            }
          end
        end
      rescue => e
        puts e
      end
      items
    end

  end
end