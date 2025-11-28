# Run this in the root directory of a RPG Maker project.

import os

POSTFIX = ".rvdata2"
PNG_HEADER = b"\x89\x50\x4e\x47\x0d\x0a\x1a\x0a"


def convert(infilename: str):
    outfilename = infilename[:-len(POSTFIX)] + ".png"
    with open(infilename, "rb") as infile:
        with open(outfilename, "wb") as outfile:
            outfile.write(PNG_HEADER + infile.read()[len(PNG_HEADER):])


def convert_all(project: str):
    for dirname, dirs, files in os.walk(os.path.join(project, "Graphics")):
        for file in files:
            if file[-len(POSTFIX):] == POSTFIX:
                convert(os.path.join(dirname, file))


if __name__ == "__main__":
    import sys

    convert_all(sys.argv[1] if len(sys.argv) >= 2 else os.curdir)
