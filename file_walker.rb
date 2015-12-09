class FileWalker
  MusicFileTypes = ["flac", "mp3", "wma", "Mp3", "MP3", "m4a"]

  attr_reader :podcasts

  def initialize root
    @root = root + "/media"
    @podcasts = []
  end

  def walk
    Dir.foreach(@root) do |name|
      if name == "." || name == ".." || File.file?("#{@root}/#{name}")
        next
      end

      @podcasts << Podcast.new(name)

      Dir.glob("#{@root}/#{name}/**/*").each do |file|
        unless File.file? file
          next
        end

        if MusicFileTypes.include? file.split(".").last
          @podcasts.last.music_files << {path: file.split(@root).last, size: File.stat(file).size, name: File.basename(file, ".*")}
        end
      end
    end

    @podcasts
  end

end

class Podcast
  attr_reader :name, :music_files

  def initialize name
    @name = name
    @music_files = []
  end
end 
