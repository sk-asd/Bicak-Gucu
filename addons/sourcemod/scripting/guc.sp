#include <sourcemod>
#pragma semicolon 1
#pragma newdecls required
public Plugin myinfo =  { author = "phiso", version = "1.0", url = "phiso#3331 - www.pluginmerkezi.com - discord.gg/D3kcQy3BRx" };
ConVar can = null, tur = null; bool Kullandimi[MAXPLAYERS] =  { false, ... };
public void OnPluginStart()
{
	HookEvent("round_start", roundstart, EventHookMode_PostNoCopy);
	HookEvent("player_death", death, EventHookMode_PostNoCopy);
	can = CreateConVar("sm_guclubicak_can", "10", "Bıçak ile öldürene kaç can verilsin?", FCVAR_NOTIFY, true, 1.0);
	tur = CreateConVar("sm_guclubicak_tur", "1", "0 = Her öldürülene | 1 = Her Tur 1 Kere", 0, true, 0.0, true, 1.0);
	AutoExecConfig(true, "guclu-bicak", "phiso");
}
public Action death(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	if (IsClientInGame(client) && !IsFakeClient(client))
	{
		int attacker = GetClientOfUserId(event.GetInt("attacker"));
		if (tur.BoolValue)
		{
			if (Kullandimi[attacker])
				return;
		}
		if (IsClientInGame(attacker) && !IsFakeClient(attacker))
		{
			char SilahIsmi[64];
			GetClientWeapon(attacker, SilahIsmi, sizeof(SilahIsmi));
			if (strcmp(SilahIsmi, "weapon_kni", false) == 0)
			{
				SetEntityHealth(attacker, GetClientHealth(attacker) + can.IntValue);
				PrintToChat(attacker, "[SM] \x01Birisini öldürdüğün için \x10%d Can \x04kazandın!", can.IntValue);
				if (tur.BoolValue)
					Kullandimi[attacker] = true;
			}
		}
	}
}
public Action roundstart(Event event, const char[] name, bool dontBroadcast)
{
	if (tur.BoolValue)
	{
		for (int i = 1; i <= MaxClients; i++)
		{
			if (IsClientInGame(i) && Kullandimi[i])
			{
				Kullandimi[i] = false;
			}
		}
	}
} 
