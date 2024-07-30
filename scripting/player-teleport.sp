#include <sourcemod>
#include <sdktools>

#include "player-teleport/console-command"
#include "player-teleport/math"
#include "player-teleport/message"

#include "modules/console-command.sp"
#include "modules/message.sp"
#include "modules/use-case.sp"

public Plugin myinfo = {
    name = "Player teleport",
    author = "Dron-elektron",
    description = "Allows you to teleport players",
    version = "0.1.0",
    url = "https://github.com/dronelektron/player-teleport"
};

public void OnPluginStart() {
    Command_Create();
    LoadTranslations("common.phrases");
    LoadTranslations("player-teleport.phrases");

    if (LibraryExists("multi-target-filters")) {
        LoadTranslations("multi-target-filters.phrases");
    }
}
