module SpiritGuide
  # Operations for dealing with the special way in which Dragon Spirits encodes graphical data.
  module Graphics
    RVDATA2_HEADER = "\x85\xa1\x39\x38\x3f\xd3\x3d\x6d".b.freeze
    PNG_HEADER = "\x89\x50\x4e\x47\x0d\x0a\x1a\x0a".b.freeze

    # Converts the binary string representing a rvdata2 entry to a binary string representing a PNG.
    def rvdata2_to_png(binstr)
      PNG_HEADER + binstr[RVDATA2_HEADER.length..]
    end

    # Converts the binary string representing a PNG to a binary string representing a rvdata2 entry.
    def png_to_rvdata2(binstr)
      RVDATA2_HEADER + binstr[PNG_HEADER.length..]
    end

    module_function :rvdata2_to_png
    module_function :png_to_rvdata2
  end
end
