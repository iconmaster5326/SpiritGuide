meta:
  id: rvdatax
  endian: le
doc: A `.rvdatax` file, used in Dragon Spirits.
seq:
  - id: header
    doc: Header information?
    size: 3
  - id: num_entries
    doc: Number of entries.
    type: varnum
  - id: entries
    doc: Entries.
    type: entry
    repeat: expr
    repeat-expr: num_entries.value
types:
  varnum:
    doc: A variable-length number.
    seq:
      - id: num_bytes
        doc: The number of bytes this number is.
        type: u1
      - id: bytes_1
        doc: The bytes composing this number.
        type: u1
        if: num_bytes == 0x01
      - id: bytes_2
        doc: The bytes composing this number.
        type: u2
        if: num_bytes == 0x02
      - id: bytes_4
        doc: The bytes composing this number.
        type: u4
        if: num_bytes == 0x04
    instances:
      value:
        value: |
          num_bytes == 0x00 ? 0 :
          num_bytes == 0x01 ? bytes_1 :
          num_bytes == 0x02 ? bytes_2 :
          num_bytes == 0x04 ? bytes_4 :
          (num_bytes - 5)
  entry:
    doc: A single entry in a file.
    seq:
      - id: magic1
        doc: Magic number.
        size: 4
      - id: name
        doc: The name of the entity.
        type: str
        encoding: UTF-8
        terminator: 0x22 # "
        consume: false
      - id: magic2
        doc: Magic number.
        size: 1
      - id: len_contents
        doc: The byte length of entry contents.
        type: varnum
      - id: contents
        doc: The contents of this entry.
        type: str
        encoding: UTF-8
        size: len_contents.value
