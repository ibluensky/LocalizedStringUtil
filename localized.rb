require 'find'

if ARGV.count < 1
  puts "Please, Insert taget directory path."
  exit
end

path = ARGV[0]
puts "path => #{path}"

def find_localized_strings_files (path)
  if path.slice(-1,1) == "/"
    files = Dir.glob(path+'*.lproj/Localizable.strings')
  else
    files = Dir.glob(path+'/*.lproj/Localizable.strings')
  end
  
  if files.count < 1
    puts 'Bad Path !! :()'
    exit
  end
end

def trim_strings (files)
  files.each do |file_name|
    puts "target => #{file_name}"

    number_of_line = 0
    IO.foreach(file_name) do |line|
      stripped_line = line.strip!
      if stripped_line.length > 0
        splited_lines = stripped_line.split('=')
        if splited_lines.count == 2
          puts "[#{number_of_line}] " + splited_lines[0].strip!.gsub(/^\"|\"\Z/, '') + " = " + splited_lines[1].strip!.gsub(/^\"|\";\Z/, '')
        end
      end
      number_of_line += 1
    end
  end
end


find_localized_strings_files(path)