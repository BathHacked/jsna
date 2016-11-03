xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "B&NES JSNA Updates"
    xml.description "A feed of updates from the B&NES JSNA website. A one stop shop for information, facts and figures about Bath and North East Somerset."
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
