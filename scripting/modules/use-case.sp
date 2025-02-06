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

    GetClientAbsAngles(client, angles);

    int clientTeam = GetClientTeam(client);
    int targetTeam = GetClientTeam(target);

    if (clientTeam == targetTeam) {
        GetClientAbsOrigin(client, origin);
    } else if (!FindFreeOrigin(client, target, origin)) {
        return false;
    }

    TeleportEntity(target, origin, angles);

    return true;
}

static bool FindFreeOrigin(int client, int target, float origin[3]) {
    float clientOrigin[3];
    float clientSizes[3];
    float targetSizes[3];

    GetClientAbsOrigin(client, clientOrigin);
    GetPlayerSizes(client, clientSizes);
    GetPlayerSizes(target, targetSizes);

    float offsetX = clientSizes[X] + targetSizes[X];
    float offsetY = clientSizes[Y] + targetSizes[Y];

    if (IsOriginFree(target, clientOrigin, offsetX, 0.0, origin)) {
        return true;
    }

    if (IsOriginFree(target, clientOrigin, 0.0, offsetY, origin)) {
        return true;
    }

    if (IsOriginFree(target, clientOrigin, -offsetX, 0.0, origin)) {
        return true;
    }

    if (IsOriginFree(target, clientOrigin, 0.0, -offsetY, origin)) {
        return true;
    }

    return false;
}

static void GetPlayerSizes(int client, float sizes[3]) {
    float mins[3];
    float maxs[3];

    GetClientMins(client, mins);
    GetClientMaxs(client, maxs);
    SubtractVectors(maxs, mins, sizes);
}

static bool IsOriginFree(int client, const float base[3], float offsetX, float offsetY, float origin[3]) {
    origin = base;
    origin[X] += offsetX;
    origin[Y] += offsetY;
    origin[Z] += 1.0;

    return !IsSpaceOccupied(client, origin);
}

static bool IsSpaceOccupied(int client, const float origin[3]) {
    float mins[3];
    float maxs[3];

    GetClientMins(client, mins);
    GetClientMaxs(client, maxs);
    TR_TraceHullFilter(origin, origin, mins, maxs, MASK_PLAYERSOLID, EnemiesOnly, client);

    return TR_DidHit();
}

static bool EnemiesOnly(int entity, int contentsMask, int client) {
    if (entity == client || entity > MaxClients) {
        return false;
    }

    int clientTeam = GetClientTeam(client);
    int targetTeam = GetClientTeam(entity);

    return clientTeam != targetTeam;
}
