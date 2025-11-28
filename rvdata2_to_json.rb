require "spirit_guide"

files = if ARGV.empty?
          Dir.glob("Data/**/*.rvdata2")
        else
          ARGV.flat_map do |filename|
            Dir.exist?(filename) ? Dir.glob("#{filename}/**/*.rvdata2") : [filename]
          end
        end

files.each do |filename|
  puts "Converting #{filename} to JSON..."
  File.open(filename, "rb") do |file|
    json = SpiritGuide::RGSS3.rvdata2_to_json(Marshal.load(file.read))

    File.open("#{File.dirname(filename)}/#{File.basename(filename, ".rvdata2")}.json", "w:utf-8") do |file|
      file.write(json.to_json)
    end
  rescue StandardError => e
    puts "warning: got bad file #{filename}: #{e}"
  end
end
