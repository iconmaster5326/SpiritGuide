# SpiritGuide

An online database for the RPG Dragon Spirits.

## Instructions

To set up the Ruby environment:

```bash
bundle install
rake install
```

To set up the game to be viewable in RPG Maker VX Ace:

```bash
ruby setup_project.rb [pathtogame]
```

To convert all convertible database files to JSON, for manual viewing:

```bash
ruby rvdata2_to_json.rb [pathtogame]/Data
```

## Credits

* [FHNBHJ](https://store.steampowered.com/app/1074190/Dragon_Spirits/) for Dragon Spirits data and assets
* [aoitaku](https://gist.github.com/aoitaku/7822424) for the `.rvdata2` parsing routines
