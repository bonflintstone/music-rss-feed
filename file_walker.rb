class FileWalker
  MusicFileTypes = ["mp3", "flac", "wma"]

  attr_reader :podcasts

  def initialize root
    @dir = Dir.open root
    @podcasts = []

    walk
  end

  def walk
    @dir.each do |folder|
      if folder.directory?
        @podcasts << Podcast.new(folder.basename)

        @podcasts.last.music_files << folder.glob("**/*.[mp3|wma|flac]")  
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
