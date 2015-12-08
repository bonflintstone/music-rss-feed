require "nokogiri"

def build_xml podcast
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.rss version: "2.0" do
      xml.channel do
        xml.title podcast.name
        xml.author "Bonflintstone"
        xml.description podcast.name
        xml.link "84.189.43.59"
        xml.language "en"

        podcast.music_files.each do |music_file|
          url = "84.189.43.59/media" + File.absolute_path(music_file).split("/media/frederik/Volume/Music/")[1]

          xml.item do
            xml.title File.basename(music_file, ".*")
            xml.author "Bonflintstone"
            xml.pubDate Time.now
            xml.link url
            xml.guid "Bonflintstone Music Podcast #{File.absolute_path(music_file)}"
            xml.description "#{podcast.name} #{File.basename(music_file, ".*")}"
            xml.enclosure url: url, length: File.stat(music_file).size, type: "audio/mp3"
          end
        end
      end
    end
  end
  builder.to_xml
end
