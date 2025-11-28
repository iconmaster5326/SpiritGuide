# Assemble the maps in the MapsInfo correctly so we can look at them in RPG Maker VX Ace.
# Run this with rvdata2_to_png as well to fully load Dragon Spirits in the editor.

import os
import json
import re
import subprocess
import sys

MAP_INFO_FILENAME = "Data/MapInfos.json"

mapfile = os.path.join(sys.argv[1] if len(sys.argv) >= 2 else os.curdir, "Data/MapInfos.json")
mapinfojson = {}
index = 1

for path, dirnames, filenames in os.walk("Data"):
    for filename in filenames:
        match = re.match(r"(Map\d+)\.rvdata2", filename)
        if match:
           mapinfojson[str(index)] = {
               "json_class": "RPG::MapInfo",
               "@scroll_x": 0,
               "@name": match.group(1),
               "@expanded": False,
               "@order": index,
               "@scroll_y": 0,
               "@parent_id":0
            }
           index += 1

with open(mapfile, "w") as outfile:
    json.dump(mapinfojson, outfile, indent=2)

subprocess.run(["ruby", "json_to_rvdata2.rb", mapfile])
