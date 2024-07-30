void Message_TeleportUsage(int client) {
    ReplyToCommand(client, "%s%s", PREFIX, "Usage: sm_teleport <#userid|name>");
}

void MessageActivity_PlayerTeleported(int client, const char[] targetName, bool isMultilingual) {
    if (isMultilingual) {
        ShowActivity2(client, PREFIX, "%t", PLAYER_TELEPORTED, targetName);
    } else {
        ShowActivity2(client, PREFIX, "%t", PLAYER_TELEPORTED, "_s", targetName);
    }
}

void MessageLog_PlayerTeleported(int client, int target) {
    LogMessage("\"%L\" teleported \"%L\"", client, target);
}

void Message_GotoUsage(int client) {
    ReplyToCommand(client, "%s%s", PREFIX, "Usage: sm_goto <#userid|name>");
}

void MessageActivity_PlayerGoto(int client, int target) {
    ShowActivity2(client, PREFIX, "%t", "Player goto", target);
}

void MessageLog_PlayerGoto(int client, int target) {
    LogMessage("\"%L\" teleported to \"%L\"", client, target);
}

void Message_SendUsage(int client) {
    ReplyToCommand(client, "%s%s", PREFIX, "Usage: sm_send <#userid|name> <#userid|name>");
}

void MessageActivity_PlayerSend(int client, const char[] targetName, bool isMultilingual, int target) {
    if (isMultilingual) {
        ShowActivity2(client, PREFIX, "%t", PLAYER_SEND, targetName, target);
    } else {
        ShowActivity2(client, PREFIX, "%t", PLAYER_SEND, "_s", targetName, target);
    }
}

void MessageLog_PlayerSend(int client, int target1, int target2) {
    LogMessage("\"%L\" teleported \"%L\" to \"%L\"", client, target2, target1);
}
