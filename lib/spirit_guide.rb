require_relative "spirit_guide/version"
require_relative "spirit_guide/rgss3"
require_relative "spirit_guide/graphics"
require_relative "spirit_guide/rvdatax"

require "erb"
require "fileutils"

if __FILE__ == $PROGRAM_NAME
  # gather data
  dragons = []
  File.open("#{ARGV[0]}/GameData/Creatures.rvdatax", "rb") do |file|
    dragons = SpiritGuide::RVDataX.parse_dragons(file)
  end

  skills = []
  File.open("#{ARGV[0]}/GameData/Skills.rvdatax", "rb") do |file|
    skills = SpiritGuide::RVDataX.parse_skills(file)
  end

  accessories = []
  File.open("#{ARGV[0]}/GameData/HoldItems.rvdatax", "rb") do |file|
    accessories = SpiritGuide::RVDataX.parse_accessories(file)
  end

  effects = []
  File.open("#{ARGV[0]}/GameData/States.rvdatax", "rb") do |file|
    effects = SpiritGuide::RVDataX.parse_status_effects(file)
  end

  talents = []
  File.open("#{ARGV[0]}/GameData/Talents.rvdatax", "rb") do |file|
    talents = SpiritGuide::RVDataX.parse_talents(file)
  end

  # utils for rendering
  def render(page, *args)
    ERB.new(File.read("#{File.dirname(__FILE__)}/../templates/#{page}.rhtml")).result
  end

  # define scopes for page executions
  def main_scope(title, contents)
    Kernel.binding
  end

  def dragon_scope(dragon)
    Kernel.binding
  end

  def skill_scope(skill)
    Kernel.binding
  end

  def acc_scope(accessory)
    Kernel.binding
  end

  def se_scope(effect)
    Kernel.binding
  end

  def talent_scope(talent)
    Kernel.binding
  end

  # util functions
  def copy_image(src, dest)
    File.write(dest, SpiritGuide::Graphics.rvdata2_to_png(
                       File.read(
                         src,
                         binmode: true
                       )
                     ), binmode: true)
  end

  def render_page(title, contents)
    main_template = ERB.new(File.read("#{File.dirname(__FILE__)}/../templates/page.rhtml"))
    main_template.result(main_scope(title, contents))
  end

  # export HTML of data
  dragon_template = ERB.new(File.read("#{File.dirname(__FILE__)}/../templates/dragon.rhtml"))
  FileUtils.mkdir_p("pages/dragon")
  dragons.each do |dragon|
    copy_image("#{ARGV[0]}/Graphics/Battlers/d_#{dragon.id}.rvdata2", "pages/dragon/sprite#{dragon.id}.png")
    copy_image("#{ARGV[0]}/Graphics/System/DragonCards/c_#{dragon.id}.rvdata2", "pages/dragon/card#{dragon.id}.png")
    File.write("pages/dragon/#{dragon.id}.html",
               render_page(dragon.name_en, dragon_template.result(dragon_scope(dragon))))
  end

  skill_template = ERB.new(File.read("#{File.dirname(__FILE__)}/../templates/skill.rhtml"))
  FileUtils.mkdir_p("pages/skill")
  skills.each do |skill|
    File.write("pages/skill/#{skill.id}.html",
               render_page(skill.name_en, skill_template.result(skill_scope(skill))))
  end

  acc_template = ERB.new(File.read("#{File.dirname(__FILE__)}/../templates/accessory.rhtml"))
  FileUtils.mkdir_p("pages/accessory")
  accessories.each do |acc|
    File.write("pages/accessory/#{acc.id}.html",
               render_page(acc.name_en, acc_template.result(acc_scope(acc))))
  end

  se_template = ERB.new(File.read("#{File.dirname(__FILE__)}/../templates/effect.rhtml"))
  FileUtils.mkdir_p("pages/effect")
  effects.each do |se|
    File.write("pages/effect/#{se.id}.html",
               render_page(se.name_en, se_template.result(se_scope(se))))
  end

  talent_template = ERB.new(File.read("#{File.dirname(__FILE__)}/../templates/talent.rhtml"))
  FileUtils.mkdir_p("pages/talent")
  talents.each do |talent|
    File.write("pages/talent/#{talent.id}.html",
               render_page(talent.name_en, talent_template.result(talent_scope(talent))))
  end

  # export HTML of static pages
  File.write("pages/index.html",
             render_page("", ERB.new(File.read("#{File.dirname(__FILE__)}/../templates/index.rhtml")).result))
end
