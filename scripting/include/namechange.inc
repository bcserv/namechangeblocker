#if defined _namechange_included
 #endinput
#endif
#define _namechange_included

/**
 * @brief Called When player name is changed
 *
 * @param		client		client index
 * @param		name		Clients new name
 * @param		oldname		Clients old name
 * @noreturn
 */
forward Action:OnChangePlayerName(client, String:name[], String:oldname[]);

/** Do Not Edit Below This Line **/

public Extension:__ext_namechange =
{
	name = "namechange",
	file = "namechange.ext",
#if defined AUTOLOAD_EXTENSIONS
	autoload = 1,
#else
	autoload = 0,
#endif
#if defined REQUIRE_EXTENSIONS
	required = 1,
#else
	required = 0,
#endif
};