# SpiritGuide

An online database for the RPG Dragon Spirits.

## Instructions

To set up the game to be viewable in RPG Maker VX Ace:

```bash
echo "RPGVXAce 1.02" > [pathtogame]/Game.rvproj2
python3 rvdata2_to_png.py [pathtogame]
python3 assemble_maps.py  [pathtogame]
```

## Credits

* [FHNBHJ](https://store.steampowered.com/app/1074190/Dragon_Spirits/) for Dragon Spirits data and assets
* [aoitaku](https://gist.github.com/aoitaku/7822424) for the `.rvdata2` parsing routines
