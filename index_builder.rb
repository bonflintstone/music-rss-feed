require "nokogiri"

def build_index(podcasts, domain, credentials_string)
  builder = Nokogiri::HTML::Builder.new do |doc|
    doc.html do
      doc.body do
        podcasts.each do |podcast|
          doc.p do
            doc.a href: "http://#{credentials_string}#{domain}/#{podcast.name}.xml" do
              doc.text podcast.name
            end
          end
        end
      end
    end
  end
  return builder.to_html
end
