require "active_support"
require "active_support/core_ext"

if ARGV.length != 1
  puts "Wrong Number of parameters, expected 1, got #{ARGV.length}"
  exit
end

path = ARGV.first.dup
unless path[-1] == "/"
  path << "/"
end

files = Dir.glob("#{path}**/**").reverse #depth first

files.each do |file|
  puts "At file #{file}"

  name = File.basename(file, File.extname(file))
  
  new_name = name.parameterize

  if new_name != name
    begin
      if new_name == ""
        raise "Name can not be ''"
      end
      if File.directory? file
        new_full_path = file[0 ... - File.basename(file).length] + new_name
        FileUtils.mv file, new_full_path
      else
        new_full_path = file[0 ... - File.basename(file).length] + new_name + File.extname(file)
        File.rename file, new_full_path
      end
    rescue
      puts "\tFailed to rename File\t'#{file}'\tto\t'#{new_full_path}'"
      puts "\tWith Exception:\t#{$!}"
      puts "\t[CTRL] + [C] to abort"
      puts "\t[Enter] to skip File"
      print "\tEnter new name manually:\t"
      new_name = STDIN.gets.chomp
      if new_name != ""
        retry
      end
    end
  end

end

puts "finished"
