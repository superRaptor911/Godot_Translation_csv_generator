# Godot_Translation_csv_generator
Script to translate texts to given languages in CSV format for Godot engine.

# Installing
You need `translate-shell` 
```
sudo apt-get install translate-shell
```

# Usage

```
./r_godotTranslate.sh textfile.txt [languages...]
```

For example: To translate your game texts into Russian, French and Spanish
```
./r_godotTranslate.sh textfile.txt ru fr es
```

Where textfile.txt is the file you want to translate. Field 1 is your key and field 2 is the text in English and they are seperated by ',' and field 2 is in ""
Example: File for my game
```
MENU_new_game,		"New Game"
MENU_loadout,		"Loadout"
MENU_options,		"Settings"
MENU_level_editor,	"Level Editor"
MENU_community,		"Community"
MENU_quit,			"Quit game?"
MENU_yes,			"yes"
MENU_no,			"no"
MENU_back,			"Back"
MENU_start,			"Start"
MENU_purchase,		"Purchase"

NEWGAME_join_online,	"Join Online"
NEWGAME_join_lan,		"Join Local"
NEWGAME_create,			"Create Game"

LOBBY_standard_maps,	"Standard"
LOBBY_my_maps,			"My maps"
LOBBY_downloaded,		"Downloaded"
LOBBY_level_name,		"Level Name"

STORE_select_skin,		"Select Skin"
STORE_buy_skin,			"Buy Skin"

SKIN_SELECT_sel_skin,		"Selected Skin"
SKIN_SELECT_terrorist,		"Terrorist"
SKIN_SELECT_Cterrorist,		"Counter Terrorist"

GUN_STORE_pistol,		"Pistol"
GUN_STORE_rifle,		"Rifle"
GUN_STORE_grenades,		"Grenades"

ONCE_welcome,		"Welcome"
ONCE_name,			"Name"
ONCE_msg1,			"You can change your name later in settings"

```

Output will be saved as translation.csv
