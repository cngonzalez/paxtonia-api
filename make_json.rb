require 'json'

def file_maker
  files = Dir['./talk/*']
  temp_hash = files.each_with_object({}) do |file, hash|
    filename = file.split("/")[2].chomp(".txt")
    if filename != "information"
      hash[filename] = []
      File.foreach(file) {|l| hash[filename] << l.chomp("\n")}
    else 
      hash[filename] = {}
      File.foreach(file) do |l|
        parts = l.split(" => ")
        hash[filename][parts[0]] = parts[1].chomp("\n")
      end
    end
  end
  File.open('talk.json', 'w') do |f|
    f.write(temp_hash.to_json)
  end
end

file_maker
