# coding: utf-8
require_relative 'rgss3'

files = []

if ARGV.empty?
  files = Dir.glob('Data/**/*.rvdata2')
else
  files = ARGV.flat_map { |filename|
    Dir.exist?(filename) ? Dir.glob(filename+'/**/*.rvdata2') : [filename]
  }
end

files.each do |filename|
  puts "Converting #{filename} to JSON..."
  File.open(filename, 'rb') do |file|
    json = rvdata2_to_json(Marshal.load(file.read))

    File.open(File.dirname(filename)+"/"+File.basename(filename,'.rvdata2')+'.json', 'w:utf-8') do |file|
      file.write(json.to_json)
    end
  rescue => ex
    puts "warning: got bad file #{filename}: #{ex}"
  end
end
