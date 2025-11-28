require "spirit_guide"

files = if ARGV.empty?
          Dir.glob("Data/**/*.json")
        else
          ARGV.flat_map do |filename|
            Dir.exist?(filename) ? Dir.glob("#{filename}/**/*.json") : [filename]
          end
        end

files.each do |filename|
  puts "Converting #{filename} to RVDATA2..."
  File.open(filename, "r:utf-8") do |file|
    text = ""
    file.each do |line|
      text += line
    end

    rvdata2 = SpiritGuide::RGSS3.json_to_rvdata2(JSON.parse(text), filename)

    File.open("#{File.dirname(filename)}/#{File.basename(filename, ".json")}.rvdata2", "wb") do |file|
      file.write(Marshal.dump(rvdata2))
    end
  rescue StandardError => e
    puts "warning: got bad file #{filename}: #{e}"
  end
end
