xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "JSNA Updated"
    xml.description "B&NES JSNA wiki updates"
    xml.link "http://www.bathnes.gov.uk/services/your-council-and-democracy/local-research-and-statistics/wiki/jsna-updates"

    @items.each do |post|
      xml.item do
        xml.title post[:title]
        xml.link "http://www.bathnes.gov.uk#{post[:url]}"
        xml.description post[:description]
        xml.pubDate Time.parse(post[:date]).rfc822()
        xml.guid "http://www.bathnes.gov.uk#{post[:url]}"
      end
    end
  end
end
