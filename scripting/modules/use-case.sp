bool UseCase_Teleport(int client, int target) {
    bool teleported = Teleport(client, target);

    if (teleported) {
        MessageLog_PlayerTeleported(client, target);
    }

    return teleported;
}

bool UseCase_Goto(int client, int target) {
    bool teleported = Teleport(target, client);

    if (teleported) {
        MessageLog_PlayerGoto(client, target);
    }

    return teleported;
}

bool UseCase_Send(int client, int target1, int target2) {
    bool teleported = Teleport(target1, target2);

    if (teleported) {
        MessageLog_PlayerSend(client, target1, target2);
    }

    return teleported;
}

static bool Teleport(int client, int target) {
    if (client == target || !IsPlayerAlive(client) || !IsPlayerAlive(target)) {
        return false;
    }

    float origin[3];
    float angles[3];

    GetClientAbsOrigin(client, origin);
    GetClientAbsAngles(client, angles);

    int clientTeam = GetClientTeam(client);
    int targetTeam = GetClientTeam(target);

    if (clientTeam != targetTeam) {
        float maxs[3];

        GetClientMaxs(client, maxs);

        origin[Z] += maxs[Z] + 1.0;
    }

    TeleportEntity(target, origin, angles);

    return true;
}
