# SpiritGuide

An online database for the RPG [Dragon Spirits](https://store.steampowered.com/app/1074190/Dragon_Spirits/). This repository also contains, for a lack of a better location, tools for modding Dragon Spirits.

## Instructions

You'll need a [Ruby](https://www.ruby-lang.org/en/) installation, but more importantly, a purchased and installed copy of Dragon Spirits. Please give the developer money for their cool game!

### Installation

To set up the Ruby environment:

```bash
bundle install
rake install
```

Note the path of your Dragon Spirits installation (usually `C:\Program Files (x86)\Steam\steamapps\common\dragonspirits`).

### For Modding the Game

You'll need a copy of [RPG Maker VX Ace](https://www.rpgmakerweb.com/products/rpg-maker-vx-ace).

To set up the game to be viewable in the editor, and to be able to mod it:

```bash
ruby setup_project.rb [pathtogame]
```

From there, open up the newly created `Game.rvproj2` file in RPG Maker VX Ace. Once you're all done, and ready to test out your modded copy of Dragon Spirits, call:

```bash
ruby build_project.rb [pathtogame]
```

### For generating a Static Site

To generate the site's assets, under the `pages` directory:

```bash
ruby \lib\spirit_guide.rb [pathtogame]
```

Then you can navigate to `pages/index.html` to view Dragon Spirits information locally, or publish it where you please.

## Credits

* [FHNBHJ](https://store.steampowered.com/app/1074190/Dragon_Spirits/) for Dragon Spirits data and assets
* [aoitaku](https://gist.github.com/aoitaku/7822424) for the `.rvdata2` parsing routines
