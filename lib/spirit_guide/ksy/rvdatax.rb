# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require "kaitai/struct/struct"

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new("0.11")
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end

##
# A `.rvdatax` file, used in Dragon Spirits.
class Rvdatax < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @header = @_io.read_bytes(3)
    @num_entries = Varnum.new(@_io, self, @_root)
    @entries = []
    num_entries.value.times do |i|
      @entries << Entry.new(@_io, self, @_root)
    end
    self
  end

  ##
  # A single entry in a file.
  class Entry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @magic1 = @_io.read_bytes(4)
      @name = @_io.read_bytes_term(34, false, false, true).force_encoding("UTF-8")
      @magic2 = @_io.read_bytes(1)
      @len_contents = Varnum.new(@_io, self, @_root)
      @contents = @_io.read_bytes(len_contents.value).force_encoding("UTF-8")
      self
    end

    ##
    # Magic number.
    attr_reader :magic1

    ##
    # The name of the entity.
    attr_reader :name

    ##
    # Magic number.
    attr_reader :magic2

    ##
    # The byte length of entry contents.
    attr_reader :len_contents

    ##
    # The contents of this entry.
    attr_reader :contents
  end

  ##
  # A variable-length number.
  class Varnum < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @num_bytes = @_io.read_u1
      @bytes_1 = @_io.read_u1 if num_bytes == 1
      @bytes_2 = @_io.read_u2le if num_bytes == 2
      @bytes_4 = @_io.read_u4le if num_bytes == 4
      self
    end

    def value
      return @value unless @value.nil?

      @value = (if num_bytes == 0
                  0
                else
                  (if num_bytes == 1
                     bytes_1
                   else
                     (if num_bytes == 2
                        bytes_2
                      else
                        (num_bytes == 4 ? bytes_4 : num_bytes - 5)
                      end)
                   end)
                end)
      @value
    end

    ##
    # The number of bytes this number is.
    attr_reader :num_bytes

    ##
    # The bytes composing this number.
    attr_reader :bytes_1

    ##
    # The bytes composing this number.
    attr_reader :bytes_2

    ##
    # The bytes composing this number.
    attr_reader :bytes_4
  end

  ##
  # Header information?
  attr_reader :header

  ##
  # Number of entries.
  attr_reader :num_entries

  ##
  # Entries.
  attr_reader :entries
end
