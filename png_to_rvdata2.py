# Run this in the root directory of a RPG Maker project.

import os

POSTFIX = ".png"
RVDATA2_HEADER = b"\x85\xa1\x39\x38\x3f\xd3\x3d\x6d"


def convert(infilename: str):
    outfilename = infilename[:-len(POSTFIX)] + ".rvdata2"
    with open(infilename, "rb") as infile:
        with open(outfilename, "wb") as outfile:
            outfile.write(RVDATA2_HEADER + infile.read()[len(RVDATA2_HEADER):])


def convert_all(project: str):
    for dirname, dirs, files in os.walk(os.path.join(project, "Graphics")):
        for file in files:
            if file[-len(POSTFIX):] == POSTFIX:
                convert(os.path.join(dirname, file))


if __name__ == "__main__":
    import sys

    convert_all(sys.argv[1] if len(sys.argv) >= 2 else os.curdir)
