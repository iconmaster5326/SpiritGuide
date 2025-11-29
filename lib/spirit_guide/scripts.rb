require "zlib"

module SpiritGuide
  # Routines for handing scripts
  module Scripts
    # A RPG Maker script.
    class Script
      attr_accessor :id, :name, :contents
    end

    # Convert a `Marhsal.load`ed `Scripts.rvdata2` file to a usable format.
    def rvdata2_to_scripts(rvdata2)
      rvdata2.map do |raw_script|
        s = Script.new
        s.id = raw_script[0]
        s.name = raw_script[1]
        s.contents = Zlib::Inflate.inflate(raw_script[2])
        s
      end
    end

    # Convert scripts to a format `Marshal.dump`able to `Scripts.rvdata2`.
    def scripts_to_rvdata2(scripts)
      scripts.map do |script|
        [script.id, script.name, Zlib::Deflate.deflate(script.contents)]
      end
    end

    module_function :rvdata2_to_scripts
    module_function :scripts_to_rvdata2
  end
end
