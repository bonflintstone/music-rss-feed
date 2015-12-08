def build_xml podcast
  Nokogiri::XML::Builder.new do |xml|
    xml.rss version: "2.0" do
      xml.channel do
        xml.title podcast.name
        xml.author "Bonflintstone"
        xml.description podcast.name
        xml.link "84.189.43.59"
        xml.language "en"

        podcast.music_files.each do |music_file|
          url = "84.189.43.59/" + music_file.absolue_path.split("/media/frederik/Volume/Music/")[1]

          xml.item do
            xml.title music_file.get_name
            xml.author "Bonflintstone"
            xml.pubDate Time.now
            xml.link url
            xml.guid "Bonflintstone Music Podcast #{music_file.absolue_path}"
            xml.description "#{podcast.name} #{music_file.basename}"
            xml.enclosure url: url, length: music_file.size, type: "audio/mp3"
          end
        end
      end
    end
  end
end
