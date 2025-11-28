# coding: utf-8
require_relative 'rgss3'

files = []

if ARGV.empty?
  files = Dir.glob('Data/**/*.json')
else
  files = ARGV.flat_map { |filename|
    Dir.exist?(filename) ? Dir.glob(filename+'/**/*.json') : [filename]
  }
end

files.each do |filename|
  puts "Converting #{filename} to RVDATA2..."
  File.open(filename, 'r:utf-8') do |file|
    text = ''
    file.each {|line|
      text += line
    }

    rvdata2 = json_to_rvdata2(JSON.parse(text), filename)

    File.open(File.dirname(filename)+"/"+File.basename(filename,'.json')+'.rvdata2', 'wb') do |file|
      file.write(Marshal.dump(rvdata2))
    end
  rescue => ex
    puts "warning: got bad file #{filename}: #{ex}"
  end
end
