require "rack"
require "rack/server"
require "rack/auth/abstract/handler"
require "rack/auth/abstract/request"

require "./secret"
require "./index_builder"
require "./file_walker"
require "./xml_builder"

class Rss
  attr_reader :media_directory

  def initialize
    @media_directory = "/media/Volume"
    @domain = "79.248.192.83"
    @podcasts = FileWalker.new(@media_directory).walk
  end

  def response env
    if ["/", "/index", "/index.html"].include? env["PATH_INFO"]
      return [200, { "ContentType" => "text/html" } ,[build_index(@podcasts, @domain)]]
    end

    podcast = @podcasts.select { |podcast| "/" + podcast.name + ".xml" == env["PATH_INFO"] }

    if podcast.length == 1
      podcast = podcast.first

      return [200, { "ContentType" => "text/xml" } ,[build_xml(podcast, @domain, "#{_username}:#{_password}@")]]
    else
      return [404, { "ContentType" => "text/plain" } , ["Not found"]]
    end
  end
end

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == [_username, _password]
end

rss = Rss.new

use Rack::Static, urls: ["/media"], root: rss.media_directory

run ->(env) { rss.response env }
