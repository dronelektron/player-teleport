bool UseCase_Teleport(int client, int target) {
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
    MessageLog_PlayerTeleported(client, target);

    return true;
}
