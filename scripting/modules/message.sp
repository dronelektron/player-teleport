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
