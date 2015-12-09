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

files = Dir.glob "#{path}**/**"

files.each do |file|
  puts "At file #{file}"

  name = File.basename(file, File.extname(file))
  
  new_name = name.parameterize

  if new_name != name
    if File.directory? file
      FileUtils.mv file, file[0 ... - File.basename(file).length] + new_name + File.extname(file)
    else
      File.rename(file, file[0 ... - File.basename(file).length] + new_name + File.extname(file))
    end
  end

end

puts "finished"
