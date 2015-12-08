require "nokogiri"

builder = Nokogiri::XML::Builder.new do |xml|
  xml.rss version: "2.0" do
    xml.channel do
      xml.title "Nero"
      xml.author "Bonflintstone"
      xml.description "Nero"
      xml.link "84.189.43.59"
      xml.language "en"

      xml.item do
        xml.title "Item 1"
        xml.author "Bonflintstone"
        xml.pubDate Time.now
        xml.link "84.189.43.59/media/innocence.flac"
        xml.guid "1"
        xml.description "Nero - Innocence"
        xml.enclosure url: "84.189.43.59/media/innocence.flac", length: "37868742", type: "audio/mp3"
      end

      xml.item do
        xml.title "All Sold Out"
        xml.author "Bonflintstone"
        xml.pubDate Time.now
        xml.link "84.189.43.59/media/sold.mp3"
        xml.guid "1afd"
        xml.description "Nero - Innocencasdfe"
        xml.enclosure url: "84.189.43.59/media/sold.mp3", length: "2382972", type: "audio/mp3"
      end
    end
  end
end

#use Rack::Static, urls: ["/media"], root: "/media/frederik/Volume/Music"

map "/media" do
  run Rack::File.new "/media/frederik/Volume/Music"
end

run -> (env) { [200, { "ContentType" => "text/xml" } , [builder.to_xml]] }
