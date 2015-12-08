require "pry"
require "rack"
require "rack/server"
require "./file_walker"
require "./xml_builder"

class Rss
  attr_reader :media_directory

  def initialize
    @media_directory = "/media/frederik/Volume/Music"
    @podcasts = FileWalker.new(@media_directory).walk
  end

  def response env
    podcast = @podcasts.select { |podcast| podcast.name == env["PATH_INFO"][1..-1] }

    if podcast.length == 1
      podcast = podcast.first

      return [200, { "ContentType" => "text/xml" } ,[build_xml(podcast)]]
    else
      return [404, { "ContentType" => "text/plain" } , ["Not found"]]
    end
  end
end

rss = Rss.new

use Rack::Static, urls: ["/media"], root: rss.media_directory

run ->(env) { rss.response env }
