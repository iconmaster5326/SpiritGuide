require "spirit_guide"

project_dir = ARGV[0]

# setup graphics
Dir.glob("#{project_dir}/Graphics/**/*.png").each do |filename|
  File.open(filename, "rb") do |infile|
    File.open("#{File.dirname(filename)}/#{File.basename(filename, ".png")}.rvdata2", "wb") do |outfile|
      puts "Converting #{filename} to RVDATA2..."
      outfile.write(SpiritGuide::Graphics.png_to_rvdata2(infile.read))
    end
  end
end

puts "Project build successful! The game should now reflect your changes."
