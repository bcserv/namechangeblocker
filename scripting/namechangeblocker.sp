
// enforce semicolons after each code statement
#pragma semicolon 1

#include <sourcemod>
#include <sdktools>
#include <namechange>
#include <setname>

#define PLUGIN_VERSION "0.1"



/*****************************************************************


		P L U G I N   I N F O


*****************************************************************/

public Plugin:myinfo = {
	name = "Namechange blocker",
	author = "Berni",
	description = "Name Change Blocker for Zhivko Zhelev",
	version = PLUGIN_VERSION,
	url = "http://www.mannisfunhouse.eu"
}



/*****************************************************************


		G L O B A L   V A R S


*****************************************************************/

// ConVar Handles

// Misc
new String:names[MAXPLAYERS+1][MAX_NAME_LENGTH];
new block = false;



/*****************************************************************


		F O R W A R D   P U B L I C S


*****************************************************************/

public OnPluginStart()
{
	decl String:name[MAX_NAME_LENGTH];

	for (new client=1; client <= MaxClients; client++) {
		
		if (!IsClientInGame(client)) {
			continue;
		}

		GetClientName(client, name, sizeof(name));
	}
}

public OnClientConnected(client)
{
	decl String:name[MAX_NAME_LENGTH];

	GetClientName(client, name, sizeof(name));
	strcopy(names[client], sizeof(names[]), name);
}

public Action:OnChangePlayerName(client, String:name[], String:oldName[])
{
	if (block) {
		return Plugin_Handled;
	}

	CreateTimer(0.1, Timer_ChangeNameBack, GetClientSerial(client), TIMER_FLAG_NO_MAPCHANGE);

	return Plugin_Handled;
}

public Action:Timer_ChangeNameBack(Handle:timer, any:clientSerial)
{
	new client = GetClientFromSerial(clientSerial);

	if (client == 0) {
		return Plugin_Stop;
	}

	block = true;
	SetClientName(client, names[client]);
	block = false;

	return Plugin_Stop;
}

/*****************************************************************


		P L U G I N   F U N C T I O N S


*****************************************************************/

SetClientName(client, String:name[])
{
	//SetClientInfo(client, "name", name);
	CS_SetClientName(client, name);
}
