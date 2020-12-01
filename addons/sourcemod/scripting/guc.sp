#include sourcemod
#pragma semicolon 1
#pragma newdecls required
ConVar can = null;
public Plugin myinfo =  {
	name = "", 
	author = "phiso", 
	description = "", 
	version = "1.0", 
	url = "phiso#3331 - www.pluginmerkezi.com - discord.gg/D3kcQy3BRx"
};
public void OnPluginStart()
{
	HookEvent("player_death", death);
	can = CreateConVar("sm_guclubicak_can", "31", "Bıçak ile öldürene kaç can verilsin?", 0, true, 0.0);
	AutoExecConfig(true, "guclu-bicak", "phiso");
}
public Action death(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	if (IsClientInGame(client) && !IsFakeClient(client))
	{
		char SilahIsmi[64];
		int attacker = GetClientOfUserId(event.GetInt("attacker"));
		GetClientWeapon(attacker, SilahIsmi, sizeof(SilahIsmi));
		if (strcmp(SilahIsmi, "weapon_kni", false) == 0)
		{
			SetEntityHealth(attacker, GetClientHealth(attacker) + can.IntValue);
			PrintToChat(attacker, "[SM] \x04Bıçak ile birisini öldürdüğün için \x02%d \x04kredi kazandın.", can.IntValue);
		}
	}
} 