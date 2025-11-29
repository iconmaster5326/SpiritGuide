require_relative "lib/spirit_guide/version"

Gem::Specification.new do |spec|
  spec.name = "spirit_guide"
  spec.version = SpiritGuide::VERSION
  spec.authors = ["iconmaster5326"]
  spec.email = ["iconmaster5326@gmail.com"]

  spec.summary = "An online database for the RPG Dragon Spirits."
  spec.homepage = "https://github.com/iconmaster5326/SpiritGuide"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/iconmaster5326/SpiritGuide"

  gemspec = File.basename(__FILE__)
  spec.files = Dir.glob("**/*").reject do |f|
    (f == gemspec) || f.start_with?(*%w[Gemfile Rakefile .gitignore .rubocop.yml])
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "jsonable", "> 0"
  spec.add_dependency "kaitai-struct", ">= 0.11"
  spec.add_dependency "zlib", "> 0"
end
