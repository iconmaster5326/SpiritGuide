require "spirit_guide"

project_dir = ARGV[0]

# setup metadata
project_meta_file = "#{project_dir}/Game.rvproj2"
unless File.exist?(project_meta_file)
  File.open(project_meta_file, "w:utf-8") do |file|
    puts "Setting up #{project_meta_file}..."
    file.write("RPGVXAce 1.02")
  end
end

# setup maps
map_index = 1
map_info = {}

Dir.glob("#{project_dir}/Data/Map*.rvdata2").each do |map_filename|
  map_info[map_index.to_s] = {
    "json_class" => "RPG::MapInfo",
    "@scroll_x" => 0,
    "@name" => File.basename(map_filename, ".rvdata2"),
    "@expanded" => false,
    "@order" => map_index,
    "@scroll_y" => 0,
    "@parent_id" => 0
  }
  map_index += 1
end

maps_outfile = "#{project_dir}/Data/MapInfos.rvdata2"
File.open(maps_outfile, "wb") do |file|
  puts "Writing map info to #{maps_outfile}..."
  file.write(Marshal.dump(SpiritGuide::RGSS3.json_to_rvdata2(map_info, maps_outfile)))
end

# setup graphics
Dir.glob("#{project_dir}/Graphics/**/*.rvdata2").each do |filename|
  File.open(filename, "rb") do |infile|
    File.open("#{File.dirname(filename)}/#{File.basename(filename, ".rvdata2")}.png", "wb") do |outfile|
      puts "Converting #{filename} to PNG..."
      outfile.write(SpiritGuide::Graphics.rvdata2_to_png(infile.read))
    end
  end
end

puts "Project setup successful! You may now open #{project_meta_file} in RPG Maker VX Ace."
