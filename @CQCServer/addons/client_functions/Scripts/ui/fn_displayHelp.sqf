params [["_mode","",[""]],["_params",[]]];

switch _mode do {
	case "onLoad":{
		private _display = _params param [0,displayNull];

		private _title = _display displayCtrl 1;
		private _body = _display displayCtrl 2;
		private _button = _display displayCtrl 3;

		_title ctrlSetText "Welcome to Frag Squad CQC!";

		_body ctrlSetStructuredText parseText ([
			"   Mission Developed by Frag Squad Development Team",
			"",
			"   Make sure to join the Discord to post suggestions/bugs, ",
			"   Report cheaters/cunts, and potential unban appeals.",
			"",
			"   Discord: <a href='https://discord.gg/55qUpsU'>https://discord.gg/55qUpsU</a>",
			"   Donate here: <a href='https://paypal.me/seecuesee'>https://paypal.me/seecuesee</a>",
			"",
			"   User Controls:",
			"   H: Heal",
			"   Shift + Space: Vault",
			"   Shift + H: Holster weapon",
			"   Shift + 1: Spawn Mags/Item Menu",
			"   Shift + O: Increase ear plug level",
			"   Ctrl  + O: Decrease ear plug level",
			"   Alt   + O: Toggle ear plugs",
			"   Shift + 2: Vehicle Menu",
			"   F5: Show Player KDA Stats",
			"",
			""
		] joinString "<br/>");

		_button ctrlSetText "Exit";
		_button ctrlAddEventHandler ["ButtonClick",{ 
			(ctrlParent(_this select 0)) closeDisplay 2;
		}];
	};
};