require "rmagick"

module SpiritGuide
  # Routines for retrieving icons.
  module Icons
    ICONS_PATH = "Graphics/System/IconSet.png".freeze
    ICON_SIZE = 24

    # Get the master icons spritesheet as a `Magick::Image`.
    def get_icons(projectpath)
      Magick::ImageList.new("#{projectpath}/#{ICONS_PATH}")[0]
    end

    module_function :get_icons

    # Get an icon `Magick::Image` from the spritesheet `Magick::Image` and the ID of the icon.
    # Icons are 24x24 sprites from `IconSet.png`, stored in row-major order.
    def get_icon(icons, id)
      cols = icons.columns / ICON_SIZE
      col = id % cols
      row = (id / cols).floor
      icons.crop(col * ICON_SIZE, row * ICON_SIZE, ICON_SIZE, ICON_SIZE, true)
    end

    module_function :get_icon
  end
end
