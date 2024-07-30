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
    if (client == target) {
        return false;
    }

    if (!IsPlayerAlive(client)) {
        return false;
    }

    if (!IsPlayerAlive(target)) {
        return false;
    }

    float position[3];
    float angles[3];

    GetClientAbsOrigin(client, position);
    GetClientAbsAngles(client, angles);

    int clientTeam = GetClientTeam(client);
    int targetTeam = GetClientTeam(target);

    if (clientTeam != targetTeam) {
        float maxBounds[3];

        GetClientMaxs(client, maxBounds);

        position[Z] += maxBounds[Z] + 1.0;
    }

    TeleportEntity(target, position, angles);

    return true;
}
