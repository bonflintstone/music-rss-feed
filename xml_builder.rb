require "nokogiri"

def build_xml podcast, domain
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.rss version: "2.0", "xmlns:atom": "http://www.w3.org/2005/Atom" do
      xml.channel do
        xml.title podcast.name
        xml.description podcast.name
        xml.link "#https://{domain}/#{podcast.name}.xml"
        xml.language "en"

        xml.atom:link

        podcast.music_files.each do |music_file|
          url = "#https://{domain}/media#{music_file[:path]}"

          xml.item do
            xml.title File.basename(music_file[:name], ".*")
            xml.author "bonflintstone@gmail.com"
            xml.pubDate Time.now.rfc2822
            xml.link url
            xml.guid "BonflintstoneMusicPodcast#{music_file[:path].parameterize}"
            xml.description "#{podcast.name} #{music_file[:name]}"
            xml.enclosure url: url, length: music_file[:size], type: "audio/mp3"
          end
        end
      end
    end
  end
  builder.to_xml
end
