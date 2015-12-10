require "nokogiri"

def build_index podcasts, domain
  builder = Nokogiri::HTML::Builder.new do |doc|
    doc.html do
      doc.body do
        podcasts.each do |podcast|
          doc.a href: "#https://{domain}/#{podcast.name}.xml"
            doc.text podcast.name
          end
        end
      end
    end
  end
  return builder.to_html
end
