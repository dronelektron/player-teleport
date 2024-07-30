void Command_Create() {
    RegAdminCmd("sm_teleport", Command_Teleport, ADMFLAG_GENERIC);
    RegAdminCmd("sm_goto", Command_Goto, ADMFLAG_GENERIC);
}

public Action Command_Teleport(int client, int args) {
    if (args < 1) {
        Message_TeleportUsage(client);

        return Plugin_Handled;
    }

    char name[MAX_NAME_LENGTH];

    GetCmdArg(1, name, sizeof(name));

    int[] targets = new int[MAXPLAYERS];
    char targetName[MAX_NAME_LENGTH];
    bool isMultilingual;

    int playersAmount = ProcessTargetString(
        name, client, targets, MAXPLAYERS, COMMAND_FILTER_NONE, targetName, sizeof(targetName), isMultilingual
    );

    if (playersAmount < 1) {
        ReplyToTargetError(client, playersAmount);

        return Plugin_Handled;
    }

    bool teleported = false;

    for (int i = 0; i < playersAmount; i++) {
        int target = targets[i];

        teleported |= UseCase_Teleport(client, target);
    }

    if (teleported) {
        MessageActivity_PlayerTeleported(client, targetName, isMultilingual);
    }

    return Plugin_Handled;
}

public Action Command_Goto(int client, int args) {
    if (args < 1) {
        Message_GotoUsage(client);

        return Plugin_Handled;
    }

    char name[MAX_NAME_LENGTH];

    GetCmdArg(1, name, sizeof(name));

    int target = FindTarget(client, name);

    if (target != CLIENT_NOT_FOUND && UseCase_Goto(client, target)) {
        MessageActivity_PlayerGoto(client, target);
    }

    return Plugin_Handled;
}
