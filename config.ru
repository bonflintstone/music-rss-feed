require "nokogiri"
require "./file_walker"
require "./xml_builder"

MediaDirectory = ""

podcasts = FileWalker.new(MediaDirectory).walk

map "/media" do
  run Rack::File.new MediaDirectory
end

def get_response env
  actual = podcasts.filter { |podcast| podcast.name == env["PATH_INFO"] }

  if actual.length == 1
    actual = actual.first

    [200, { "ContentType" => "text/xml" } ,[build_xml(podcast)]]
  else
    [404, nil, nil]
  end
end

run -> (env) { get_response env }
