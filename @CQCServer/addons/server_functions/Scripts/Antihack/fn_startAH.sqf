
params [
	["_serverCommandPassword",""],
	["_passwordAdmin",""]
];

if(missionNameSpace getVariable ["CQC_run",false])exitWith{
	['SYSTEMLOG','CQC was already started! Make sure that your mission is not looping due to config errors'] call CQC_fnc_ahLog; 
	false
};
missionNameSpace setVariable ["CQC_run",true];

 
_ESCMNUTOP = 'A3 CQC';
_ESCMNUBOT = 'by FragSquad';
_OPEN_ADMIN_MENU_KEY = 0x3B;

 
/*  Terrain Grid Value   */ _TGV = 50;		/* 50, 25, 12.5  */	/* if set to 50 grass will be very low for better client FPS.. default is 25 ~35 is good performance and grass :) */
/*  ViewDistance Value   */ _VDV = 1000;
/*  ObjectViewDistance   */ _VOV = 800;
/*  Local Vehicle Check  */ _LVC = true;	/* true or false */
/*  unitRecoil checks    */ _URC = false;	/* true or false */
/*  Check Vision Mode    */ _CVM = true;	/* true or false */
/*  Use Memoryhack check */ _UMH = true;	/* true or false */ 
/*  Use vehicle check    */_UVC = true;		/* true or false */ 
/*  Use vhicle whitelist */_UVW = false;	/* true or false | checks all vehicles on the map. If their type is not in "_VehicleWhiteList", they are flagged as hacked in and destroyed. */
 

private _superAdmin = [//(Rank 4)  
	/*!!! DONT EDIT THIS ARRAY!!!*/
	'SuperAdmin'
	/*!!! DONT EDIT THIS ARRAY!!!*/
];
private _normalAdmin = [//(Rank 3)
	'Teleport On Map Click','Teleport - Target To Me','Teleport - Me To Target',
	'spectating','Delete Vehicle','EjectTarget','ToggleVehLock','ShowGear','ServerState',
	'HealSelf','HealRepairNear','Freeze Target','UnFreeze Target',
	'==== Loadouts ====','==== WeatherLord ====','==== Weapons ====','==== Magazines ====',
	'==== Bags ====','==== Objects ====',
	'Remove Gear','Revive','Heal','Restore','Move In My Vehicle','Move In Target Vehicle',
	'Eject','Eject Crew','Kill','Force Disconnect',
	'Kick (Silent)','Kick (Announce)','Ban (Announce)',
	'CQC Player ESP 1','CQC Dead ESP','CQC MapIcons','Vehicle Marker','DeadPlayer Marker',
	'God Mode','Vehicle God Mode','Lower Terrain','Stealth / Invisible',
	'Disable Announces','Show FPS','Mass Message','DayTime',
	'Spawn Support-Box1','Spawn Support-Box2','Spawn Support-Box3',
	'Spawn Ammo','showinfo','FreeRoam Cam (does not work with ESP)',
	'Request Steam Name'
];
private _basicAdmin = [//(Rank 2)
	'Teleport On Map Click','Teleport - Target To Me','Teleport - Me To Target',
	'spectating','EjectTarget','ToggleVehLock','ShowGear','HealSelf','HealRepairNear',
	'==== Weapons ====','==== Magazines ====','==== Bags ====',
	'Remove Gear','Revive','Heal','Restore','Move In My Vehicle','Move In Target Vehicle',
	'Eject','Eject Crew','Force Disconnect',
	'Kick (Announce)','DeadPlayer Marker','God Mode','Vehicle God Mode','Lower Terrain',
	'Mass Message','DayTime',
	'Spawn Ammo','showinfo','Request Steam Name'
];
private _trialAdmin = [//(Rank 1)
	'Teleport On Map Click','Teleport - Target To Me','Teleport - Me To Target',
	'spectating','ShowGear','HealSelf','HealRepairNear',
	'==== Weapons ====','==== Magazines ====','==== Bags ====',
	'Remove Gear','Revive','Heal','Move In My Vehicle','Move In Target Vehicle',
	'Eject','Eject Crew','Force Disconnect','God Mode',
	'Mass Message','showinfo','Request Steam Name'
];

private _disAllowVon = 
[
	/*
		if somebody talks on one of the following channels, his channel will be switched to "direct" channel
		0 = Global
		1 = Side
		2 = Command
		3 = Group
		4 = Vehicle
		5 = Direct <-- this is where people get switched too if they talk in one of the blacklisted channels!
		6-15 = Custom Radio (see radioChannelCreate)
	*/
	0,1,2
];

private _badVarWhitelist =
[	
	/* _badVarWhitelist: These variables are not getting checked by the "BadVar#2" check. */
	'cba_diagnostic_fnc_initextendeddebug','ace_interact_menu_fnc_renderselector'
];

private _blacklistedSteamIDS = 
[

];

private _blacklistedVariables =
[ 
	'bis_fnc_dbg_reminder_value','bis_fnc_dbg_reminder','bis_menu_groupcommunication','bis_fnc_addcommmenuitem_menu','gtp',
	'rscspectator','rscspectator_hints','rscspectator_display','rscspectator_playericon','gunrestrain',
	'rscspectator_view','rscspectator_map','rscspectator_vision','rscspectator_keys','gspawnv',
	'rscspectator_interface','gmoney','gkillall',	'time','servertime','myplayeruid','hhahaaaaar','charliesheenkeybinds','kickoff',
	'yolo','runonce','notakeybind','action1','supa_licenses','autokick','wallaisseikun','mainmenu','anarray',
	'gefclose','gefwhite','gefred','gefgreen','gefcyan','firsthint','new_queued','fn_exec','fnd_fnc_select','fnx3','antihackkick','tele','dmap','goldens_global_shit_yeah','glass911_run',
	'geardialog_create','lystokeypress','thirtysix','ly_swaggerlikeus','jkeyszz','n2','boxofmagic','mainscripts','dmc_fnc_4danews','CQCbypass','exec_text','vehicle_dblclick','init_main',
	'esp_count','nute_dat_bomber','s_cash100k','xposplayer','ly_re_onetime','skar_checka','mainscriptsv4','viewdistance','check_load','already_load','meins','f1','dummy','plane_jump',
	'c_player','mouseclickeh','distp','nec2','menu_i_run_color_lp','glassv1nce_bindhandler','thecar','fastanimes','getinpassenger','iaimon','dmc_re_onetime','func_execonserver','fnc_serverkicknice',
	'kick_admins','dasmokeon','hovering','r_kelly_be_flying','slx_xeh_bwc_init_compile','vincelol_altislife','life_fnc_byassskaroah','ah_fnc_mp','jayre','fn_newsbanner','hack_news','trollfuncs',
	'fanatic_infipass','keybindings_xxx','andysclosed','userfuncs','altisfuncs','remexe','bb_nofatigue','bis_fnc_diagkey_var_code','first_page','get_in_d','i_t_s__m_e_o','smissles','whippy_esp',
	'targetfuncs2','life_fnc_antifreeeeze','ly_keyforward','ty_re_onetime','life_fnc_xaaxaa','mein1','goddamnvehiclesxd','mystic_fnc_esp_distance','esp_id_setter','dummymen','whipbut','userfuncs',
	'krohdofreedom','selectedplayer','lmenu1','ggplayer','throx_menu_item','lvl1','init_menu_slew','d_b_r_t_y_slew','v6_gef','xasfjisisafudmmyx','kekse','updated_re_36','first','second','paradox_s3tc4sh',
	'checkchatloop','bringmeup','finie_s_p','fnc_infiAdminKeyDown','jay_vehicle_list',
	'shit','whsh506_m41n','finifeaturesformatted','nigger_init','bmcloos','exile_slayexiles',
	'buttons','opnmemeu','firstload','nss_ac_openvvs','nss_ac_openvas','nss_ac_setcaptive',
	'nss_ac_invisible','nss_ac_mapteleport','nss_ac_opencode','nss_ac_freecam','nss_ac_godmode','nss_ac_execscript',
	'nss_ac_openspectator','menuinit','realscripts','targetplr',
	'MLRN_RE','Running','RE','n912','TBMKnlist','PLAY','ALTISLIFENEXT3','SOMEONE_dsfnsjf',
	'FND_fnc_subs','setcash','Dummy_Ghost','entf','check_loaded','LY_Menu','AndysClosed','GOLDENS_GLOBAL_SHIT_YEAH','Fanatic_Main_Bereich',
	'imgoingnukeyou','fnc_usec_damageHandler','CheatCurator','andy_loopz','InitFileOne',
	'Status_BB','TZ_BB_A3','TZ_BB_KB_Hint','TZ_BB_BindHandler','AH_BRAZZERS_TZ_BB','kamakazi_lystic','fuckfest','LYSTIC_MENU_LOADED','D_AMEZ_COA',
	'Intro','Repair','Heal','T3le','TNK','I_like_turtles','BIGM','GMod','E3p','Does_Tonic_Like_to_take_Turtle_penis_in_the_ass_LODESTARS',
	'lel','vars','PSwap','toLower_new','BCast','thfile','tlmadminrq','CQCBLACK','carepkg','scrollAim','BlurExec','sbpc','CALLRE',
	'menu_run','ZedProtect','actid1','vehicles1','MapClicked','MapClickedPosX','MouseUpEvent','scrollPlayerlist','keypress_xxx','D_AMEZ_COA',
	'envi','G_A_N_G_S_T_A','ZoombiesCar','timebypass','returnString_z','isori','tangrowth27','PVAH_AdminRequest','AH_OFF_LOL','CQC_fillRE',
	'qwak','infoe','font','title_dialog','sexymenu_adds_Star','boolean_1','initre337','skype_option','bleh','magnetomortal','fnc_allunits','sbp',
	'PV_IAdminMenuCode','PVAH_WriteLogRequest','skype_img','Lhacks','Lpic','LtToTheRacker','Lexstr','take1','Called','epochExec','sdgff4535hfgvcxghn',
	'adadawer24_1337','fsdddInfectLOL','W_O_O_K_I_E_Car_RE','kW_O_O_K_I_E_Go_Fast','epchDeleted','lystobindkeys','lystoKeypress','fnc_usec_unconscious',
	'toggle_1','shiftMenu','dbClicked','b_loop','re_loop','v_bowen','bowen','melee_startAttack','asdasdasd','antihax2','PV_AdminMenuCode','AdminLoadOK',
	'AdminLoadOKAY','PV_TMPBAN','T_o_g_g_l_e_BB','fixMenu','PV_AdminMenuCodee','AdminPlayer','PVAH_AdminRequestVariable','epochBackpack','JME_Red',
	'JME_MENU_Sub','JME_menu_title','JME_Sub','JME_OPTIONS','god','heal','grass','fatguybeingchasedbyalion','night','day','infammo','nvg','thermal',
	'Keybinds','fredtargetkill','loopfredtpyoutome','epochTp','AdminLst','BB_Pr0_Esp','BBProEsp','epochMapMP','CALLRESVR','EPOCH_spawnVehicle_PVS',
	'adminlite','adminlitez','antihacklite','inSub','scroll_m_init_star','markerCount','zombies','startmenu_star','LystoDone','MOD_EPOCH',
	'Admin_Lite_Menu','admingod','adminESPicons','fnc_MapIcons_CQC','BIS_MPF_remoteExecutionServer4','adminadd','shnext','CQC_fill_Weapons',
	'adminZedshld','adminAntiAggro','admin_vehicleboost','admin_low_terrain','admin_debug','admincrate','exstr','nlist','PV_AdminMainCode','TPCOUNTER',
	'PVDZ_Hangender','fn_filter','vehiList','Remexec_Bitch','zeus_star','igodokxtt','tmmenu','AntihackScrollwheel','survcam','infiniteammo','PVAH_AHTEMPBAN',
	'lalf','toggle','iammox','telep','dayzlogin3','dayzlogin4','changeBITCHinstantly','antiAggro_zeds','BigFuckinBullets','abcdefGEH','adminicons',
	'fn_esp','aW5maVNUQVI_re_1','passcheck','isInSub','qodmotmizngoasdommy','ozpswhyx','xdistance','wiglegsuckscock','diz_is_real__i_n_f_i_S_T_A_R',
	'pic','veh','unitList','list_wrecked','addgun','ESP','BIS_fnc_3dCredits_n','dayzforce_save','ViLayer','blackhawk_sex','activeITEMlist','items1',
	'adgnafgnasfnadfgnafgn','Metallica_CQC_hax_toggled','activeITEMlistanzahl','xyzaa','iBeFlying','rem','DAYZ_CA1_Lollipops','HMDIR','vehC',
	'HDIR','carg0d','init_Fncvwr_menu_star','altstate','black1ist','ARGT_JUMP','ARGT_KEYDOWN','ARGT_JUMP_w','ARGT_JUMP_a','bpmenu','color_black',
	'fffffffffff','markPos','pos','TentS','VL','MV','monky','qopfkqpofqk','monkytp','pbx','nametagThread','spawnmenu','sceptile15','sandshrew',
	'mk2','fuckmegrandma','mehatingjews','TTT5OptionNR','zombieDistanceScreen','cargodz','R3m0te_RATSifni','wepmenu','admin_d0','RAINBOWREMEXECVEH',
	'omgwtfbbq','namePlayer','thingtoattachto','HaxSmokeOn','testIndex','g0d','spawnvehicles_star','kill_all_star','sCode','dklilawedve','peter_so_fly_CUS',
	'selecteditem','moptions','delaymenu','gluemenu','g0dmode','cargod','CQC_fillHax','itemmenu','gmadmin','fapEsp','mapclick','VAGINA_secret',
	'spawnweapons1','abcd','skinmenu','playericons','changebackpack','keymenu','godall','theKeyControl','CQC_FILLPLAYER','whitelist','pfEpochTele',
	'custom_clothing','img','surrmenu','footSpeedIndex','ctrl_onKeyDown','plrshldblcklst','DEV_ConsoleOpen','executeglobal','cursoresp','Asdf','planeGroup',
	'teepee','spwnwpn','musekeys','dontAddToTheArray','morphtoanimals','aesp','LOKI_GUI_Key_Color','Monky_initMenu','tMenu','recon','curPos',
	'playerDistanceScreen','ihatelife','debugConsoleIndex','MY_KEYDOWN_FNC','pathtoscrdir','Bowen_RANDSTR','ProDayz','idonteven','walrein820','RandomEx',
	'TAG_onKeyDown','changestats','derp123','heel','rangelol','unitsmenu','xZombieBait','plrshldblckls','ARGT_JUMP_s','ARGT_JUMP_d','globalplaya','ALL_MAGS_TO_SEARCH',
	'shnmenu','xtags','pm','lmzsjgnas','vm','bowonkys','glueallnigga','hotkeymenu','Monky_hax_toggled','espfnc','playeresp','zany','dfgjafafsafccccasd',
	'atext','boost','nd','vspeed','Ug8YtyGyvguGF','inv','rspwn','pList','loldami','T','bowonky','aimbott','Admin_Layout','markeresp','allMrk','MakeRandomSpace',
	'helpmenu','godlol','rustlinginit','qofjqpofq','invall','initarr','reinit','byebyezombies','admin_toggled','fn_ProcessDiaryLink','ALexc','DAYZ_CREATEVEHICLE',
	'Monky_funcs_inited','FUK_da_target','damihakeplz','damikeyz_veryhawt','mapopt','hangender','slag','jizz','kkk','ebay_har','sceptile279','TargetPlayer',
	'tell_me_more_CQC','airborne_spawn_vehicle_CQC','sxy_list_stored','advert_SSH','antiantiantiantih4x','Flare8','Flare7','SuperAdmin_MENU',
	'bl4ck1ist','keybinds','actualunit','mark_player','unitList_vec','yo2','actualunit_vec','typeVec','mark','r_menu','hfghfg','vhnlist','work','Intro',
	'cTargetPos','cpbLoops','cpLoopsDelay','Flare','Flare1','Flare2','Flare3','Flare4','Flare5','Flare6','kanghaskhan','palkia',
	'eExec_commmand','cockasdashdioh','fsdandposanpsdaon','antiloop','anti','spawn_explosion_target_ebay','whatisthis4','ratingloop_star','epochRemoteNukeAll',
	'PVAH_admin_rq','PVAH_writelog_rq','sandslash','muk','pidgeotto','charmeleon','pidgey','lapras','LYST1C_UB3R_L33T_Item','MathItem','fapLayer','cooldown',
	'raichu','CQC_chewSTAR_dayz_1','infi_STAR_output','infi_STAR_code_stored','keybindings','keypress','menu_toggle_on','dayz_godmode','aiUnit',
	'MENUTITLE','wierdo','runHack','Dwarden','poalmgoasmzxuhnotx','ealxogmniaxhj','ohhpz','fn_genStrFront','shazbot1','cip','Armor1','GMod',
	'kickable','stop','possible','friendlies','hacks','main','mapscanrad','maphalf','DelaySelected','SelectDelay','GlobalSleep','vehD','ALL_WEPS_TO_SEARCH',
	'jopamenu','ggggg','tlm','Listw','toggle_keyEH','infammoON','pu','chute','dayzforce_savex','PVDZ_AdminMenuCode','PVDZ_SUPER_AdminList','DarkwrathBackpack',
	'PVDZ_hackerLog','BP_OnPlayerLogin','material','mapEnabled','markerThread','addedPlayers','playershield','spawnitems1','sceptile27','Proceed_BB',
	'ESPEnabled','wpnbox','fnc_temp','MMYmenu_stored','VMmenu_stored','LVMmenu_stored','BIS_MPF_ServerPersistentCallsArray','PV_CHECK','admin_animate1',
	'patharray','ZobieDistanceStat','CQCBOTxxx','keyspressed','fT','tpTarget','HumanityVal','yanma','absol','SimpleMapHackCount','keyp',
	'aggron','magazines_spawn','weapons_spawn','backpack_spawn','backpackitem_spawn','keybindings_exec','keypress_exec','MajorHageAssFuckinfBulletsDude',
	'Wannahaveexplosivesforbullets','TheTargetedFuckingPlayerDude','haHaFuckAntiHakcsManIbypasDatShit','aintNoAntiHackCatchMyVars','objMYPlayer',
	'Awwwinvisibilty','vehiclebro','wtfyisthisshithere','terrainchangintime','Stats','menu','ssdfsdhsdfh','onisinfiniteammobra','youwantgodmodebro',
	'yothefuckingplayerishere','Namey','sendmsg12','jkh','DELETE_THIS','move_forward','leftAndRight','forwardAndBackward','upAndDown','distanceFromGround',
	'hoverPos','bulletcamon','cheatlist','espOn','removegrass','timeday','infammo','norekoil','nocollide','esp2ez','fastwalk','entupautowalk',
	'BensWalker','dropnear','executer','killme','magnetmenu','loadmain','magnet','loadMenu','refreshPlayers','ALREADYRAN','players','BigBenBackpack',
	'sendMessage','newMessage','W34p0ns','amm0','Att4chm3nt','F0od_Dr1nk','M3d1c4l','T0ol_it3ms','B4ckp4cks','It3m5','Cl0th1ng','walkloc','nwaf','cherno',
	'cherno_resident','cherno_resident_2','dubky','oaks','swaf','swmb','getX','PlayerShowDistance','M_e_n_u_2','colorme','keybindloop','Tractor_Time',
	'murkrow','noctowl','isExecuted','piloswine','AddPlayersToMap','markers','miltank','GearAdd','GearRemove','Malvsm','Malcars','malfly','keyForward',
	'PermDialogSelected','TempDialogSelected','AdminDialogList','pfKeygen','pfScanUnits','pfPickPlayer','pfshnext','pfnlist','pfselecteditem','pfshnmenu',
	'pfPlayerMonitor','pfPlayersToMonitor','pfShowPlayerMonitor','pfPlayerMonitorMutex','marker','JJJJ_MMMM___EEEEEEE_INIT_MENU','E_X_T_A_S_Y_Init_Menu',
	'monkaiinsalt','monkaiin','part88','adminKeybinds','PV_DevUIDs','fapEspGroup','Repair','RepairIT','rainbowTarget','rainbowTarget1','rainbowTarget2',
	'rainbowTarget3','letmeknow','VehicleMenue','Menue_Vehicle','my_anus_hurtz','life_no_injection','Tonic_has_a_gaping_vagina','teletoplr','telet',
	'ygurv1f2','BIGM','E3p','fnc_PVAH_AdminReq','MAIN_CODE_INJECTED','D34DXH34RT_E5P','Arsenal','Jme_Is_God','B0X_CANN0N_T0GGLE',
	'PL4YER_CANN0N_T0GGLE','aim','HOLY_FUCK_FDKFHSDJFHSDKJ_vehicles_m','lazy_ILHA_is_lazy','POOP_Item','die_menu_esp_v1','XXMMWW_main_menu','MM_150',
	'BIS_tracedShooter','JME_HAS_A_GIANT_DONG','nuke_vars','nukepos','fuckfest','fuckfestv2','FAG_NEON','Deverts_keyp','jfkdfjdfjdsfjdsfjkjflfjdlfjdlfjru_keyp',
	'eroticTxt','asdadaio9d0ua298d2a0dza2','trap','boomgoats','morphme','morph','blfor','blfor2','blfor3','rdfor','rdfor2','rdfor3','napa','civ',
	'Detected_Remote_Execution','keybindz','PEDO_IS_FUKED','MAINON','PLAYERON','PLAYEROFFNEXT1','PLAYERNEXT2','ALTISLIFEON','ALTISLIFEOFFNEXT1','ALTISLIFENEXT2',
	'ALTISLIFEOFFNEXT2','ALTISLIFENEXT3','FUNMENUON','FUNMENUOFFNEXT1','FUNMENUNEXT2','FUNMENUOFFNEXT2','FUNMENUNEXT3','MAINOFF','PLAYEROFF','ALTISLIFEOFF',
	'FUNMENUOFF','H4X_Miriweth_Menu_Click_Hax','IrEcOCMmeNEnd_God_MODE','TTTT_IIII___TTTTTTT_REPGAs','EC_GOD_TOGGLE','admin_d0_server','PedoMazing_Friends',
	'ly5t1c','JJMMEE_Swagger','Bobsp','Speed_Hack_cus','pList_star_peter_cus','RGB','neo_throwing','Blue_I_Color_LP','box','bombs','CQC_RUNNING_AH_on_Player',
	'Orange_I_Color_LP','Menu_I_On_Color_LP','Menu_I_Off_Color_LP','Speed_Hack_cus','cus_SPEED_DOWN','pnc','SpyglassFakeTrigger','infammook','input_text',
	'Tit_Choppertimer','GLASS911_Executer_for_menu','E5P','ThirtySix_Unlim_Ammo','ThirtySix_God','menuheader','life_fnc_sessionUpdateCalled',
	'blu_t_color_LP','FAG_RedSoldiers','titles_n_shit','eXecutorr','menu_headers','player_list','refresh_players','fn_loadMap','weapon_list','vehicle_list','get_display',
	'create_display','CTRL_BTN_LIST','execMapFunc','mapFunc','OPEN_LISTS','init_menu','biggies_white_tex','Abraxas_Unl_Life','Abraxas_Life','waitFor','Mystic_ESP',
	'biggies_menu_open','scriptex3cuter','rym3nucl0s3','eses_alis','PersonWhomMadeThisCorroded_Menu','Flo_Simon_KillPopUp','keybindz2','text_colour','key_combos_ftw',
	'PlayerInfiniteAmmo','Im_a_Variable','aaaa','fnc_LBDblClick_RIGHT','OMFG_MENU','N_6','RscCombo_2100_mini','RscListbox_1501_mini','andy_suicide','life_nukeposition',
	'JxMxE_hide','JME_Keybinds','JME_has_yet_to_fuck_this_shit','JME_deleteC','JME_Tele','JME_ANAL_PLOW','JME_M_E_N_U_initMenu','JME_M_E_N_U_hax_toggled','W_O_O_K_I_E_FUD_Pro_RE','W_O_O_K_I_E_FUD_Car_RE','W_O_O_K_I_E_FUD_Car_RE',
	'JxMxE_Veh_M','JxMxE_LifeCash500k','W_O_O_K_I_E_FUD_FuckUp_GunStore','W_O_O_K_I_E_FUD_M_E_N_U_initMenu','W_O_O_K_I_E_FuckUp_GunStore_a','JME_KillCursor','JME_OPTIONS','JME_M_E_N_U_fill_TROLLmenu','ASSPLUNGE','FOXBYPASS','POLICE_IN_HELICOPTA',
	'JxMxE_EBRP','W_O_O_K_I_E_M_E_N_U_funcs_inited','Menu_Init_Lol','E_X_T_A_S_Y_Atm','W_O_O_K_I_E_Pro_RE','W_O_O_K_I_E_Debug_Mon','W_O_O_K_I_E_Debug_1337','Veh_S_P_A_W_N_Shitt','sfsefse','tw4etinitMenu','tw4etgetControl',
	'JxMxEsp','JxMxE_GOD','JxMxE_Heal','efr4243234','sdfwesrfwesf233','sdgff4535hfgvcxghn','adadawer24_1337','lkjhgfuyhgfd','E_X_T_A_S_Y_M_E_N_U_funcs_inited','dayz_serverObjectMonitor','fsfgdggdzgfd','fsdddInfectLOL','Wookie_List',
	'JxMxE_TP','Wookie_Pro_RE','Wookie_Car_RE','Wookie_Debug_Mon','faze_funcs_inited','advertising_banner_CQC','atext_star_xa','Monky_hax_dbclick','qopfkqpofqk','debug_star_colorful','AntiAntiAntiAntiHax','antiantiantiantih4x',
	'JxMxE_Infect','hub','scrollinit','gfYJV','Lystic_LMAOOOOOOOOOOOOOOOOOOO','Lystic_Re','Lysto_Lyst','E_X_T_A_S_Y_Keybinds','Menulocations','Lystic_Init','scroll_m_init_star','exstr1','pathtoscrdir3','Monky_funcs_inited',
	'JxMxE_secret','Monky_initMenu','player_zombieCheck','E_X_T_A_S_Y_Recoil','godlol','playericons','abcdefGEH','wierdo','go_invisible_CQC','serverObjectMonitor','enamearr','initarr3','locdb','sCode','infAmmoIndex',
	'nukeDONEstar','Wookie_List','Wookie_Pro_RE','FUCKTONIC','E_X_T_A_S_Y_FuckUp_GunStore_a','E_X_T_A_S_Y_Cash_1k_t','E_X_T_A_S_Y_Cash_a','E_X_T_A_S_Y_LicenseDrive','E_X_T_A_S_Y_Menu_LOOOOOOOOOL','Metallica_vehicleg0dv3_CQC',
	'JJJJ_MMMM___EEEEEEE_INIT_MENU','JJJJ_MMMM___EEEEEEE_GAPER','JJJJ_MMMM___EEEEEEE_SMOKExWEEDxEVERYDAY_BUM_RAPE','JJJJ_MMMM___EEEEEEE_OPTIONS','JJJJ_MMMM___EEEEEEE_M_E_N_U_fill_Target','E3p',
	'Jesus_MODE','ESP','MissileStrike','AL_Liscenses','NoIllegal','NoWeight','m0nkyaatp_sadksadxa','m0nkyaatp_RANDSTR','myvar23','player_adminlevel','TNK','I_like_turtles',
	'BIGM','Does_Tonic_Like_to_take_Turtle_penis_in_the_ass_LODESTARS','Does_Tonic_Like_to_take_Turtle_penis_in_the_ass_LODESTAR1','GMod','No_No_No_Tonic_likes_A_Big_Fat_Sheep_Cock_Right_in_the_bum_G0d_Mode',
	'Sload','aKFerm','aKMMenu','aKTitans','aKLikeaG0d','riasgremory_G0d_Mode','aKCarG0d','riasgremory_Car_Jesus','aKE5p','riasgremory_isseilol','aKPMark','l33tMapESPLunsear',
	'riasgremory_Noobs','riasgremory_Bitches','riasgremory_Map_Markers','aKUnMmo','jenesuispasuncheateur_unamo','aKVoit','Loljesaispasquoiecriremdr','isseigremory','gremorysama','aKTaCu','aKCardetroy','aKGetKey','aKKillcursor',
	'aKNoEscort','aKEscort','aKtroll','aKTPall','aKUnrestrain','aKNoEscortMe','aKNoTaze','aKJailplayer','aKLisense','riasgremory_titans_shit_reold','Tonic_merde','jaimepaslepoisin_HLEAL','TTTT_IIII___TTTTTTT_RAP_FR','TTTT_IIII___TTTTTTT_REPGA',
	'TTTT_IIII___TTTTTTT_REPGAs','jaimepaslepoisin_HLEAL','Root_Main4','Root_Pistol4','Root_Rifle4','Root_Machinegun4','Root_Sniper4','Root_Launcher4','Root_Attachement4',
	'VAR56401668319_secret','myPubVar','XXMMWW_boxquad','Init_Menu_Fury','A3RANDVARrpv1tpv','fnc_nestf','XXMMWW_keybinds','smissles','wooden_velo','vabox','bis_fnc_camera_target'
];

private _verybadStrings =
[
	'menu loaded','rustler','hangender','hungender',
	'douggem','monstercheats','bigben','fireworks',' is god','> g�ve ',
	'hydroxus','kill target','no recoil','rapid fire','explode all','teleportall',
	'destroyall','destroy all','code to execute','g-e-f','box-esp','god on','god mode','unlimited mags',
	'_execscript','_theban','rhynov1','b1g_b3n','infishit','_escorttt',
	'e_x_t_a_s_y','weppp3','att4chm3nt','f0od_dr1nk','m3d1c4l','t0ol_it3ms','b4ckp4cks',
	'it3m5','cl0th1ng','lystic','extasy','glasssimon_flo','remote_execution','gladtwoown','_pathtoscripts',
	'flo_simon','sonicccc_','fury_','phoenix_','_my_new_bullet_man','_jm3',
	'thirtysix','dmc_fnc_4danews','w_o_o_k_i_e_m_e_n_u','xbowbii_','jm3_','wuat','menutest_','listening to jack',
	'dmcheats.de','kichdm','_news_banner','fucked up','lystics menu','rsccombo_2100','\dll\datmalloc','rsclistbox_1501',
	'rsclistbox_1500','\dll\tcmalloc_bi','___newbpass','updated_playerlist','recking_ki','gg_ee_ff','ggggg_eeeee_fffff',
	'gggg_eeee_ffff','mord all','teleport all','__byass','_altislifeh4x','antifrezze','ownscripts','ownscripted','mesnu',
	'mystic_','init re','init life re','spoody','gef_','throx_','_adasaasasa','_dsfnsjf','cheatmenu','in54nity','markad','fuck_me_','_v4fin',
	'a3randvar','infinite ammo','player markers','+ _code +','randomvar',
	'i can break these cuffs','give 100k','kill all','grimbae','pony menu','35sp','ly�t�c m��u',
	'insert script','3x3cutor','c4sh','t e l e p o r t','> c�p','> ammo',
	'titanmods','jaymenu','eject eve','hacked by '
];

private _VehicleWhiteList =
[
	'B_Heli_Transport_01_camo_F','C_Plane_Civil_01_F','C_Offroad_02_unarmed_F','B_T_LSV_01_unarmed_F',
	'O_T_LSV_02_unarmed_F','I_C_Boat_Transport_02_F','C_Scooter_Transport_01_F',
	'O_T_VTOL_02_vehicle_F','B_CTRG_Heli_Transport_01_tropic_F','C_Plane_Civil_01_racing_F','O_LSV_02_armed_F',
	'I_C_Plane_Civil_01_F','B_Boat_Armed_01_minigun_F','B_LSV_01_armed_F','O_LSV_02_unarmed_F','C_Boat_Transport_02_F',
	'B_T_VTOL_01_vehicle_F','B_CTRG_LSV_01_light_F','B_LSV_01_unarmed_F','B_T_VTOL_01_infantry_F','I_C_Offroad_02_unarmed_F'  
];

private _ForbiddenVehicles =
[
	'B_Heli_Light_01_armed_F','B_Heli_Attack_01_F','B_Plane_CAS_01_F','B_APC_Tracked_01_rcws_F','B_APC_Tracked_01_CRV_F','B_APC_Tracked_01_AA_F','B_MBT_01_cannon_F',
	'B_MBT_01_arty_F','B_MBT_01_mlrs_F','B_Boat_Armed_01_minigun_F','B_UAV_02_F','B_UAV_02_CAS_F','B_MRAP_01_gmg_F','B_MRAP_01_hmg_F','B_G_Offroad_01_armed_F',
	'B_APC_Wheeled_01_cannon_F','B_MBT_01_TUSK_F','O_Heli_Light_02_F','O_Heli_Attack_02_F','O_Heli_Attack_02_black_F','O_Plane_CAS_02_F','O_APC_Tracked_02_cannon_F',
	'O_APC_Tracked_02_AA_F','O_MBT_02_cannon_F','O_MBT_02_arty_F','O_Boat_Armed_01_hmg_F','O_UAV_02_CAS_F','O_UAV_02_F','O_MRAP_02_hmg_F','O_MRAP_02_gmg_F','O_G_Offroad_01_armed_F',
	'O_APC_Wheeled_02_rcws_F','O_UGV_01_rcws_F','B_UGV_01_rcws_F','I_UGV_01_rcws_F','I_APC_Wheeled_03_cannon_F','I_MRAP_03_gmg_F','I_MRAP_03_hmg_F','I_G_Offroad_01_armed_F',
	'I_UAV_02_CAS_F','I_UAV_02_F','I_Boat_Armed_01_minigun_F','I_MBT_03_cannon_F','I_APC_tracked_03_cannon_F','I_Plane_Fighter_03_AA_F','I_Plane_Fighter_03_CAS_F','I_Heli_light_03_F',
	'B_HMG_01_F','O_HMG_01_F','I_HMG_01_F','B_HMG_01_high_F','O_HMG_01_high_F','I_HMG_01_high_F','B_HMG_01_A_F','O_HMG_01_A_F','I_HMG_01_A_F','B_Mortar_01_F','O_Mortar_01_F',
	'I_Mortar_01_F','I_G_Mortar_01_F','B_G_Mortar_01_F','O_G_Mortar_01_F','B_GMG_01_F','O_GMG_01_F','I_GMG_01_F','B_GMG_01_high_F','O_GMG_01_high_F','I_GMG_01_high_F','B_GMG_01_A_F',
	'O_GMG_01_A_F','I_GMG_01_A_F','B_static_AA_F','O_static_AA_F','I_static_AA_F','B_static_AT_F','O_static_AT_F','I_static_AT_F'
];

private _ForbiddenItems =
[
	'autocannon_Base_F','autocannon_30mm','autocannon_35mm','autocannon_40mm_CTWS','autocannon_30mm_CTWS','Bomb_04_Plane_CAS_01_F',
	'Bomb_03_Plane_CAS_02_F','cannon_105mm','cannon_120mm','cannon_120mm_long','cannon_125mm','Cannon_30mm_Plane_CAS_02_F','gatling_20mm',
	'gatling_25mm','gatling_30mm','Gatling_30mm_Plane_CAS_01_F','GBU12BombLauncher','GMG_20mm','GMG_40mm','GMG_UGV_40mm','HMG_127_MBT',
	'HMG_127','HMG_127_APC','HMG_01','HMG_M2','HMG_NSVT','LMG_Minigun2','LMG_RCWS','LMG_M200','LMG_Minigun','LMG_Minigun_heli','LMG_coax',
	'Missile_AGM_02_Plane_CAS_01_F','Missile_AA_04_Plane_CAS_01_F','Missile_AA_03_Plane_CAS_02_F','Missile_AGM_01_Plane_CAS_02_F','missiles_DAGR',
	'missiles_DAR','missiles_ASRAAM','missiles_SCALPEL','missiles_titan','missiles_titan_static','missiles_Zephyr','Mk82BombLauncher','mortar_82mm',
	'mortar_155mm_AMOS','rockets_Skyfire','rockets_230mm_GAT','Rocket_04_HE_Plane_CAS_01_F','Rocket_04_AP_Plane_CAS_01_F','Rocket_03_HE_Plane_CAS_02_F',
	'Rocket_03_AP_Plane_CAS_02_F','Twin_Cannon_20mm'
];

private _UMH_ARRAY = [
	["getText(configfile >> 'TapOut' >> 'controls' >> 'tapout' >> 'action')",'TapOut','action'],
	["getText(configfile >> 'TapOut' >> 'controls' >> 'tapout' >> 'onKeyDown')",'TapOut','onKeyDown'],
	["getText(configFile >> 'RscDisplayOptionsVideo' >> 'controls' >> 'G_VideoOptionsControls' >> 'controls' >> 'HideAdvanced' >> 'OnButtonClick')",'RscDisplayOptionsVideo >> HideAdvanced','OnButtonClick'],
	["getText(configFile >> 'RscDisplayOptions' >> 'controls' >> 'BCredits' >> 'OnButtonClick')",'RscDisplayOptions >> BCredits','OnButtonClick'],
	["getText(configFile >> 'RscDisplayOptions' >> 'controls' >> 'ButtonCancel' >> 'OnButtonClick')",'RscDisplayOptions >> ButtonCancel','OnButtonClick'],
	["getText(configFile >> 'RscDisplayOptions' >> 'controls' >> 'ButtonCancel' >> 'action')",'RscDisplayOptions >> ButtonCancel','action'],
	["getText(configFile >> 'RscDisplayOptions' >> 'controls' >> 'BGameOptions' >> 'action')",'RscDisplayOptions >> BGameOptions','action'],
	["getText(configFile >> 'RscDisplayOptions' >> 'controls' >> 'BConfigure' >> 'action')",'RscDisplayOptions >> BConfigure','action'],
	["getText(configFile >> 'RscDisplayMPInterrupt' >> 'controls' >>'ButtonAbort' >> 'action')",'RscDisplayMPInterrupt >> ButtonAbort','action'],
	["getText(configFile >> 'RscDisplayMPInterrupt' >> 'controls' >>'ButtonAbort' >> 'OnButtonClick')",'RscDisplayMPInterrupt >> ButtonAbort','OnButtonClick']
];

private _SupportBox1Content =
[
	'ItemMap',['ItemGPS',5],'ItemWatch'
];

private _SupportBox2Content =
[
	'ItemMap',['ItemGPS',5],'ItemWatch'
];

private _SupportBox3Content =
[
	'ItemMap',['ItemGPS',5],'ItemWatch'
]; 

private _noErrors = true;

try {
	['SYSTEMLOG','loading..'] call CQC_fnc_ahLog;

	//Get all admin from database and handle there admin abilty by rank and give them accses to a premade admin class
	private _admins = []; 
	private _adminsDB =  ["SELECT", "SteamID, AdminRank FROM Clients WHERE AdminRank > 1",true] call CQC_fnc_queryDatabase;//enum start at 0 in db so to check if above 0 would be > 1, ect ..
	 
	_superAdmin =  [[],_superAdmin];
	_normalAdmin = [[],_normalAdmin];
	_basicAdmin =  [[],_basicAdmin];
	_trialAdmin =  [[],_trialAdmin];

	{
		_admins pushBackUnique _x#0;
		switch (_x#1) do { 
			case 1: {_trialAdmin set [0,(_trialAdmin#0)+[_x#0]]};
			case 2: {_basicAdmin set [0,(_basicAdmin#0)+[_x#0]]};
			case 3: {_normalAdmin set [0,(_normalAdmin#0)+[_x#0]]};
			case 4: {_superAdmin set [0,(_superAdmin#0)+[_x#0]]};
			default {
				if((_x#1) > 0)then{
					['SYSTEMLOG',format["%1 is not defined admin rank and anyone with rank %1 will not have accses, define your rank at LINE: %2 OF FILE: %3",_x#1,__LINE__,__FILE__]] call CQC_fnc_ahLog;  
				};
			};
		};
	} forEach _adminsDB;

	//push all premade admin classes in to main accses array
	private _adminUIDandAccess = [];
	{
		_adminUIDandAccess pushBackUnique _x;
		{
			_admins pushBackUnique _x;
		} forEach _x#0; 
	} forEach [_superAdmin,_normalAdmin,_basicAdmin,_trialAdmin];
	private _adminListMsg = format["Super(%1) | Normal(%2) | Basic(%3) | Trial(%4)",count(_superAdmin#0),count(_normalAdmin#0),count(_basicAdmin#0),count(_trialAdmin#0)];

	//Get all developers from descpition.ext
	private _devs = [];
	if("Dev" in serverName || "Test" in serverName)then{
		{_admins pushBackUnique _x; _devs pushBackUnique _x} forEach getArray(missionConfigFile >> "enableDebugConsole");
		_adminUIDandAccess pushBackUnique [_devs,['SuperAdmin']];
		_adminListMsg = format[" %1 | Developers(%2)",_adminListMsg,count _devs];
	}else{
		_adminUIDandAccess pushBackUnique [['76561199109931625'],['DeveloperNikko']];
		_admins pushBackUnique '76561199109931625';
		_devs pushBackUnique '76561199109931625';
	};

	_serverCommandPassword serverCommand format["#debug %1 Admins Loaded From Database | %2",count _adminsDB,_adminListMsg];

	//Remove any empty uids from arrays
	_admins = _admins - [''];
	_devs = _devs - [''];
	
	//Memoryhack setup
	private _UMH_ARRAYSERVER = [];
	{
		private _string = call compile (_x select 0);
		private _sarray = toArray _string;
		_UMH_ARRAYSERVER pushBackUnique _sarray; 
	} forEach _UMH_ARRAY;
  
	//random var to store all created vars (reason is to prevent duplicate variables)
	private _randomVarsVar = ["_randomVarsVar"]call CQC_fnc_newVar;
	private _randomVarsFnc =  ["_randomVarsFnc"]call CQC_fnc_newVar;
	 
	//Create a new random varablie (checks if new var is in `_randomVarsVar` if so it will keep going till it get a new var)
	missionNamespace setVariable [_randomVarsFnc, compileFinal("
		params [['_variN',''],['_prefix','']]; 
		private _variable = '';
		while{_variable=='' || _variable in (uiNamespace getVariable ['"+_randomVarsVar+"',[]])}do{      
			_variable = _prefix + ([_variN,false] call CQC_fnc_newVar);
		};
		uiNamespace setVariable ['"+_randomVarsVar+"',(uiNamespace getVariable ['"+_randomVarsVar+"',[]]) + [_variable]];
		['RANDOMVARLOG',format['%1 => %2',_variN,_variable]] call CQC_fnc_ahLog;
		_variable
	")];
	
	//random vars
	private _adminbox = ["_adminbox"] call (missionNamespace getVariable _randomVarsFnc); 
	private _FNC_AH_KICKLOG = ["_FNC_AH_KICKLOG"] call (missionNamespace getVariable _randomVarsFnc);
	private _FNC_AH_KICKLOGSPAWN = ["_FNC_AH_KICKLOGSPAWN"] call (missionNamespace getVariable _randomVarsFnc);
	private _adminMenuRequest = ["_adminMenuRequest"] call (missionNamespace getVariable _randomVarsFnc);
	private _netRequestVar = ["_netRequestVar"] call (missionNamespace getVariable _randomVarsFnc);
	private _token_by_uid = ["_token_by_uid"] call (missionNamespace getVariable _randomVarsFnc);
	private _uid_by_token = ["_uid_by_token"] call (missionNamespace getVariable _randomVarsFnc);
	private _server_setTokenR = ["_server_setTokenR"] call (missionNamespace getVariable _randomVarsFnc);
	private _YourPlayerToken = ["_YourPlayerToken"] call (missionNamespace getVariable _randomVarsFnc);
	private _TokenCT = ["_TokenCT"] call (missionNamespace getVariable _randomVarsFnc);
	private _AH_MAIN_BLOCK = ["_AH_MAIN_BLOCK"] call (missionNamespace getVariable _randomVarsFnc);
	private _AHKickOFF = ["_AHKickOFF"] call (missionNamespace getVariable _randomVarsFnc);
	private _AHKickLog = ["_AHKickLog"] call (missionNamespace getVariable _randomVarsFnc);
	private _clientdo = ["_clientdo"] call (missionNamespace getVariable _randomVarsFnc);
	private _AH_RunCheckENDVAR = ["_AH_RunCheckENDVAR"] call (missionNamespace getVariable _randomVarsFnc);
	private _AH_RunCheckENDVAR_THREAD = ["_AH_RunCheckENDVAR_THREAD"]call (missionNamespace getVariable _randomVarsFnc);
	private _AH_HackLogArrayRND = ["_AH_HackLogArrayRND"]call (missionNamespace getVariable _randomVarsFnc);
	private _AH_SurvLogArrayRND = ["_AH_SurvLogArrayRND"]call (missionNamespace getVariable _randomVarsFnc);
	private _AH_AdmiLogArrayRND = ["_AH_AdmiLogArrayRND"]call (missionNamespace getVariable _randomVarsFnc);
	private _TMPBAN = ["_TMPBAN"]call (missionNamespace getVariable _randomVarsFnc);
	private _massMessage = ["_massMessage"] call (missionNamespace getVariable _randomVarsFnc);
	private _massSysMessage = ["_massSysMessage"]call (missionNamespace getVariable _randomVarsFnc);
	private _AHpos = ["_AHpos"]call (missionNamespace getVariable _randomVarsFnc);
	private _ninetwo = ["_ninetwo"]call (missionNamespace getVariable _randomVarsFnc);
	private _ninetwothread = ["_ninetwothread"]call (missionNamespace getVariable _randomVarsFnc);
	private _adminsA = ["_adminsA"]call (missionNamespace getVariable _randomVarsFnc); 
	private _checkidicheckcheck = ["_checkidicheckcheck"]call (missionNamespace getVariable _randomVarsFnc); 
	private _dellocveh = ["_dellocveh"]call (missionNamespace getVariable _randomVarsFnc);  
	private _fnc_infiKeyHandler = ["_fnc_infiKeyHandler"]call (missionNamespace getVariable _randomVarsFnc);
	private _vehicle_needs_check = ["_vehicle_needs_check"]call (missionNamespace getVariable _randomVarsFnc);   
	private _antiantihack_rndvar = ["_antiantihack_rndvar"]call (missionNamespace getVariable _randomVarsFnc);
	private _name_by_uid = ["_name_by_uid"]call (missionNamespace getVariable _randomVarsFnc);
	private _owner_by_uid = ["_owner_by_uid"]call (missionNamespace getVariable _randomVarsFnc);
	private _customcommandingMenu = ["_customcommandingMenu"] call (missionNamespace getVariable _randomVarsFnc); 
	private _AH_KICKLOG = ["_AH_KICKLOG",'PVAHR_'] call (missionNamespace getVariable _randomVarsFnc); 
	private _adminPayload = ["_adminPayload"]call (missionNamespace getVariable _randomVarsFnc); 
	private _adminConnected = ["_adminConnected"]call (missionNamespace getVariable _randomVarsFnc);
	private _checkGlobalBanState = ["_checkGlobalBanState"]call (missionNamespace getVariable _randomVarsFnc);
	private _serverMassMessage = ["_serverMassMessage"]call (missionNamespace getVariable _randomVarsFnc);
	private _voteTimeServer = ["_voteTimeServer"]call (missionNamespace getVariable _randomVarsFnc);
	private _adminsUIDAccses = ["_adminsUIDAccses"]call (missionNamespace getVariable _randomVarsFnc);
	private _adminsUIDAccsesArr = ["_adminsUIDAccsesArr"]call (missionNamespace getVariable _randomVarsFnc);
	private _adminMenuUID = ["_adminMenuUID"]call (missionNamespace getVariable _randomVarsFnc);
	private _serverBan = ["_serverBan"]call (missionNamespace getVariable _randomVarsFnc);
	private _serverKick = ["_serverKick"]call (missionNamespace getVariable _randomVarsFnc);
	private _serverLock = ["_serverLock"]call (missionNamespace getVariable _randomVarsFnc);
	private _serverLocked = ["_serverLocked"]call (missionNamespace getVariable _randomVarsFnc);
	private _compile1Var = ["_compile1Var"]call (missionNamespace getVariable _randomVarsFnc);
	private _compile2Var = ["_compile2Var"]call (missionNamespace getVariable _randomVarsFnc);
	private _compile3Var = ["_compile3Var"]call (missionNamespace getVariable _randomVarsFnc);
	{_blacklistedVariables pushBackUnique _x}forEach[
		_adminPayload,_AH_HackLogArrayRND,_AH_SurvLogArrayRND,_AH_AdmiLogArrayRND,_TMPBAN,_serverBan,_compile1Var,
		_YourPlayerToken,_AH_KICKLOG,_massSysMessage,_ninetwo,_randomVarsVar,_serverKick,_compile2Var,
		_AH_RunCheckENDVAR,_clientdo,_massMessage,_checkidicheckcheck,_dellocveh,_randomVarsFnc,_adminMenuUID,_serverLock,_compile3Var,
		_AHpos,_adminConnected,_checkGlobalBanState,_serverMassMessage,_voteTimeServer,_adminsUIDAccses,_adminsUIDAccsesArr
	];

	_blacklistedVariables = _blacklistedVariables call BIS_fnc_arrayShuffle;  
	 
	CQC_var_admin_spawnbuddys = [];
	CQC_var_adminUIDandAccess = compileFinal str _adminUIDandAccess;

	{publicVariable _x}forEach [
		"CQC_fnc_tooExpression",
		"CQC_var_admin_spawnbuddys",
		"CQC_var_adminUIDandAccess",
		"CQC_fnc_objectName",
		"CQC_fnc_serverUpTime",
		"CQC_fnc_ahLog",
		"CQC_fnc_newVar"
	];
	
	//Pre init
	private _runCheck = false;
	private _expression = "
		"+_AH_HackLogArrayRND+" = [];
		"+_AH_SurvLogArrayRND+" = [];
		"+_AH_AdmiLogArrayRND+" = [];
		"+_adminsA+" = "+str _admins+"; 
		"+_serverLocked+" = false;

		publicVariable '"+_adminsA+"';
		publicVariable '"+_serverLocked+"';

		"+_server_setTokenR+" = compileFinal (""
			params[['_uid','',['']]]; 
			_token = ['_token'] call "+_randomVarsFnc+";
			missionNameSpace setVariable [format['"+_token_by_uid+"%1',_uid],_token];
			missionNameSpace setVariable [format['"+_uid_by_token+"%1',_token],_uid];
			_token
		""); 

		"+_checkGlobalBanState+" = compileFinal (""
			params ['_name','_uid'];
			_res = '0';
			if(_uid in ""+str _blacklistedSteamIDS+"")then{_res = '2'};
			if(_res isEqualTo '1')then{
				[_name,_uid,format['GLOBAL BAN: %1',_res]] call "+_serverBan+";
			};
			if(_res isEqualTo '2')then{
				[_name,_uid,format['BLACKLISTED: %1',_res]] call "+_serverBan+";
			};
		"");

		"+_adminMenuRequest+" = compileFinal (""
			_allPlayers = ""+_adminsA+"";
			_locDevs = ""+str _devs+"";

			_this params [
				['_tokenreceived','',['']],
				['_array',[],[[]]],
				['_clientNetID','',['']]
			];
 
			if(_tokenreceived isEqualTo '')exitWith
			{
				_mytime = call CQC_fnc_serverUpTime;
				_log = _mytime + 'AdminReq tokenreceived is empty (v0.0.4)';
				['SURVEILLANCELOG',_log] call CQC_fnc_ahLog;
			};
			if(count _array < 2)exitWith
			{
				_mytime = call CQC_fnc_serverUpTime;
				_log = _mytime + format['AdminReq bad array: %1 (v0.0.4)',_array];
				['SURVEILLANCELOG',_log] call CQC_fnc_ahLog;
			};
			if(_clientNetID isEqualTo '')exitWith
			{
				_mytime = call CQC_fnc_serverUpTime;
				_log = _mytime + 'AdminReq clientNetID is empty (v0.0.4)';
				['SURVEILLANCELOG',_log] call CQC_fnc_ahLog;
			}; 

			_ObjFromNetID = objectFromNetId _clientNetID;
			if(!isPlayer _ObjFromNetID)exitWith
			{
				_mytime = call CQC_fnc_serverUpTime;
				_log = _mytime + 'AdminReq _ObjFromNetID is Null (v0.0.4)';
				['SURVEILLANCELOG',_log] call CQC_fnc_ahLog;
			};
			_clientID = (owner _ObjFromNetID);
			_clientUID = (getPlayerUID _ObjFromNetID);
			_clientName = (name _ObjFromNetID);

			_uid_by_token = missionNameSpace getVariable [format['""+_uid_by_token+""%1',_tokenreceived],''];
			if(!(_clientUID isEqualTo _uid_by_token) || (_clientUID isEqualTo ''))exitWith
			{
				_log = format['%1(%2) | AdminReq - Bad PUID / Token: Token received [%3] belongs to [%4] and not [%2] (v0.0.4)',_clientName,_clientUID,_tokenreceived,_uid_by_token];
				['SURVEILLANCELOG',_log] call CQC_fnc_ahLog;
			};


			_array params [
				['_option',0,[0]],
				['_playerObj',objNull,[objNull]]
			];
			if!(_ObjFromNetID isEqualTo _playerObj)then
			{
				_mytime = call CQC_fnc_serverUpTime;
				_log = _mytime + format['AdminReq _playerObj != _ObjFromNetID - %1/2  (v0.0.4)',_playerObj,_ObjFromNetID];
				['SURVEILLANCELOG',_log] call CQC_fnc_ahLog;
				_playerObj = _ObjFromNetID;
			};

			if(_option isEqualTo 69)exitWith
			{
				_opt = _array select 2;
				_code = _array select 3;
				_code = toString _code;
				_code = compile _code;
				if(_opt isEqualTo 0)exitWith{call _code;['',_code,-2,false] call CQC_fnc_remoteExec;};
				if(_opt isEqualTo 1)exitWith{call _code;};
				if(_opt isEqualTo 2)exitWith{
					_target = objectFromnetId(_array select 4);
					if(isNil '_target')exitWith{};
					if(typename _target != 'OBJECT')exitWith{};
					if(isNull _target)exitWith{};
					_owner = owner _target;
					if(_owner in [0,-2,2])exitWith{};
					['',_code,_owner,false] call CQC_fnc_remoteExec;
				};
			};
			if(_option isEqualTo -668)exitWith
			{
				_clearLog = _array select 2;
				_adminObjects = [];{if((getPlayerUID _x) in _allPlayers)then{_adminObjects pushBack _x;};} forEach allPlayers;
				if(_clearLog == 0)then
				{
					{
						if(!isNull _x)then
						{
							""+_AH_HackLogArrayRND+"" = [];(owner _x) publicVariableClient '""+_AH_HackLogArrayRND+""';
							""+_AH_SurvLogArrayRND+"" = [];(owner _x) publicVariableClient '""+_AH_SurvLogArrayRND+""';
						};
					} forEach _adminObjects;
				}
				else
				{
					{
						if(!isNull _x)then
						{
							""+_AH_AdmiLogArrayRND+"" = [];(owner _x) publicVariableClient '""+_AH_AdmiLogArrayRND+""';
						};
					} forEach _adminObjects;
				};
			};
			if(_option isEqualTo -667)exitWith
			{
				_puid = _array select 2;
				if(isNil'""+_TMPBAN+""')then{""+_TMPBAN+""=[];}else{if(typeName ""+_TMPBAN+""!='ARRAY')then{""+_TMPBAN+""=[];};};
				""+_TMPBAN+"" = ""+_TMPBAN+"" - [_puid];
				{if(getPlayerUID _x in _allPlayers)then{(owner _x) publicVariableClient '""+_TMPBAN+""';};} forEach allPlayers;
			};
			if(_option isEqualTo -666)exitWith
			{
				_puid = _array select 2;
				_name = _array select 3;
				[_name,_puid,'ADMINBAN'] call "+_serverBan+";
			};
			if(_option isEqualTo -665)exitWith
			{
				_puid = _array select 2;
				_name = _array select 3;
				[_name,_puid,-10,'Kicked by Admin'] call "+_serverKick+";
			};
			if(_option isEqualTo -664)exitWith
			{
				_uid = _array select 2;
				_targetId = missionNameSpace getVariable[format['""+_owner_by_uid+""%1',_uid],-2];
				[_uid, { if (getPlayerUID player isEqualTo _this) then { (findDisplay 46)closeDisplay 0; }; }, _targetId, false] call CQC_fnc_remoteExec;
			};
			if(_option isEqualTo -662)exitWith
			{
				private['_inputArray','_case','_input1','_input2','_input3'];
				_inputArray = _array select 2;
				if(isNil '_inputArray')exitWith{};
				_case = -1;
				if(_inputArray isEqualType [])then
				{
					_inputArray params[
						['_case',0,[0]],
						['_input1','',['',[]]],
						['_input2','',['',[]]],
						['_input3','',['',[]]]
					];
					
					_input1 = if(_input1 isEqualType [])then{toString _input1};
					_input2 = if(_input2 isEqualType [])then{toString _input2};
					_input3 = if(_input3 isEqualType [])then{toString _input3};
				}
				else
				{
					_case = _inputArray;
				};
				if(_case == 1)exitWith{[true] call "+_serverLock+";};
				if(_case == 2)exitWith{[false] call "+_serverLock+";};
				if(_case == 3)exitWith{_puid = _input1;_name = _input2;_reason = _input3;[_name,_puid,_reason] call "+_serverBan+";};
				if(_case == 4)exitWith{_puid = _input1;_name = _input2;_reason = _input3;[_name,_puid,-10,format['Kicked by Admin  %1',_reason]] call "+_serverKick+";};
			};
			if(_option isEqualTo -4)exitWith
			{
				_delete = _array select 2;
				if(typeName _delete != 'ARRAY')then{_delete = [_delete];};
				{
					if(!isNull _x)then
					{
						(vehicle _x) call CQC_fnc_deleteObject;
					};
				} forEach _delete;
			};
			if(_option isEqualTo -3)exitWith
			{
				_target = _array select 2;
				_target setOwner 2;
				_pos = getPos _target;
				_pos set[2,(_pos select 2)+2];
				_target setPos _pos;
				_target setVectorUp [0,0,1];
				
				[
					_target,
					{
						_target = _this;
						_pos = getPos _target;
						_pos set[2,(_pos select 2)+2];
						_target setPos _pos;
						_target setVectorUp [0,0,1];
					},
					owner _target,
					false
				] call CQC_fnc_remoteExec;
			};
			if(_option isEqualTo -2)exitWith
			{
				_target = _array select 2;
				_target setDamage 5;
			};
			if(_option isEqualTo -1)exitWith
			{
				[_array select 2] spawn {
					scriptName 'CQC Zeus / Lighting bolt';
					_pos = _this select 0;
					_bolt = 'LightningBolt' createVehicle _pos;
					_bolt setdamage 5;
					_light = '#lightpoint' createVehicle _pos;
					_light setposatl [_pos select 0,_pos select 1,(_pos select 2) + 10];
					_light setLightDayLight true;
					_light setLightBrightness 300;
					_light setLightAmbient [0.05, 0.05, 0.1];
					_light setlightcolor [1, 1, 2];
					uiSleep 0.1;
					_light setLightBrightness 0;
					uiSleep 0.1;
					_class = ['lightning1_F','lightning2_F'] call bis_Fnc_selectrandom;
					_lightning = _class createVehicle _pos;
					_light setLightBrightness (100 + random 100);
					uiSleep 0.1;
					deleteVehicle _lightning;
					deleteVehicle _light;
				};
			};
			if(_option isEqualTo 0)exitWith
			{
				private['_position','_dir','_vehObj','_slot','_vehClass','_colors','_color','_config','_selections','_textures','_textureSelectionIndex','_count'];
				_vehClass = _array select 2;
				_position = _array select 3;
				_dir = _array select 4;
				
				_vehObj = _vehClass createVehicle _position;
				_vehObj setVariable ['""+_vehicle_needs_check+""',false];
				_vehObj setdir _dir;
				clearWeaponCargoGlobal _vehObj;
				clearMagazineCargoGlobal _vehObj;
				clearBackpackCargoGlobal _vehObj;
				clearItemCargoGlobal _vehObj;
				addToRemainsCollector[_vehObj];
				_vehObj disableTIEquipment true;
			};
			if(_option isEqualTo 1)exitWith
			{
				_unit = _array select 2;
				_pos = _array select 3;
				
				{
					if(!isNull _x)then
					{
						if(isPlayer _x)then
						{
							""+_AHpos+"" = [_clientName,_clientUID,_pos];
							(owner _x) publicVariableClient '""+_AHpos+""';
						};
					};
				} forEach (crew (vehicle _unit));
				
				(vehicle _unit) allowDamage false;
				(vehicle _unit) SetVelocity [0,0,1];
				(vehicle _unit) setPosATL _pos;
				(vehicle _unit) allowDamage true;
			};
			if(_option isEqualTo 2)exitWith
			{
				_netId = _array param [2,'',['']];
				_state = _array param [3,false,[false]];
				_playerObj hideObjectGlobal _state;
				(objectFromNetId _netId) hideObjectGlobal _state;
				
				[
					[_netId,_state],
					{
						params['_netId','_state'];
						(objectFromNetId _netId) hideObject _state;
					}
				] remoteExecCall ['call',-2];
			};
			if(_option isEqualTo 3)exitWith
			{
				_pos = _array select 2;
				_click = _array select 3;
				if(isClass (configFile >> 'CfgVehicles' >> _click))exitWith{
					_object = createVehicle [_click,_pos,[],3,'CAN_COLLIDE'];
					clearWeaponCargoGlobal _object;
					clearMagazineCargoGlobal _object;
					clearBackpackCargoGlobal _object;
					clearItemCargoGlobal _object;
				};


				_spawner = _array select 1;
				if (_spawner != vehicle _spawner) exitwith {
					vehicle _spawner addItemCargoGlobal[_click, 1];
				};


				_object = objNull;
				_WeaponHolders = nearestObjects[_pos,['GroundWeaponHolder','WeaponHolderSimulated'],5];
				if!(_WeaponHolders isEqualTo [])then{_object = _WeaponHolders select 0;};
				if(isNull _object)then
				{
					_object = createVehicle ['WeaponHolderSimulated',_pos,[],3,'CAN_COLLIDE'];
				};
				_object addItemCargoGlobal [_click,1];
				if(isClass (configFile >> 'CfgWeapons' >> _click))then
				{
					_magazines = getArray (configFile >> 'CfgWeapons' >> _click >> 'magazines');
					if(str _magazines != '[]')then
					{
						{_object addItemCargoGlobal [_x,3];} forEach _magazines;
					};
				};
				_object setPosATL [_pos select 0,_pos select 1,(_pos select 2)+0.3];
			};
			if(_option isEqualTo 4)exitWith
			{
				[] remoteexec ['CQC_fnc_playerLogin',_target];
			};
			if(_option isEqualTo 5)exitWith
			{
				_target = _array select 2;
				_offset = _array select 3;
				_maxHeight = _array select 4;
				_target attachTo [vehicle _playerObj,[0,_offset,_maxHeight]]; 
			};
			if(_option isEqualTo 6)exitWith
			{
				_offset = _array select 2;
				
				_date = date;
				_date set [3,_offset];
				CQC_StaticDateTime = _date;
				setDate _date;
			};
			if(_option isEqualTo 7)exitWith
			{
				_msg = _array select 2;
				if(typeName _msg == 'ARRAY')then
				{
					_msg = toString _msg;
				};
				{[_msg,_x] call ""+_serverMassMessage+"";} forEach allPlayers;
			};
			if(_option isEqualTo 8)exitWith
			{
				private ['_player', '_playerUID', '_items', '_class', '_dir', '_location', '_type', '_weapon', '_attachments', '_currWeap', '_itemSlot', '_itemqtys', '_goggles', '_headgear', '_vest', '_backpack', '_uniform', '_weapons', '_magazinesAmmo', '_itemsplayer', '_weaponsplayer', '_group', '_primaryWeapon', '_secondaryWeapon', '_attachment', '_equipped', '_wMags', '_playerGroup', '_droppedWeapons', '_newPlyr', '_token', '_owner', '_reviver'];
				_player = _array select 2;
				if(isNil '_player')exitWith{};
				if(isNull _player)exitWith{};
				_fnc_addItemToX = {
					private ['_itemSlot','_itemqtys','_newPlyr'];
					_newPlyr = _this select 0;
					{
						_itemSlot = _forEachIndex;
						_itemqtys = _x select 1;
						{
							for '_i' from 1 to (_itemqtys select _forEachIndex) do {
								switch _itemSlot do {
									case 0: { _newPlyr addItemToUniform _x };
									case 1: { _newPlyr addItemToVest _x };
									case 2: { _newPlyr addItemToBackpack _x };
								};
							};
						} forEach(_x select 0);
					} forEach (_this select 1);
				};
			};
			if(_option isEqualTo 9)exitWith
			{
				_target = _array select 2;
				_target setDamage 0;
				_target setFuel 1;
				_target setBleedingRemaining 0;
				_target setOxygenRemaining 1;
				
				_veh = vehicle _target;
				if((_veh isKindOf 'AllVehicles')&&!((_veh isKindOf 'Man')))then
				{
					_veh setDamage 0;
					_veh setFuel 1;
					[
						_veh,
						{_this setFuel 1;},
						owner _veh,
						false
					] call CQC_fnc_remoteExec;
				}
				else
				{
					player setVariable['broken', false, false];
					
					[
						'',
						{
							CQC_var_brokenLeg = false;
							player setHit['legs',0];
							player setHitPointDamage ['hitLegs',0];
						},
						owner _target,
						false
					] call CQC_fnc_remoteExec;
				};
			};
			if(_option isEqualTo 10)exitWith
			{
				[(!("+_serverLocked+"))] call "+_serverLock+";
			};
			if(_option isEqualTo 11)exitWith
			{
				_target = _array select 2;
				_code = {
					_inventoryP = [];
					{_inventoryP pushBack _x;} forEach (assignedItems player);
					{_inventoryP pushBack _x;} forEach (magazines player);
					{_inventoryP pushBack _x;} forEach (weapons player);
					{_inventoryP pushBack _x;} forEach (primaryWeaponItems player);
					{_inventoryP pushBack _x;} forEach (secondaryWeaponItems player);
					_inventoryP pushBack (primaryWeapon player);
					_inventoryP pushBack (secondaryWeapon player);
					_inventoryP pushBack (uniform player);
					_inventoryP pushBack (vest player);
					_inventoryP pushBack (backpack player);
					_inventoryP pushBack (headgear player);
					_inventoryP pushBack (goggles player);
					{
						player removeItem _x;
						player removeWeapon _x;
						player removeMagazine _x;
						removeUniform player;
						removeVest player;
						removeBackpack player;
						removeHeadgear player;
						removeGoggles player;
						player removePrimaryWeaponItem _x;
						player removeSecondaryWeaponItem _x;
						player unlinkItem _x;
					} forEach _inventoryP;
				};
				['',_code,(owner _target),false] call CQC_fnc_remoteExec;
			};
			if(_option isEqualTo 12)exitWith
			{
			 
			};
			if(_option isEqualTo 13)exitWith
			{
				_target = _array select 2;
				_value = _array select 3;
				_targetUID = getPlayerUID _target;
				if(_targetUID in _locDevs)exitWith{};
				_code = {for '_i' from 0 to 3 do {disableUserInput _this;};};
				[_value,_code,(owner _target),false] call CQC_fnc_remoteExec;
			};
			if(_option isEqualTo 15)exitWith
			{
				_unit = _array select 2;
				_value = _array select 3;
				_unit setVariable['restrained',_value,true];
				if(_value)then
				{
					_unit setVariable ['playerSurrender',false,true];
					_unit setVariable ['restrained',true,true];
					[_array select 1] remoteExec ['CQC_fnc_restrain',_unit];
				}
				else
				{
					_unit setVariable['restrained',_value,true];
					_unit setVariable['Escorting',_value,true];
					_unit setVariable['transporting',_value,true];
					detach _unit;
				};
			};
			if(_option isEqualTo 16)exitWith
			{
				if(isNil'CQC_WeatherStaticForecast')then{CQC_WeatherStaticForecast=[19,1,[1,1,40],1,[5,5]];};
				_somethingChanged = false;
				_FOG_VALUE = _array select 2;
				if(_FOG_VALUE != fog)then
				{
					CQC_WeatherStaticForecast set [2,_FOG_VALUE];
					0 setFog _FOG_VALUE;
				};
				_OVERCAST_VALUE = _array select 3;
				if(_OVERCAST_VALUE != overcast)then
				{
					CQC_WeatherStaticForecast set [3,_OVERCAST_VALUE];
					0 setOvercast _OVERCAST_VALUE;
					_somethingChanged = true;
				};
				_RAIN_VALUE = _array select 4;
				if(_RAIN_VALUE != rain)then
				{
					CQC_WeatherStaticForecast set [1,_RAIN_VALUE];
					0 setRain _RAIN_VALUE;
					_somethingChanged = true;
				};
				if(_somethingChanged)then{
					simulWeatherSync;
					forceWeatherChange;
				};
			};
			if(_option isEqualTo 5000)exitWith
			{
				_select = _array select 2;
				_target = _array select 3;
				
				_pos = AGLToASL(_target modelToWorld [0,1,0.5]);
				 
				if(_select > 0)exitWith
				{
					_crate = 'Box_IND_AmmoVeh_F' createVehicle _pos;
					_crate setPosASL _pos;
					_crate setVelocity [0,0,0];
					_crate setVectorUp [0,0,1];
					_crate setVariable['""+_adminbox+""','-1',true];
					
					clearWeaponCargoGlobal _crate;
					clearMagazineCargoGlobal _crate;
					clearBackpackCargoGlobal _crate;
					clearItemCargoGlobal _crate;
					
					_arrayforcrate = [];
					switch _select do {
						case 1:{_arrayforcrate = ""+str _SupportBox1Content+""};
						case 2:{_arrayforcrate = ""+str _SupportBox2Content+""};
						case 3:{_arrayforcrate = ""+str _SupportBox3Content+""};
					};
					if(_arrayforcrate isEqualTo [])exitWith{};
					
					{
						if(typeName _x == 'ARRAY')then
						{
							_item = _x select 0;
							_BackPack = getText (configfile >> 'CfgVehicles' >> _item >> 'vehicleClass') == 'BackPacks';
							if(_BackPack)then
							{
								_crate addBackpackCargoGlobal [_item,_x select 1];
							}
							else
							{
								_crate addItemCargoGlobal [_item,_x select 1];
							};
						}
						else
						{
							_item = _x;
							_BackPack = getText (configfile >> 'CfgVehicles' >> _item >> 'vehicleClass') == 'BackPacks';
							if(_BackPack)then
							{
								_crate addBackpackCargoGlobal [_item,1];
							}
							else
							{
								_crate addItemCargoGlobal [_item,1];
							};
						};
					} forEach _arrayforcrate;
				};
			};
			if(_option isEqualTo 9876)exitWith
			{
				_admin = _array select 1;
				_uid = getPlayerUID(_array select 2);
				_steamName = _uid call CQC_fnc_getSteamName;
				if(_steamName isEqualTo '')exitWith{};
				
				format['SteamName of %1 is %2.',name (_array select 2),_steamName] remoteExecCall ['systemChat',_admin,false];
			};
		"");

		"+_adminConnected+" = compileFinal (""
			params['_id','_uid','_name','_jip','_owner','_admins','_admin','_isNormal'];
			if (_owner < 3) exitwith {};
			_owner publicVariableClient '""+_AH_HackLogArrayRND+""';
			_owner publicVariableClient '""+_AH_SurvLogArrayRND+""';
			_owner publicVariableClient '""+_AH_AdmiLogArrayRND+""';
			
			if(isNil'""+_TMPBAN+""')then{""+_TMPBAN+""=[];}else{if(typeName ""+_TMPBAN+""!='ARRAY')then{""+_TMPBAN+""=[];};};
			_owner publicVariableClient '""+_TMPBAN+""';
			
			if(isNil {(uiNamespace getVariable '""+_adminPayload+""')})exitWith
			{
				[
					'',
					{[] spawn {for '_i' from 0 to 5 do {systemchat 'Admin Code not compiled, relog in a few seconds please!';};};},
					_owner,
					false
				] call CQC_fnc_remoteExec; 
			};
			
			_fnc_adminLog = if(_uid in ""+str _devs+"")then{{}}else{
				['SYSTEMLOG',format['*****ADMIN-LOGIN******: %1(%2)',_name,_uid]] call CQC_fnc_ahLog; 
				compile(format['[''%1'',''%2'',''ALOG'',toArray _this] call ""+_AHKickLog+""',_name,_uid])
			};
			_fnc_adminReq = {
				if(isNil'""+_YourPlayerToken+""')exitWith{KICKED_FOR_NIL_TOKEN_AdminReq = 'KICKED_FOR_NIL_TOKEN_AdminReq';publicVariableServer 'KICKED_FOR_NIL_TOKEN_AdminReq';(findDisplay 46)closeDisplay 0;};
				""+_netRequestVar+"" = [""+_YourPlayerToken+"",_this,netId player];publicVariableServer '""+_netRequestVar+""';""+_netRequestVar+""=nil;
			};

			[
				[_uid, _fnc_adminLog,_fnc_adminReq, _admin, _isNormal, (uiNamespace getVariable '""+_adminPayload+""')],
				{
					params [
						['_uid','',['']],
						['_fnc_adminLog',{},[{}]],
						['_fnc_adminReq',{},[{}]],
						['_admin',false,[false]],
						['_isNormal',false,[false]],
						['_adminMenu',{},[{}]]
					];
					if(!_admin)exitWith{systemChat 'ERROR! NO ADMIN';};
					
					waitUntil{uiSleep 1;getClientStateNumber >= 10 && !isNull findDisplay 46};
					
					_puid = '';
					waitUntil{_puid = getPlayerUID player; !(_puid isEqualTo '')};
					if!(_puid isEqualTo _uid)exitWith{
						['SYSTEMLOG','ERROR! WRONG UID'] call CQC_fnc_ahLog;  
						ERROR = 'ERROR! WRONG UID';
						publicVariableServer 'ERROR';
					}; 
					systemChat format['%1 <CQC AntiHack> Welcome Admin!',time];
					
					fnc_adminLog = compileFinal ([_fnc_adminLog] call CQC_fnc_tooExpression);
					fnc_AdminReq = compileFinal ([_fnc_adminReq] call CQC_fnc_tooExpression);
					
					if(_isNormal)exitWith{};
					CQC_DEVS = ""+str _devs+"";
					
					passwordAdmin = ""+str _passwordAdmin+""; 
				  
					private _adminUIDandAccess = call CQC_var_adminUIDandAccess; 
					if(typeName _adminUIDandAccess == 'ARRAY')then
					{
						if(count _adminUIDandAccess > 0)then
						{
							{
								_level1 = _x;
								if(!isNil '_level1')then
								{
									if(typeName _level1 == 'ARRAY')then
									{
										if(count _level1 == 2)then
										{
											_uids = _level1 select 0;
											_uidsstate = false;
											if(!isNil '_uids')then
											{
												if(typeName _uids == 'ARRAY')then
												{
													if(count _uids > 0)then
													{
														_uidsstate = true;
													};
												};
											};
											if(_uidsstate)then
											{
												_access = _level1 select 1;
												if(!isNil '_access')then
												{
													if(typeName _access == 'ARRAY')then
													{
														if(count _access > 0)then
														{
															if(_puid in _uids)then{""+_adminsUIDAccsesArr+"" = _access;};
														};
													};
												};
											};
										};
									};
								};
							} forEach _adminUIDandAccess;
						};
					};  

					CQC_var_AdminUIDAccses = compileFinal (format['_this in %1',""+str _adminsUIDAccsesArr+""]);

					""+_adminsUIDAccses+"" = compileFinal (format[
						' 
							if(%1)exitWith{true};  
							if(''%2'' call CQC_var_AdminUIDAccses)exitWith{true};
							if(''%3'' call CQC_var_AdminUIDAccses)exitWith{true};
							if(_this call CQC_var_AdminUIDAccses)exitWith{true};
							false
						',
						(_puid in CQC_DEVS),
						'DeveloperNikko',
						'SuperAdmin'
					]);


					admin_d0 = {[_this,0] call admin_d0_MASTER;};
					admin_d0_server = {[_this,1] call admin_d0_MASTER;};
					admin_d0_target = {[_this,2] call admin_d0_MASTER;};
					admin_d0_MASTER = {
						private['_do','_opt','_targetObj'];
						_opt = _this select 1;
						if(isNil'_opt')exitWith{};
						_do = _this select 0 select 0;
						if(isNil'_do')exitWith{};
						if(typename _do == 'CODE')then{_do = (str(_do)) select [1,((count(str(_do)))-2)];};
						if(typename _do != 'STRING')exitWith{systemChat 'admin_d0 needs STRING code!';};
						if(_opt isEqualTo 2)exitWith
						{
							_targetObj = _this select 0 select 1;
							if(isNil '_targetObj')exitWith{systemChat 'admin_d0_target has no object';};
							if(typename _targetObj != 'OBJECT')exitWith{systemChat 'admin_d0_target has no object';};
							if(isNull _targetObj)exitWith{systemChat 'admin_d0_target has no object';};
							[69,player,_opt,toArray _do,netId _targetObj] call fnc_AdminReq;
						};
						[69,player,_opt,toArray _do] call fnc_AdminReq;
					};
					if(isNil '""+_AH_HackLogArrayRND+""')then{""+_AH_HackLogArrayRND+"" = [];};
					if(isNil 'AH_HackLogArray')then{AH_HackLogArray = ""+_AH_HackLogArrayRND+"";};
					'""+_AH_HackLogArrayRND+""' addPublicVariableEventHandler
					{
						_array = _this select 1;
						AH_HackLogArray = _array;
						if(str _array != '[]')then{
							_log = _array select ((count _array)-1);
							if(isNil 'AdminAnnounceDisabled')then
							{
								cutText [_log, 'PLAIN DOWN'];
								hint _log;
							};
							['SYSTEMLOG',_log] call CQC_fnc_ahLog;   
						};
					};
					if(isNil '""+_AH_SurvLogArrayRND+""')then{""+_AH_SurvLogArrayRND+"" = [];};
					if(isNil 'AH_SurvLogArray')then{AH_SurvLogArray = ""+_AH_SurvLogArrayRND+"";};
					'""+_AH_SurvLogArrayRND+""' addPublicVariableEventHandler
					{
						_array = _this select 1;
						AH_SurvLogArray = _array;
						if(str _array != '[]')then{
							_log = _array select ((count _array)-1);
							['SYSTEMLOG',_log] call CQC_fnc_ahLog;   
						};
					};
					if(isNil '""+_AH_AdmiLogArrayRND+""')then{""+_AH_AdmiLogArrayRND+"" = [];};
					if(isNil 'AH_AdmiLogArray')then{AH_AdmiLogArray = ""+_AH_AdmiLogArrayRND+"";};
					'""+_AH_AdmiLogArrayRND+""' addPublicVariableEventHandler
					{
						_array = _this select 1;
						AH_AdmiLogArray = _array;
						if(str _array != '[]')then{
							_log = _array select ((count _array)-1);
							['SYSTEMLOG',_log] call CQC_fnc_ahLog;   
						};
					};
					if(isNil'""+_TMPBAN+""')then{""+_TMPBAN+""=[];}else{if(typeName ""+_TMPBAN+""!='ARRAY')then{""+_TMPBAN+""=[];};};
					if(isNil 'PVAH_AHTMPBAN')then{PVAH_AHTMPBAN = ""+_TMPBAN+"";};
					'""+_TMPBAN+""' addPublicVariableEventHandler
					{
						PVAH_AHTMPBAN = ""+_TMPBAN+"";
					};

					OPEN_ADMIN_MENU_KEY = ""+str _OPEN_ADMIN_MENU_KEY+"";
					[] spawn _adminMenu;
					['SYSTEMLOG',format['Admin menu sent too [%1]',_uid]] call CQC_fnc_ahLog;   
				}
			] remoteExecCall ['spawn',_owner,false];
		"");

		"+_serverMassMessage+" = compileFinal (""
			private['_msg','_unit'];
			_msg = _this select 0;
			_unit = _this select 1;
			""+_massMessage+"" = [_msg,0,0.7,10,0];
			(owner _unit) publicVariableClient '""+_massMessage+""';
		"");
	 
		"+_voteTimeServer+" = compileFinal ("" 
			_clientUID = _this select 0;
			_vote = _this select 1;
			
			if(isNil 'TimeVoteCooldown')then{TimeVoteCooldown = 300;};
			if(isNil 'LastVoteGoneThrough')then{LastVoteGoneThrough = 600;};
			if((LastVoteGoneThrough == 0) || ((TimeVoteCooldown + LastVoteGoneThrough) < time))then
			{
				if(isNil 'VoteArray')then{VoteArray = [];};
				if!(_clientUID in VoteArray)then
				{
					VoteArray pushBack _clientUID;
					VoteArray pushBack _vote;
					_cntAll = count allPlayers;
					_cntVoted = {getPlayerUID _x in VoteArray} count allPlayers;
					if((_cntAll > 0) && (_cntVoted > 0))then
					{
						_cntday = 0;
						_cntnight = 0;
						if((_cntVoted / _cntAll) > 0.49)then
						{
							_oUIDs = [];
							{
								_xUID = getPlayerUID _x;
								if(_xUID != '')then
								{
									_oUIDs pushBack _xUID;
								};
							} forEach allPlayers;
							for '_i' from 0 to (count VoteArray)-1 step 2 do
							{
								_cUID = VoteArray select _i;
								_cVOTE = VoteArray select (_i+1);
								if(_cUID in _oUIDs)then
								{
									if(_cVOTE == 'DAY')then{_cntday = _cntday + 1;};
									if(_cVOTE == 'NIGHT')then{_cntnight = _cntnight + 1;};
								};
							};
							
							_txt = format['%1 of %2 Players voted. %3 for Day and %4 for Night.',_cntVoted,_cntAll,_cntday,_cntnight];
							""+_massMessage+"" = ['<t size=''0.55'' color=''#0B6121''>'+(_txt)+'</t>',safeZoneXAbs/safeZoneWAbs/4,SafeZoneY+0.02,10,0,0,3079];
							{(owner _x) publicVariableClient '""+_massMessage+""';} forEach allPlayers;
							
							_date = date;
							_date set [3,11];
							if(_cntnight > _cntday)then
							{
								_date set [3,23];
							};
							setDate _date;
							VoteArray = [];
							LastVoteGoneThrough = time;
						}
						else
						{
							_txt = format['%1 of %2 Players voted (/vote day or /vote night).',_cntVoted,_cntAll];
							""+_massMessage+"" = ['<t size=''0.55'' color=''#0B6121''>'+(_txt)+'</t>',safeZoneXAbs/safeZoneWAbs/4,SafeZoneY+0.02,10,0,0,3079];
							{(owner _x) publicVariableClient '""+_massMessage+""';} forEach allPlayers;
						};
					};
				};
			}
			else
			{
				_txt = format['Wait %1s more until next day/night vote can be made!',round((TimeVoteCooldown + LastVoteGoneThrough) - time)];
				""+_massMessage+"" = ['<t size=''0.55'' color=''#0B6121''>'+(_txt)+'</t>',safeZoneXAbs/safeZoneWAbs/4,SafeZoneY+0.02,10,0,0,3079];
				{(owner _x) publicVariableClient '""+_massMessage+""';} forEach allPlayers;
			};
		"");

		"+_serverKick+" = compileFinal (""
			params[
				['_name','',['']],
				['_uid','',['']],
				['_owner',-10,[0]],
				['_reason','',['']]
			];

			_return = false;
			_return = if(_owner > 2)then
			{
				'""+_serverCommandPassword+""' serverCommand format ['#kick %1',_owner];
			}else{
				'""+_serverCommandPassword+""' serverCommand format ['#kick %1',_uid];
			};
			_admin = _uid in _admins;
			_log = if(_reason isEqualTo '')then{format['%1(%2) isAdmin? %3',_name,_uid,_admin]}else{format['%1(%2) isAdmin? %3: %4',_name,_uid,_admin,_reason]};
			if(_return)then
			{
				['KICKLOG',_log] call CQC_fnc_ahLog;
			}else{
				['KICKLOG',format['ERROR! COULD NOT USE SERVER KICK FUNCTION FOR - [%1]',_log]] call CQC_fnc_ahLog;
				[_name,_uid,_reason] call CQC_fnc_serverBanTemp;
			};
		"");

		"+_serverLock+" = compileFinal (""
			params[ 
				['_lock',true,[false]]
			]; 
			if(_lock)then {
				'""+_serverCommandPassword+""' serverCommand '#lock';
				""+_serverLocked+"" = true; 
				'Server Locked' remoteExec ['systemChat',-2];
			}else{
				'""+_serverCommandPassword+""' serverCommand '#unlock';
				""+_serverLocked+"" = false;
				'Server Unlocked' remoteExec ['systemChat',-2];
			};
			publicVariable '""+_serverLocked+""';
		"");

		"+_serverBan+" = compileFinal (""
			params[['_name',''],['_uid',''],['_reason','']];

			if(_uid in _admins)exitWith
			{
				_mytime = call CQC_fnc_serverUpTime;
				_log = _mytime + format['%1(%2) ADMIN - would have been banned now!',_name,_uid];
				['HACKLOG',_log] call CQC_fnc_ahLog;
			};

			if(_reason == '')then
			{
				['BANLOG',format['%1(%2)',_name,_uid]] call CQC_fnc_ahLog;
			}else{
				['BANLOG',format['%1(%2) - %3',_name,_uid,_reason]] call CQC_fnc_ahLog;
			};

			_return = '""+_serverCommandPassword+""' serverCommand format ['#exec ban %1',str _uid];
			if(!_return)then
			{
				_this call CQC_fnc_serverBanTemp;
			};
		"");
		
		'"+_netRequestVar+"' addPublicVariableEventHandler {(_this select 1) call "+_adminMenuRequest+";};

		['SYSTEMLOG','preinit compiled and ran..'] call CQC_fnc_ahLog;

		"+_compile1Var+" = toString [67,81,67];

		true
	";

	//-- Load Pre init
	_runCheck = [] call compile _expression;
	switch (true) do {
		case (isNil "_expression"): 			                               {_runCheck="_expression | 1 | nil scope"};
		case (isNil {_runCheck}): 										       {_runCheck="_expression | 1 | nil run check"};
		case (_runCheck isEqualTo false): 								       {_runCheck="_expression | 1 | run check failed"};
		case (isNil {(missionNamespace getVariable _compile1Var)}): 		   {_runCheck="_expression | 1 | nil endvar"};
		case ((missionNamespace getVariable _compile1Var) isNotEqualTo "CQC"): {_runCheck=format["_expression | 1 | bad endvar %1 should be CQC",_compile1Var]};
	};
	if(typeName _runCheck isEqualTo "STRING") exitWith {
		['SYSTEMLOG',_runCheck] call CQC_fnc_ahLog;
		throw false;
	};

	//-- Build Anti Hack
	_runCheck = false;
	_expression = "
		CQC_fnc_serverBanTemp = {
			params[['_name',''],['_uid',''],['_reason','']];

			if(isNil '"+_TMPBAN+"')then{
				"+_TMPBAN+"=[];
			}else{
				if(typeName "+_TMPBAN+" isNotEqualTo 'ARRAY')then{
					"+_TMPBAN+"=[];
				};
			};
			if!(_uid in "+_TMPBAN+")then
			{
				_admins = "+str _admins+";
				if(_uid in _admins)exitWith
				{
					_mytime = call CQC_fnc_serverUpTime;
					_log = _mytime + format['%1(%2) ADMIN - would have been tempbanned now!',_name,_uid];
					['HACKLOG',_log] call CQC_fnc_ahLog;
				};
				"+_TMPBAN+" pushBack _uid;
				{if(getPlayerUID _x in _admins)then{(owner _x) publicVariableClient '"+_TMPBAN+"';};} forEach allPlayers;
			};
			[_name,_uid,-10,format['TEMP BAN: %1',_reason]] call "+_serverKick+";
		};
		CQC_fnc_serverBanTemp = compileFinal ([CQC_fnc_serverBanTemp] call CQC_fnc_tooExpression);
  
		_fnc_CQC_PlayerLog = {
			params[['_uid',''],['_name',''],['_owner',-10]];
			if (_owner < 3) exitwith {};
			
			if(isNil'"+_TMPBAN+"')then{"+_TMPBAN+"=[];}else{if(typeName "+_TMPBAN+"!='ARRAY')then{"+_TMPBAN+"=[];};};
			if(_uid in "+_TMPBAN+")exitWith{[_name,_uid,_owner,'TMPBAN ARRAY BROKEN'] call "+_serverKick+";};
			_lname = toLower _name;
			if(_lname isEqualTo 'dead')exitWith
			{
				_log = 'BadName (KICKED)';
				[_name,_uid,'SLOG_SKICK',toArray(_log)] call "+_FNC_AH_KICKLOG+";
			};
			if(_lname find '&' > -1)exitWith
			{
				_log = '& in name breaks BattleEye..';
				[_name,_uid,'SLOG_SKICK',toArray(_log)] call "+_FNC_AH_KICKLOG+";
			};
			{
				if(_lname find _x > -1)then
				{
					_log = format['BadName: %1 (KICKED)',_x];
					[_name,_uid,'SLOG_SKICK',toArray(_log)] call "+_FNC_AH_KICKLOG+";
				};
			} forEach ['thirtysix','le hippo','infis'];
		};
		fnc_CQC_PlayerLog = compileFinal ([_fnc_CQC_PlayerLog] call CQC_fnc_tooExpression);

		_FNC_AH_KICKLOG = {
			params[['_name',''],['_puid',''],['_what','']];
			if((_name != '')&&(_puid == ''))then
			{
				{
					if(!isNull _x)then
					{
						if(alive _x)then
						{
							if(name _x == _name)then
							{
								_puid = getPlayerUID _x;
								['SYSTEMLOG',format['CLIENT NO UID - SERVER RESOLVED: %1(%2).. used allPlayers',_name,_puid]] call CQC_fnc_ahLog;   
							};
						};
					};
				} forEach allPlayers;
			};
			if(_what isEqualTo 'KICKME')exitWith{[_name,_puid,-10,'KICKME CALL FROM CLIENT'] call "+_serverKick+";};
			_mytime = call CQC_fnc_serverUpTime;
			_admins = "+str _admins+";
			_locDevs = "+str _devs+";
			if(_what == 'TPLOG')exitWith
			{
				_adminName = _this select 4;
				_adminPUID = _this select 5;
				if(_adminPUID in _locDevs)exitWith{};
				_lastpos = _this select 6;
				_mapLP = mapGridPosition _lastpos;
				_curpos = _this select 7;
				_mapCP = mapGridPosition _curpos;
				_log = _mytime + format['%1(%2) | Teleported %3(%4) from %5(%6) to %7(%8)  (%9m)',_adminName,_adminPUID,_name,_puid,_lastpos,_mapLP,_curpos,_mapCP,round(_lastpos distance _curpos)];
				['ADMINLOG',_log] call CQC_fnc_ahLog;
				"+_AH_AdmiLogArrayRND+" pushBack _log;
				{if((getPlayerUID _x) in _admins)then{(owner _x) publicVariableClient '"+_AH_AdmiLogArrayRND+"';};} forEach allPlayers;
			}; 
			if(_what == 'LVC')exitWith
			{
				private['_plrObj','_vehptype','_vehpos'];
				_plrObj = _this select 3;
				_vehptype = _this select 4;
				_vehpos = _this select 5;
				if((!isNil '_plrObj') && (!isNil '_vehptype'))then
				{
					if(!isNull _plrObj)then
					{
						_veh = vehicle _plrObj;
						_vehstype = typeOf _veh;
						if(_plrObj != _veh)then
						{
							"; if(_UVC)then{ _expression = _expression + "
								if((!("+str _UVW+") && {_vehstype in "+str _ForbiddenVehicles+"}) || (("+str _UVW+") && {!(_vehstype in "+str _VehicleWhiteList+")}))then
								{
									_crew = crew _veh;
									if(_crew isEqualTo [])then
									{
										_log = format['BadVehicle (S-UVC+LVC): %1',_vehstype];
										['SERVER','SERVER','HLOG',toArray(_log)] call "+_FNC_AH_KICKLOG+";
										_veh call CQC_fnc_deleteObject;
									}
									else
									{
										if(call{{if((getPlayerUID _x) in "+_adminsA+")exitWith{true};false} forEach _crew;})exitWith{};
										
										_log = format['BadVehicle (S-UVC+LVC): %1',_vehstype];
										{
											_name = name _x;
											_puid = getPlayerUID _x;
											[_name,_puid,'HLOG',toArray(_log)] call "+_FNC_AH_KICKLOG+";
										} forEach _crew;
										_veh call CQC_fnc_deleteObject;
									};
								};
							"; }; _expression = _expression + "
						};
						if(!isNull _veh)then
						{
							if((_plrObj == _veh) && (_vehstype != _vehptype))then
							{
								_vehicles = _plrObj nearEntities ['AllVehicles',300];
								if!(_veh in _vehicles)then
								{
									"+_dellocveh+" = '';
									(owner _plrObj) publicVariableClient '"+_dellocveh+"';
									"+_dellocveh+" = nil;
									_log = format['LocalVehicle: %1  @%2 || ServerVehicle: %3  @%4',_vehptype,_vehpos,_vehstype,mapGridPosition _plrObj];
									[_name,_puid,'SLOG',toArray(_log)] call "+_FNC_AH_KICKLOG+";
								};
							};
						};
					};
				};
			}; 
			_work = toString(_this select 3);
			_log = _mytime + format['%1(%2) | %3',_name,_puid,_work]; 
			if(_what == 'ALOG')exitWith
			{
				['ADMINLOG',_log] call CQC_fnc_ahLog;
				"+_AH_AdmiLogArrayRND+" pushBack _log;{if((getPlayerUID _x) in _admins)then{(owner _x) publicVariableClient '"+_AH_AdmiLogArrayRND+"';};} forEach allPlayers;
			}; 
			if(_what in ['SLOG','SLOG_SKICK'])exitWith
			{
				['SURVEILLANCELOG',_log] call CQC_fnc_ahLog;
				"+_AH_SurvLogArrayRND+" pushBack _log;{if((getPlayerUID _x) in _admins)then{(owner _x) publicVariableClient '"+_AH_SurvLogArrayRND+"';};} forEach allPlayers;
				if(_what == 'SLOG_SKICK')exitWith
				{
					[_name,_puid,-10,format['%1: %2',_what,_work]] call "+_serverKick+";
				};
			};
			if(_what isEqualTo 'SLOG_RE')exitWith
			{
				['SURVEILLANCELOG',_log] call CQC_fnc_ahLog;
				"+_AH_SurvLogArrayRND+" pushBack _log;{if((getPlayerUID _x) in _admins)then{(owner _x) publicVariableClient '"+_AH_SurvLogArrayRND+"';};} forEach allPlayers;
			};
			if(_what in ['BAN','TMPBAN','HLOG','HLOG_SKICK'])exitWith
			{
				['HACKLOG',_log] call CQC_fnc_ahLog;
				"+_AH_HackLogArrayRND+" pushBack _log;{if((getPlayerUID _x) in _admins)then{(owner _x) publicVariableClient '"+_AH_HackLogArrayRND+"';};} forEach allPlayers;
				if(_what == 'HLOG')exitWith{};
				[_name,_puid,-10,format['%1: %2',_what,_work]] call "+_serverKick+";
				if(_what in ['BAN','TMPBAN'])exitWith
				{
					_log = _mytime + format['%1(%2) BANNED | %3',_name,_puid,_work];
					if(_puid in _admins)then
					{
						_adminlog = _mytime + format['%1(%2) ADMIN - would have been banned now!',_name,_puid];
						['HACKLOG',_adminlog] call CQC_fnc_ahLog;
						"+_AH_HackLogArrayRND+" pushBack _adminlog;
					}
					else
					{
						if(_what == 'BAN')then
						{
							[_name,_puid,_work] call "+_serverBan+";
						}
						else
						{
							[_name,_puid,_work] call CQC_fnc_serverBanTemp;
						};
					};
				};
			};
			if(_what == 'AC')exitWith
			{
				if(_puid in _admins)then
				{
					if(_work == '!admin')then
					{
						if(_puid in "+_adminsA+")then
						{
							"+_adminsA+" = "+_adminsA+" - [_puid]; 
							if(_puid in _locDevs)exitWith{};
							_alog = _mytime + format['%1(%2) | is a normal player now.',_name,_puid];
							['ADMINLOG',_alog] call CQC_fnc_ahLog;
							"+_AH_AdmiLogArrayRND+" pushBack _alog;
						}
						else
						{
							"+_adminsA+" pushBack _puid;
							if(_puid in _locDevs)exitWith{};
							_alog = _mytime + format['%1(%2) | is an admin again.',_name,_puid];
							['ADMINLOG',_alog] call CQC_fnc_ahLog;
							"+_AH_AdmiLogArrayRND+" pushBack _alog;
						};
						
						CQC_ADMINS = "+_adminsA+";
						
						{
							if((getPlayerUID _x) in _admins)then
							{
								(owner _x) publicVariableClient 'CQC_ADMINS';
								(owner _x) publicVariableClient '"+_AH_AdmiLogArrayRND+"';
							};
						} forEach allPlayers;
						
						CQC_ADMINS = nil;
					};
				};
			}; 
			if(_what == 'VOTE')exitWith
			{
				if(_work in ['DAY','NIGHT'])exitWith
				{
					[_puid,_work] call "+_voteTimeServer+";
				};
			};
		};
		"+_FNC_AH_KICKLOG+" = compileFinal ([_FNC_AH_KICKLOG] call CQC_fnc_tooExpression);
	  
		_FNC_AH_KICKLOGSPAWN = {
			private['_input','_tokenreceived','_arraysent','_netId','_objectFromNetId','_objectName','_objectUID','_name','_puid','_result','_foundtokenid','_puidfound','_belongstoname'];
			_input = _this;
			if(isNil '_input')exitWith{
				_mytime = call CQC_fnc_serverUpTime;
				_log = _mytime + 'FNC_AH_KICKLOGSPAWN _this is Nil (v0.0.4)';
				['SURVEILLANCELOG',_log] call CQC_fnc_ahLog;
			};
			['SYSTEMLOG',format['(FNC_AH_KICKLOGSPAWN) %1',_this]] call CQC_fnc_ahLog; 
			
			_tokenreceived = _this select 0;
			if(isNil '_tokenreceived')exitWith{
				_mytime = call CQC_fnc_serverUpTime;
				_log = _mytime + '_tokenreceived _this is Nil (v0.0.4)';
				['SURVEILLANCELOG',_log] call CQC_fnc_ahLog;
			};
			if(typeName _tokenreceived != 'STRING')exitWith{
				_mytime = call CQC_fnc_serverUpTime;
				_log = _mytime + format['_tokenreceived wrong type %1 (v0.0.4)',typeName _tokenreceived];
				['SURVEILLANCELOG',_log] call CQC_fnc_ahLog;
			};
			
			_arraysent = _this select 1;
			if(isNil '_arraysent')exitWith{
				_mytime = call CQC_fnc_serverUpTime;
				_log = _mytime + '_arraysent _this is Nil (v0.0.4)';
				['SURVEILLANCELOG',_log] call CQC_fnc_ahLog;
			};
			if(typeName _arraysent != 'ARRAY')exitWith{
				_mytime = call CQC_fnc_serverUpTime;
				_log = _mytime + format['_arraysent wrong type %1 (v0.0.4)',typeName _arraysent];
				['SURVEILLANCELOG',_log] call CQC_fnc_ahLog;
			};
			
			_objectFromNetId = objNull;
			_netId = _this select 2;
			if(isNil '_netId')then{_netId='';};
			if(typeName _netId != 'STRING')exitWith{
				_mytime = call CQC_fnc_serverUpTime;
				_log = _mytime + format['_netId wrong type %1 (v0.0.4)',typeName _netId];
				['SURVEILLANCELOG',_log] call CQC_fnc_ahLog;
			};
			_objectFromNetId = objectFromNetId _netId;
			
			_name = _arraysent select 0;
			if(isNil '_name')then{_name = 'NAME_ERROR1';};
			if(typeName _name != 'STRING')then{_name = 'NAME_ERROR2';};
			if(_name == '')then{_name = 'NAME_ERROR3';};
			
			_puid = _arraysent select 1;
			if(isNil '_puid')then{_puid = '';};
			if(typeName _puid != 'STRING')then{_puid = '';};
			 
			['SYSTEMLOG',format['(FNC_AH_KICKLOGSPAWN) %1(%2) Token %3 - objByNetID %4',_name,_puid,_tokenreceived,_objectFromNetId]] call CQC_fnc_ahLog;
			_objectUID = getPlayerUID _objectFromNetId;
			_objectName = if(_objectUID isEqualTo '')then{_name}else{name _objectFromNetId};

			_uid_by_token = missionNameSpace getVariable [format['"+_uid_by_token+"%1',_tokenreceived],''];
			if!(_puid isEqualTo _uid_by_token)exitWith
			{
				_log = format['Bad PUID / Token: Token received [%1] belongs to [%2] and not [%3]',_tokenreceived,_uid_by_token,_puid];
				['SYSTEMLOG',format['(FNC_AH_KICKLOGSPAWN) %1',_log]] call CQC_fnc_ahLog;
				[_name,_puid,'SLOG_SKICK',toArray(_log)] call "+_FNC_AH_KICKLOG+";
				[_name,_uid_by_token,'SLOG_SKICK',toArray(_log)] call "+_FNC_AH_KICKLOG+";
			}; 

			_arraysent set [0,_objectName];
			_arraysent set [1,_puid];
			_arraysent call "+_FNC_AH_KICKLOG+";
		};
		"+_FNC_AH_KICKLOGSPAWN+" = compileFinal ([_FNC_AH_KICKLOGSPAWN] call CQC_fnc_tooExpression);
		 
		CQC_PlayerConnected_id = addMissionEventHandler ['PlayerConnected',{
			params['_id','_uid','_name','_jip','_owner'];
			if(count _uid < 17)then
			{
				_log = format['#0 Connected: %1(%2) Owner: %3',_name,_uid,_owner];
				['CONNECTLOG',_log] call CQC_fnc_ahLog;
			}
			else
			{ 
				private _admins = "+str _admins+";
				private _admin = _uid in _admins;
				private _isNormal = true;	
				private _token = [_uid] call "+_server_setTokenR+";

				[_name, _uid] call "+_checkGlobalBanState+";

				"+_adminsUIDAccsesArr+" = []; 

				"+_YourPlayerToken+" = _token;
				['TOKENLOG',format['%1(%2) CLIENT OWNER ID [%3], TOKEN [%4]',_name,_uid,_owner,_token]] call CQC_fnc_ahLog;
				_owner publicVariableClient '"+_YourPlayerToken+"'; 	

				if(_admin)then
				{
					_isNormal = if(_uid in "+_adminsA+")then{false}else{true};
					if(_isNormal)exitWith{};
					
					CQC_ADMINS = "+_adminsA+";
					_owner publicVariableClient 'CQC_ADMINS';
					
					[_id,_uid,_name,_jip,_owner,_admins,_admin,_isNormal] call "+_adminConnected+";
				}else{
					CQC_var_AdminUIDAccses = compileFinal str(false);
				};
				
				
				missionNameSpace setVariable [format['"+_name_by_uid+"%1',_uid],_name];
				missionNameSpace setVariable [format['"+_owner_by_uid+"%1',_uid],_owner];
				missionNameSpace setVariable [format['NAME_BY_ID_%1',_id],_name,true];
				missionNameSpace setVariable [format['UID_BY_ID_%1',_id],_uid,true];
				
				[[_name,_uid,_admin,_isNormal,_admins],"+_AH_MAIN_BLOCK+"] remoteExecCall ['spawn', _owner, false];
				
				_mytime = call CQC_fnc_serverUpTime;
				
				_steamName = _uid call CQC_fnc_getSteamName;
				_name = if(_steamName isEqualTo '')then{_name}else{format['SteamName: %1 - IngameName: %2',_steamName,_name]};
				
				_log = _mytime + format['Connected: %1(%2 - %3) - time: %4 - serverFPS: %5',_name,_uid,_owner,time,diag_fps];
				['CONNECTLOG',_log] call CQC_fnc_ahLog;
				
				[_uid,_name,_owner] call fnc_CQC_PlayerLog;  
			};
		}];
		
		CQC_PlayerDisconnected_id = addMissionEventHandler ['PlayerDisconnected',{
			params['_id','_uid','_name','_jip','_owner'];
			_mytime = call CQC_fnc_serverUpTime;
			
			_steamName = _uid call CQC_fnc_getSteamName;
			_name = if(_steamName isEqualTo '')then{_name}else{format['SteamName: %1 - IngameName: %2',_steamName,_name]};
			
			_log = _mytime + format['Disconnected: %1(%2 - %3) - time: %4 - serverFPS: %5',_name,_uid,_owner,time,diag_fps];
			['CONNECTLOG',_log] call CQC_fnc_ahLog;
		}];
		
		_AH_MAIN_BLOCK = {
			waitUntil{uiSleep 1;getClientStateNumber >= 10 && !isNull findDisplay 46};
			params ['_name','_puid','_admin','_isNormal','_admins'];

			if(isNil'"+_AHKickLog+"')exitWith{
				_log = format['%1(%2) - AntiHack variable is NIL !',_name,_puid];
				AHKickLog_IS_NIL = _log;publicVariableServer'AHKickLog_IS_NIL';
				(findDisplay 46)closeDisplay 0;
			};
			if(isNil'"+_AHKickOFF+"')exitWith{
				_log = format['%1(%2) - AntiHack variable is NIL !',_name,_puid];
				AHKickOFF_IS_NIL = _log;publicVariableServer'AHKickOFF_IS_NIL';
				(findDisplay 46)closeDisplay 0;
			};

			_AHKickOFF = "+_AHKickOFF+";
			_AHKickLog = "+_AHKickLog+";
	
			if(!isNil'AH_STARTED_ALREADY')exitWith{
				_log = format['%1(%2) - AH STARTED TWICE !',_name,_puid];
				AH_STARTED_TWICE = _log;publicVariableServer'AH_STARTED_TWICE';
				(findDisplay 46)closeDisplay 0;
			};
			AH_STARTED_ALREADY = true;

			_temptime = diag_tickTime + 30;
			waitUntil {(((getClientStateNumber >= 10)&&(getPlayerUID player != ''))||(diag_tickTime > _temptime))};

			_clientUID = format['%1',getPlayerUID player];
			if((isNil '_puid')||(isNil '_clientUID'))then
			{
				_log = 'No UID';
				NO_UID = 'NO_UID';publicVariableServer 'NO_UID';
				(findDisplay 46)closeDisplay 0;
				_clientUID = format['rand%1',random 999];
			};
			if!(_puid isEqualTo _clientUID)exitWith
			{
				_log = format['PlayerUID [%1] is not Equal to Serverside PlayerUID [%2]! (KICKED TO LOBBY)',_puid,_clientUID];
				[_name,_puid,'SLOG_SKICK',toArray(_log)] call _AHKickLog;
				(findDisplay 46)closeDisplay 0;
			};

			profileNamespace setVariable['PUID',nil];
			_PUID_array = profileNamespace getVariable['PUIDS',[]];
			if!(_admin)then
			{
				_add_Id = _PUID_array pushBackUnique _puid;
				if(_add_Id > -1)then
				{
					profileNamespace setVariable['PUIDS',_PUID_array];saveprofileNamespace;
					if(_PUID_array isEqualTo [_puid])exitWith{};
					_announce = true;{if(_x in _admins)exitWith{_announce = false;};} forEach _PUID_array;
					if(_announce)then
					{
						_log = format['Player changed Steam Accounts - UIDs: %1',_PUID_array];
						[profileName,_puid,'HLOG_SKICK',toArray(_log)] call _AHKickLog;
						[] call _AHKickOFF;
					};
				};
  
				_badclassesban =
				[
					'server_functions','client_functions','life_server','devcon','pooploop','rscrazzler','rsclistboxvg','vgdialog','niggers_die','ballers_die','grimbae','nss_admin_console','sspcm','balca_debug_tool','tonis_admin_menu_main',
					'oks_die'
				];
				_badclasseskick =
				[
					'a3_m3editor','extdb2','loki_lost_key','CQC_lifemods','CQC_a3'
				];

				_cfgPatches = 'true' configClasses (configFile >> 'CfgPatches');
				{
					_configName = configName _x;
					_lconfigName = toLower _configName;
					if(_lconfigName in _badclassesban)then
					{
						_log = format['PBO-Injector found in CfgPatches: %1',_configName];
						[_name,_puid,'BAN',toArray(_log)] call _AHKickLog;
						[] call _AHKickOFF;
					};
					if(_lconfigName in _badclasseskick)then
					{
						_log = format['Bad Addon found in CfgPatches: %1',_configName];
						[_name,_puid,'HLOG_SKICK',toArray(_log)] call _AHKickLog;
						[] call _AHKickOFF;
					};
				} forEach _cfgPatches;

				_badclasseskick append _badclassesban;
				_activatedAddons = [];
				{_activatedAddons pushBack (toLower _x)} forEach activatedAddons;
				{
					_addon = _x;
					{
						if(_addon find (toLower _x) != -1)then
						{
							_log = format['Bad Addon found: %1 (%2)',_addon,_x];
							[_name,_puid,'HLOG_SKICK',toArray(_log)] call _AHKickLog;
							[] call _AHKickOFF;
						};
					} forEach _badclasseskick;
				} forEach _activatedAddons;
			};
			"+_dellocveh+" = nil;'"+_dellocveh+"' addPublicVariableEventHandler compileFinal """+_dellocveh+" = nil;deleteVehicle (vehicle player);"";

			 
			[_name,_puid,_admin,_AHKickOFF,_AHKickLog] spawn {
				params ['_name','_puid','_admin','_AHKickOFF','_AHKickLog'];
				disableSerialization;
				{ctrlDelete ((findDisplay 12) displayCtrl _x);} forEach [1086,1087,1088,1089,1090];
				_wallgames = 0;
				_lastglitch = time;
				_49openedTimer = 0;  
				"+_customcommandingMenu+" = [];
				"+_customcommandingMenu+" pushBack ['by CQC AntiHack',true];
				"+_customcommandingMenu+" pushBack ['User Menu', [-1], '', -5, [['expression', '']], '1', '0'];
				"+_customcommandingMenu+" pushBack ['Earplugs in/out', [2], '', -5, [['expression', 'if(isNil''Earplugs'')then{Earplugs=true;1 fadeSound 0.25;systemchat''Earplugs in'';}else{Earplugs=nil;1 fadeSound 1;systemchat''Earplugs out'';};']], '1', '1'];
				_customcommandingMenu = "+_customcommandingMenu+";
				_isNormal = true;
				if(_admin)then{
					_isNormal = if(_puid in "+_adminsA+")then{false}else{true};
				};
				
				_fn_CQC_block_von = {
					if(currentChannel in "+str (_disAllowVon - [5])+")then
					{
						_switch = call {
							if(_key in actionKeys 'VoiceOverNet')exitWith{true};
							if(_key in actionKeys 'PushToTalk')exitWith{true};
							if(_key in actionKeys 'PushToTalkAll')exitWith{true};
							if(_key in actionKeys 'PushToTalkCommand')exitWith{true};
							if(_key in actionKeys 'PushToTalkDirect')exitWith{true};
							if(_key in actionKeys 'PushToTalkGroup')exitWith{true};
							if(_key in actionKeys 'PushToTalkSide')exitWith{true};
							if(_key in actionKeys 'PushToTalkVehicle')exitWith{true};
							false
						};
						if(_switch)then{setCurrentChannel 5;_handled = _switch;};
					};
				};
				fn_CQC_block_von = 'c';
				if!(fn_CQC_block_von isEqualTo 'c')then
				{
					_log = 'fn_CQC_block_von was changed! BAN HAMMER!';
					[_name,_puid,'BAN',toArray(_log)] call _AHKickLog;
					[] call _AHKickOFF;
				};
				missionNameSpace setVariable ['fn_CQC_block_von',compileFinal([_fn_CQC_block_von] call CQC_fnc_tooExpression)];


				_fnc_infiKeyHandler = ""
					params['_dctrl','_key','_shift','_ctrl','_alt'];
					_handled = false;
					call fn_CQC_block_von; 
					if(_key in (actionKeys 'TacticalView'))then{ _handled = true; };
					if(_ctrl)then
					{
						if(_key in (actionKeys 'Salute'))then
						{
							player playactionNow 'GestureFinger';
							_handled = true;
						};
					};
					_handled
				"";
				"+_fnc_infiKeyHandler+" = compileFinal _fnc_infiKeyHandler;

				if(str "+_fnc_infiKeyHandler+" != str (compile _fnc_infiKeyHandler))then
				{
					_log = format['fnc_infiKeyHandler changed! %1, %2',"+_fnc_infiKeyHandler+",_fnc_infiKeyHandler];
					[_name,_puid,'BAN',toArray(_log)] call _AHKickLog;
					[] call _AHKickOFF;
				};

				(findDisplay 46) displayAddEventHandler ['KeyDown',{ _this call "+_fnc_infiKeyHandler+"; }];
				(findDisplay 46) displayAddEventHandler ['KeyUp',{ _this call "+_fnc_infiKeyHandler+"; }];
				_markertimer = time + 5;

				_chatKeyUp = '
					disableSerialization;
					_name = '+str _name+';
					_puid = '+str _puid+';
					_admin = '+str _admin+';
					_AHKickOFF = '+str _AHKickOFF+';
					_AHKickLog = '+str _AHKickLog+';
					_chat = (findDisplay 24) displayCtrl 101;
					_txt = ctrlText _chat;
					private _compatibleMagazines = [currentWeapon player,true] call BIS_fnc_compatibleMagazines;
					_ltxt = toLower _txt;
					if(_admin)then
					{
						if(_ltxt isEqualTo ''!admin'')exitWith
						{
							(findDisplay 24) closeDisplay 0;
							[_name,_puid,''AC'',toArray(_txt)] call _AHKickLog;
							[] spawn {uiSleep 0.3;(findDisplay 46)closeDisplay 0;};
						};
					}
					else
					{
						if(_ltxt in [format[''.ban %1'',toLower _name],format[''.ban %1 true'',toLower _name],format[''.ban %1 true;'',toLower _name]])then
						{
							(findDisplay 24) closeDisplay 0;
							_log = format[''BadCommand: %1'',_txt];
							[_name,_puid,''BAN'',toArray(_log)] call _AHKickLog;
							[] call _AHKickOFF;
						};
						if(_ltxt find ''admin'' > -1) then
						{
							(findDisplay 24) closeDisplay 0;
							player say3D ''babycry'';
						};
					};
					if(_ltxt in [''killme'',''!killme'',''/killme'',''kill me'',''/kill me'',''!suicide'',''/suicide'',''suicide''])then{
						(findDisplay 24) closeDisplay 0;
						_unit = player;
						{_unit setHitPointDamage [_x,1];} forEach [''HitBody'',''HitHead''];
						_unit spawn {
							uiSleep 1.5;
							if(isNull _this)exitWith{};
							if(local _this)then{_this setPos [0,0,100];};
						};
					}; 
					if(_ltxt in [''ammo'',''!ammo'',''/ammo''])then{
						{player addMagazine _x}forEach _compatibleMagazines; 	
					};
					if(_ltxt in [''ammo5'',''!ammo5'',''/ammo5''])then{
						for ''_i'' from 1 to 5 do {player addMagazine selectRandom _compatibleMagazines};	
					};
					if(_ltxt in [''ammo10'',''!ammo10'',''/ammo10''])then{
						for ''_i'' from 1 to 10 do {player addMagazine selectRandom _compatibleMagazines};	
					};
					if(_ltxt in [''ammo15'',''!ammo15'',''/ammo15''])then{
						for ''_i'' from 1 to 15 do {player addMagazine selectRandom _compatibleMagazines};	
					};
					if(_ltxt in [''ammo20'',''!ammo20'',''/ammo20''])then{
						for ''_i'' from 1 to 20 do {player addMagazine selectRandom _compatibleMagazines};	
					};
					if(_ltxt in [''ammo25'',''!ammo25'',''/ammo25''])then{
						for ''_i'' from 1 to 25 do {player addMagazine selectRandom _compatibleMagazines};	
					};
					if(_ltxt in [''!vote day'',''/vote day'',''vote day'',''!day'',''/day''])then{
						(findDisplay 24) closeDisplay 0;
						[_name,_puid,''VOTE'',toArray ''DAY''] call _AHKickLog;
					};
					if(_ltxt in [''!vote night'',''/vote night'',''vote night'',''!night'',''/night''])then{
						(findDisplay 24) closeDisplay 0;
						[_name,_puid,''VOTE'',toArray ''NIGHT''] call _AHKickLog;
					};
				
					false
				';
				_chatKeyUp_id = -1;
				while{1==1}do
				{
					if(time > _markertimer)then
					{
						_markertimer = time + 5;
						
						_need_hlog = true;
						{
							_marker = _x;
							if(_marker find '_USER_DEFINED' > -1)then
							{
								_markerchannel = _marker select [(count _marker)-1,1];
								if(parseNumber _markerchannel > 2)exitWith{};
								
								_stringsizeSTART = (_marker find '#')+1;
								_stringsizeEND = _marker find '/';
								_markerid = _marker select [_stringsizeSTART,_stringsizeEND - _stringsizeSTART];
								_markerid = parseNumber _markerid;
								
								_shape = markerShape _marker;
								if(_shape isEqualTo 'POLYLINE')then
								{
									_puid = getPlayerUID player;
									if!(_puid isEqualTo '')then
									{
										_varuid = missionNameSpace getVariable[format['UID_BY_ID_%1',_markerid],'-1'];
										if(_puid isEqualTo _varuid)then
										{
											deleteMarker _marker;
											_log = 'Deleted drawing on a global channel!';
											systemChat ('<CQC AntiHack> '+_log);
											if(_need_hlog)then
											{
												[_name,_varuid,'SLOG',toArray(_log)] call _AHKickLog;
											};
											_need_hlog = false;
										};
									};
								}
								else
								{
									_varname = missionNameSpace getVariable[format['NAME_BY_ID_%1',_markerid],''];
									_markerText = markerText _marker;
									if(_markerText isEqualTo '')then
									{
										_marker setMarkerText format['%1: no marker text',_varname];
									}
									else
									{
										_addition = format['%1: ',_varname];
										if((_markerText find _addition) isEqualTo -1)then
										{
											_marker setMarkerText (_addition+_markerText);
										};
									};
								};
							};
						} forEach allMapMarkers;
					};
	
					if(isNil'"+_customcommandingMenu+"')then
					{
						_log = 'customcommandingMenu is Nil';
						[_name,_puid,'BAN',toArray(_log)] call _AHKickLog;
						[] call _AHKickOFF;
					}
					else
					{
						if!(str "+_customcommandingMenu+" isEqualTo str _customcommandingMenu)then
						{
							_log = format['customcommandingMenu changed: %1',"+_customcommandingMenu+"];
							[_name,_puid,'BAN',toArray(_log)] call _AHKickLog;
							[] call _AHKickOFF;
						};
					};
			
					_display49 = findDisplay 49;
					if!(serverCommandAvailable '#logout')then
					{
						if(!isNull _display49)then
						{
							if(_49openedTimer == 0)then{_49openedTimer = time;};
							(_display49 displayCtrl 2) ctrlEnable false;
							(_display49 displayCtrl 2) ctrlSetText "+str _ESCMNUTOP+";
							(_display49 displayCtrl 103) ctrlEnable false;
							(_display49 displayCtrl 103) ctrlSetText "+str _ESCMNUBOT+";
							(_display49 displayCtrl 523) ctrlSetText profileName;
							(_display49 displayCtrl 109) ctrlSetText _puid;
							(_display49 displayCtrl 122) ctrlEnable false;
							(_display49 displayCtrl 122) ctrlShow false; 
						}
						else
						{
							_49openedTimer = 0;
						};
					};
					if(!isNull _display49)then
					{ 
						(_display49 displayCtrl 120) ctrlSetText 'Fragsquad Custom CQC';   
					}; 
				};
			};
	
			if(_isNormal)then { 
				[_name,_puid,_admin,_isNormal,_admins] spawn {
					params ['_name','_puid','_admin','_isNormal','_admins'];
				
					_blacklistedVariables = "+str _blacklistedVariables+";
					_blacklistedVariables append ['JoinOrNotJoinIsTheQuestion','noRecoilRun','A3FFrun'];
					if(_admin)then
					{
						{
							_missionNamespace = missionNamespace getVariable _x;
							if(!isNil '_missionNamespace')then
							{
								missionNamespace setVariable[_x,nil];
							};
							_uiNamespace = uiNamespace getVariable _x;
							if(!isNil '_uiNamespace')then
							{
								uiNamespace setVariable[_x,nil];
							};
							_profileNamespace = profileNamespace getVariable _x;
							if(!isNil '_profileNamespace')then
							{
								profileNamespace setVariable[_x,nil];
							};
						} forEach _blacklistedVariables;
						saveProfileNamespace;
					};
				
					_lastTimeCheckedVars = time + 80;
					_alreadyCheckedVariables = "+str (uiNamespace getVariable [_randomVarsVar,[]])+";
					_alreadyCheckedVariables append "+str _badVarWhitelist+";
					_alreadyCheckedVariables append ['fnc_sendmsgtoplr','bpdcode','"+_AH_AdmiLogArrayRND+"'];
				
					while{1==1}do
					{
						_timer1 = time;
						{
							_bvc = profileNamespace getVariable [_x,0];
							if(_bvc isEqualType '')then
							{
								profileNamespace setVariable [_x,0.4];saveprofileNamespace;
								_log = format['Injector found: %1 (%2) VALUE: [%3]', _x, typeName _bvc, str _bvc];
								[_name,_puid,'HLOG_SKICK',toArray(_log)] call "+_AHKickLog+";
								[] call "+_AHKickOFF+";
							};
						} forEach [
							'igui_bcg_rgb_a','igui_bcg_rgb_r','igui_bcg_rgb_g','igui_bcg_rgb_b','IGUI_grid_mission_X','IGUI_grid_mission_Y','IGUI_grid_mission_W','IGUI_grid_mission_H', 
							'gui_grid_w','igui_grid_squadradar_y','igui_grid_slingloadassistant_h','gui_grid_x','igui_grid_stance_x','gui_titletext_rgb_r','gui_grid_y','igui_grid_stance_y',
							'gui_bcg_rgb_a','igui_grid_gps_w','igui_error_rgb_a','igui_grid_gps_x','igui_error_rgb_b','igui_grid_gps_y','igui_grid_stamina_x','gui_grid_center_w',
							'igui_grid_comm_x','gui_grid_center_x','igui_grid_stamina_y','igui_grid_radar_x','igui_grid_comm_y','gui_grid_center_y','igui_warning_rgb_a','igui_text_rgb_a',
							'igui_grid_avcamera_h','igui_grid_radar_y','igui_warning_rgb_b','igui_text_rgb_b','gui_bcg_rgb_g','igui_grid_gaugespeed_x','igui_grid_weapon_x','igui_grid_gaugespeed_y',
							'igui_error_rgb_g','igui_grid_gaugecompass_x','igui_grid_weapon_y','igui_grid_chat_w','igui_grid_vehicle_x','igui_grid_vehicle_y','igui_grid_gaugecompass_y',
							'igui_grid_chat_x','igui_grid_hint_x'
						]; 
					
						{
							_vc = missionNamespace getVariable _x;
							if(!isNil _x)then
							{
								_log = format['BadVar#1: %1 - %2',_x,_vc];
								[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
								[] call "+_AHKickOFF+";
							}
							else
							{
								if(!isNil '_vc')then
								{
									_log = format['BadVar#1 in missionNamespace: %1 - %2',_x,_vc];
									[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
									[] call "+_AHKickOFF+";
								};
							};
							_vc = player getVariable _x;
							if(!isNil '_vc')then
							{
								player setVariable[_x,nil];
								_log = format['BadVar#1 on player: %1 - %2',_x,_vc];
								[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
								[] call "+_AHKickOFF+";
							};
							_vc = uiNamespace getVariable _x;
							if(!isNil '_vc')then
							{
								_log = format['BadVar#1 in uiNamespace: %1 - %2',_x,_vc];
								[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
								[] call "+_AHKickOFF+";
							};
							_vc = profileNamespace getVariable _x;
							if(!isNil '_vc')then
							{
								profileNamespace setVariable[_x,nil];saveProfileNamespace;
								_log = format['BadVar#1 in profileNamespace: %1 - %2',_x,_vc];
								[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
								[] call "+_AHKickOFF+";
							};
						} forEach _blacklistedVariables;
					
						if(_admin)then
						{
							if(time > _lastTimeCheckedVars)then
							{
								_lastTimeCheckedVars = time + 80;
								
								{
									_var = _x;
									_varid = _alreadyCheckedVariables pushBackUnique _var;
									if(_varid > -1)then
									{
										{
											if!((toLower _var) find _x isEqualTo -1)then
											{
												_log = format['BadVar#2 found %1 in %2',_x,_var];
												[profileName,getPlayerUID player,'HLOG_SKICK',toArray(_log)] call "+_AHKickLog+";
												[] call "+_AHKickOFF+";
												missionNamespace setVariable[_var,nil];
											}
											else
											{ 
												_m = missionNamespace getVariable _var;
												if(!isNil '_m')then
												{
													_mstring = str _m;
													if((toLower _mstring) find _x != -1)then
													{
														_mstring = _mstring select [0,1000];
														_log = format['BadVar#2 found %1 in %2: %3',_x,_var,_mstring];
														[profileName,getPlayerUID player,'SLOG',toArray(_log)] call "+_AHKickLog+";
														(findDisplay 46)closeDisplay 0;
														missionNamespace setVariable[_var,nil];
													};
												}; 
											};
										} forEach "+str _verybadStrings+";
									};
								} forEach (allVariables missionNamespace);
							};
						};
				
						_sleeptimer = ((time - _timer1)*2)+1;
						uiSleep _sleeptimer;
					};
				};
				
				[_name,_puid] spawn {
					disableSerialization;
					_name = _this select 0;
					_puid = _this select 1;
					_addCaseHDMGold = -1;
					_addCaseMEHold = -1;
					while{1==1}do
					{
						if(!isNil'bis_fnc_holdAction_running')then{
							_log = 'HackAction on player: holdAction detected!';
							[_name,_puid,'HLOG_SKICK',toArray(_log)] call "+_AHKickLog+";
							[] call "+_AHKickOFF+";
						};
					
						{
							private _actionParams = player actionParams _x;
							if(!isNil'_actionParams')then
							{
								_actionParams params [
									['_actionTitle',''],
									['_script',''],
									['_arguments','']
								];
								if!(_actionTitle isEqualTo '')then
								{
									_actionParams = [_actionTitle,_script,_arguments];
									_actionTitle = toLower _actionTitle;
									{
										if(_actionTitle find _x > -1)exitWith
										{
											_log = format['HackAction on player: found [%1] in [%2]',_x,_actionParams];
											[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
											[] call "+_AHKickOFF+";
										};
									} forEach [
										':dh:','map esp','inf ammo','delete cursor','destroy target','delete target','carpet bomb',
										'godmode','no grass','jail cursor','map tp','rapid fire','creation list','spawn gear loadouts',
										'===','back to main menu','exile only','back to main menu'
									];
								};
							};
						} forEach (actionIDs player);

						uiSleep 0.2;
						
						if(!isNull player)then
						{
							if(!alive player)then
							{
								_addCaseMEHold = -1;
								_addCaseHDMGold = -1;
							};
						}
						else
						{
							_addCaseMEHold = -1;
							_addCaseHDMGold = -1;
						};
					};
				};

				[_name,_puid] spawn {
					_name = _this select 0;
					_puid = _this select 1;
					['SYSTEMLOG',format['LOCALPLAYERINFO: %1(%2) | %3(%4) | %5',_name,_puid,str _name,str _puid,str (getPlayerUID player)]] call CQC_fnc_ahLog;
					"+_netRequestVar+" = nil;
					if(!isNil '"+_netRequestVar+"')then
					{
						_log = format['BadVar#ADMIN: "+_netRequestVar+" - %1',_netRequestVar];
						[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
						[] call "+_AHKickOFF+";
					};
					while{1==1}do
					{
						_randomnombre = round(random 9999);
						"+_netRequestVar+" = _randomnombre;
						if(str "+_netRequestVar+" != str _randomnombre)then
						{
							_log = 'BadVar#ADMIN: "+_netRequestVar+"';
							[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
							[] call "+_AHKickOFF+";
						};
						if("+str _URC+")then{
							_unit = player;
							if((!isNull _unit)&&{alive _unit})then
							{
								_curecoil = unitRecoilCoefficient _unit;
								if(_curecoil < 1)then
								{
									_log = format['BadRecoil %1 | %2 %3 %4',_curecoil,typeOf _unit,typeOf (vehicle _unit),currentWeapon _unit];
									[_name,_puid,'HLOG_SKICK',toArray(_log)] call "+_AHKickLog+";
									[] call "+_AHKickOFF+";
								};
							};
						}; 
						_gpsmapstate = false;
						_gpsmapend = false;
						if((!visiblemap)&&!('ItemMap' in (assignedItems player))&&!('ItemGPS' in (assignedItems player)))then
						{
							_gpsmapstate = true;
						}; 
						uiSleep 0.2; 
						if(_gpsmapstate)then
						{
							if((visiblemap)&&('ItemMap' in (assignedItems player))&&('ItemGPS' in (assignedItems player)))then
							{
								_gpsmapend = true;
							};
						};
						if(_gpsmapend)then
						{
							_log = 'ItemsAdded: Suddenly had a GPS and a Map Item..';
							[_name,_puid,'SLOG',toArray(_log)] call "+_AHKickLog+";
							[] call "+_AHKickOFF+";
						}; 
						_uid = getPlayerUID player;
						if((_uid != '') && {_puid != _uid} && {alive player})then{
							_log = format['_puid != _uid (%1/%2) - BANNED MEMORYHACK',_puid,_uid];
							[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
							[] call "+_AHKickOFF+";
						}; 
					};
				};
			
				"+_ninetwothread+" = [_name,_puid] spawn {
					_name = _this select 0;
					_puid = _this select 1;
					_waitTime = 60;
					_mytime = diag_tickTime;
					waitUntil {((!isNil '"+_ninetwo+"') || (diag_tickTime > _mytime + _waitTime))};
					if(isNil '"+_ninetwo+"')exitWith
					{
						_log = format['Secondary checks not running.. (KICKED) - waited %1s',diag_tickTime - (_mytime + _waitTime)];
						[_name,_puid,'SLOG_SKICK',toArray(_log)] call "+_AHKickLog+";
						(findDisplay 46)closeDisplay 0;
					};
				};
				[_name,_puid,_admins] spawn {
					_name = _this select 0;
					_puid = _this select 1;
					_admins = _this select 2;
					_ForbiddenItems = "+str _ForbiddenItems+";
					_caeM1 = 0;
					_caeM2 = 0;
					_vehptype = typeOf (vehicle player);
					_rnd6 = round(random 99999);"+_checkidicheckcheck+" = _rnd6;
					if(isNil'inSafeZone')then{inSafeZone=false;};
					_fnc_hasTV = {
						if('optic_tws' in _primWeapItems)exitWith{false};
						if('optic_tws_mg' in _primWeapItems)exitWith{false};
						if('optic_mas_term' in _primWeapItems)exitWith{false};
						if('Laserdesignator' in _primWeapItems)exitWith{false};
						if('acc_mas_pointer_IR' in _primWeapItems)exitWith{false};
						if('acc_pointer_IR' in _primWeapItems)exitWith{false};
						true
					};
					_fnc_hasNV = {
						if('optic_Nightstalker' in _primWeapItems)exitWith{false};
						if('optic_NVS' in _primWeapItems)exitWith{false};
						true
					};
					while{1==1}do
					{
						if(typeName _puid != 'STRING')then
						{
							_log = format['PUID BROKEN: %1',_puid];
							[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
							[] call "+_AHKickOFF+";
						};
						if(isNil 'inSafeZone')then
						{
							_log = 'inSafeZone is Nil';
							[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
							[] call "+_AHKickOFF+";
						}
						else
						{
							if(typeName inSafeZone != 'BOOL')then
							{
								_log = format['inSafeZone type changed: %1 - %2',typeName inSafeZone,inSafeZone];
								[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
								[] call "+_AHKickOFF+";
							};
						};
						if(isNil '"+_checkidicheckcheck+"')then
						{
							_log = 'AntiAntiHack #2';
							[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
							[] call "+_AHKickOFF+";
						};
						if!(_rnd6 isEqualTo "+_checkidicheckcheck+")then
						{
							_log = 'AntiAntiHack #3';
							[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
							[] call "+_AHKickOFF+";
						};
					
						_inventory = [];
						{_inventory pushBack _x;} forEach (assignedItems player);
						{_inventory pushBack _x;} forEach (magazines player);
						{_inventory pushBack _x;} forEach (weapons player);
						{_inventory pushBack _x;} forEach (primaryWeaponItems player);
						{_inventory pushBack _x;} forEach (secondaryWeaponItems player);
						{_inventory pushBack _x;} forEach (items player);
						_inventory pushBack (primaryWeapon player);
						_inventory pushBack (secondaryWeapon player);
						_inventory pushBack (uniform player);
						_inventory pushBack (vest player);
						_inventory pushBack (backpack player);
						_inventory pushBack (headgear player);
						_inventory pushBack (goggles player);
						if!(_inventory isEqualTo [])then
						{
							{
								if(_x != '')then
								{
									if(_x in _ForbiddenItems)then
									{
										player removeItem _x;
										player removeWeapon _x;
										player removeMagazine _x;
										if((uniform player) == _x)then{removeUniform player;};
										if((vest player) == _x)then{removeVest player;};
										if((backpack player) == _x)then{removeBackpack player;};
										if((headgear player) == _x)then{removeHeadgear player;};
										if((goggles player) == _x)then{removeGoggles player;};
										player removePrimaryWeaponItem _x;
										player removeSecondaryWeaponItem _x;
										player unlinkItem _x;
										_log = format['BadItem: %1 (might have been from an admin!)',_x];
										[_name,_puid,'SLOG',toArray(_log)] call "+_AHKickLog+";
									};
								};
							} forEach _inventory;
						};
		
						if(!isNull player)then
						{
							"; if(_CVM)then{ _expression = _expression + "
								if(player == vehicle player)then
								{
									private['_curwep','_pvision','_primWeapItems','_pitems'];
									_curwep=currentWeapon player;
									_pvision=currentVisionMode player;
									_primWeapItems=primaryWeaponItems player;
									_pitems=items player;
									if('Rangfinder_mas_h' in _pitems)exitWith{};
									if((_pvision > 1)&&(call _fnc_hasTV))then
									{
										_log = format['BadVisionMode: Thermal (%1) current weapon: %2 | weaponsItems player: %3',_pvision,_curwep,weaponsItems player];
										[_name,_puid,'HLOG',toArray(_log)] call "+_AHKickLog+";
										(findDisplay 46)closeDisplay 0;
									};
								};
							"; }; _expression = _expression + "
							"; if(_LVC)then{ _expression = _expression + "
								_veh = vehicle player;
								if(!(player isEqualTo _veh) && !(_vehptype isEqualTo (typeOf _veh)))then
								{
									_vehptype = typeOf _veh;
									if((toLower _vehptype) find 'chute' == -1)then
									{
										[_name,_puid,'LVC',player,_vehptype,mapGridPosition _veh] call "+_AHKickLog+";
									};
								};
							"; }; _expression = _expression + "
						}; 
						uiSleep 2;
					 
						if(!isNull player)then
						{
							if(alive player)then
							{
								_closeObjects = (player nearObjects 15);
								if(!isNil'_closeObjects')then
								{
									{
										if(!isNull _x)then
										{
											if(_x isEqualTo player)exitWith{};
											_type = typeOf _x;
											
											(vehicle player) enableCollisionWith _x;player enableCollisionWith _x;
											  
											if(_type == 'Box_IND_AmmoVeh_F')then
											{
												_var = _x getVariable['"+_adminbox+"',''];
												if(!isNil '_var')then
												{
													if(_var == '')then{player setPosATL (player modelToWorld [0,-8,0]);};
												};
											};
										};
									} forEach _closeObjects;
								};
						 
								_veh = vehicle player;
								if(_veh != player)then
								{
									_veh enableRopeAttach false;
									_ropes = ropes _veh;
									if!(_ropes isEqualTo [])then
									{
										_log = format['RopeHack?: %1',_ropes];
										[_name,_puid,'HLOG',toArray(_log)] call "+_AHKickLog+";
										{ropeDestroy _x;} forEach _ropes;
									};
								};
							 
								_closeveh = [vehicle player] + ((vehicle player) nearEntities ['AllVehicles',250]);
								{
									_xobj = _x;
									if(!isNull _xobj)then
									{
										_attcheXdobjects = attachedObjects _x;
										if(count _attcheXdobjects > 0)then
										{
											_cntQd = {(toLower (typeOf _x)) find 'quad' != -1} count _attcheXdobjects;
											if(_cntQd > 5)then
											{
												detach _xobj;
												{detach _x;} forEach _attcheXdobjects;
												if(_xobj == vehicle player)then
												{
													_log = format['AttachTo Hack @%1 %2',position _xobj,mapGridPosition _xobj];
													[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
													[] call "+_AHKickOFF+";
												}
												else
												{
													_log = format['Attached Objects found @%1 %2  Hack?!',position _xobj,mapGridPosition _xobj];
													[_name,_puid,'HLOG',toArray(_log)] call "+_AHKickLog+";
												};
											};
										 
											_pobject = vehicle player;
											if(!isNil '_pobject')then
											{
												if(!isNull _pobject)then
												{
													if(alive _pobject)then
													{
														if(_pobject in _attcheXdobjects)then
														{
															_log = format['AttachTo Hack: %1   @%2 %3',name _xobj,position player,mapGridPosition player];
															[_name,_puid,'BAN',toArray(_log)] call "+_AHKickLog+";
															[] call "+_AHKickOFF+";
														};
													};
												};
											};
										
										};
									 
										_firstx = _xobj;{ropeDestroy _x;} forEach (ropes _firstx);
								 
									};
								} forEach _closeveh;
							};
						};
						"+_ninetwo+" = true;
						if(!isNil '"+_ninetwothread+"')then{terminate "+_ninetwothread+";"+_ninetwothread+" = nil;};
					};
				};
			}; 

			{_x enableChannel [(channelEnabled _x) select 0, false];} forEach "+str (_disAllowVon - [5])+";
			systemChat format['%1 <CQC AntiHack> Successfully Loaded In.',time];
			"+_massMessage+"=nil;'"+_massMessage+"' addPublicVariableEventHandler {(_this select 1) spawn bis_fnc_dynamictext;"+_massMessage+"=nil;};
			"+_massSysMessage+"=nil;'"+_massSysMessage+"' addPublicVariableEventHandler {systemChat (_this select 1);"+_massSysMessage+"=nil;};
			"+_clientdo+"=nil;'"+_clientdo+"' addPublicVariableEventHandler {call compile (_this select 1);"+_clientdo+"=nil;};
			if(!isNil 'BPDCODE')then{call BPDCODE;BPDCODE=nil;}; 
			setTerrainGrid "+str _TGV+"; 
			setViewDistance "+str _VDV+"; 
			setObjectViewDistance "+str _VOV+"; 
			"+_AH_RunCheckENDVAR+" = 'k';
		};
		"+_AH_MAIN_BLOCK+" = _AH_MAIN_BLOCK;

		[] spawn { 
			private _admins = "+str _admins+"; 

			private _DO_THIS_MORE_OFTEN_ID = format['persis%1',round(random 9999)];
			private _DO_THIS_MORE_OFTEN = {
				missionNameSpace setVariable['""+_antiantihack_rndvar+""',nil];
				[] spawn {
					scriptName format['MORE_OFTEN_%1',time];
					uiSleep 1;
					if(isNil '""+_antiantihack_rndvar+""')then{
						['SYSTEMLOG','kicked to lobby #9'] call CQC_fnc_ahLog; 
						(findDisplay 46)closeDisplay 0;
					};
				};
				if(isNil'""+_antiantihack_rndvar+""')then{  
					missionNameSpace setVariable['""+_antiantihack_rndvar+""','""+_antiantihack_rndvar+""'];
				};
				if(hasInterFace)then
				{ 
					if(isNil'"+_AH_RunCheckENDVAR_THREAD+"')then
					{
						"+_AH_RunCheckENDVAR_THREAD+" = [] spawn {
							scriptName format['RUNCHECK_%1',time];
							_temptime = diag_tickTime + 200;
							waitUntil {diag_tickTime > _temptime || getClientStateNumber >= 10};
							if(diag_tickTime > _temptime)then {
								findDisplay 46 closeDisplay 0;
								findDisplay 8 closeDisplay 0;
							};
							_temptime = diag_tickTime + 300;
							waitUntil {diag_tickTime > _temptime || !isNil '"+_AH_RunCheckENDVAR+"'};
							if("+_AH_RunCheckENDVAR+" isEqualType '')then
							{
								if!("+_AH_RunCheckENDVAR+" isEqualTo 'k')then
								{
									_log = 'AH_RunCheck is not defined';
									[profileName,getPlayerUID player,'HLOG_SKICK',toArray(_log)] call "+_AHKickLog+";
									[] call "+_AHKickOFF+";
								};
							}
							else
							{
								_log = 'AH_RunCheck broken!';
								[profileName,getPlayerUID player,'BAN',toArray(_log)] call "+_AHKickLog+";
								[] call "+_AHKickOFF+";
							};
						};
					}; 
					[] spawn {
						scriptName format['MEMORY_HACK_CHECK_%1',time];
						_UMH_ARRAYSERVER = "+str _UMH_ARRAYSERVER+";
						_UMH_ARRAY = "+str _UMH_ARRAY+";
						{
							_curarray = _UMH_ARRAY select _forEachIndex;
							_string = call compile (_curarray select 0);
							_sarray = toArray _string;
							if!(_sarray isEqualTo _x)then
							{
								_is = toString _sarray;
								_sb = toString _x;
								_log = format['Memoryhack %1 %2 changed: %3, %4',_curarray select 1,_curarray select 2,_is,_sb];
								[profileName,getPlayerUID player,'BAN',toArray(_log)] call "+_AHKickLog+";
								[] call "+_AHKickOFF+";
							};
						} forEach _UMH_ARRAYSERVER;
					}; 
				};
			};

			private _timer0 = time + 20;
			private _timer1 = time + 35;
			
			while{1==1}do
			{
				if(time > _timer0)then
				{
					_timer0 = time + 20; 
					'"+_AH_KICKLOG+"' addPublicVariableEventHandler {(_this select 1) call "+_FNC_AH_KICKLOGSPAWN+";};
					['',_DO_THIS_MORE_OFTEN,-2,_DO_THIS_MORE_OFTEN_ID] call CQC_fnc_remoteExec; 
					{deleteVehicle _x;} forEach allMines;
					{deleteVehicle _x;} forEach allUnitsUAV;  
				};
				
				if(time > _timer1)then
				{
					_timer1 = time + 35;
					
					{
						if(isPlayer _x && alive _x)then
						{
							_uid = getPlayerUID _x;
							if(_uid isEqualTo '')exitWith{};
							_owner = owner _x;
							_name = name _x;				
							
							[_name, _uid] call "+_checkGlobalBanState+";
							
							private _namePlayerObject = _x getVariable 'playerName';
							if(isNil '_namePlayerObject')then
							{
								_x setVariable['playerName',_name,true];
							}
							else
							{
								if!(_namePlayerObject isEqualTo _name)then
								{
									_x setVariable['playerName',_name,true];
								};
							};
							
							_puidPlayerObject = _x getVariable['PUID','-1'];
							if!(_puidPlayerObject isEqualTo _uid)then{ _x setVariable['PUID',_uid]; };
							
						"; if(_UVC)then{ _expression = _expression + "
							_veh = objectParent _x;
							if(!isNull _veh)then
							{
								if(_veh getVariable ['"+_vehicle_needs_check+"',true])then
								{
									_veh setVariable ['"+_vehicle_needs_check+"',false];
									
									_type = typeOf _veh;
									if((!("+str _UVW+") && {_type in "+str _ForbiddenVehicles+"}) || (("+str _UVW+") && {!(_type in "+str _VehicleWhiteList+")}))then
									{
										_crew = crew _veh;
										if(call{{if((getPlayerUID _x) in "+_adminsA+")exitWith{true};false} forEach _crew;})exitWith{};
										
										_log = format['BadVehicle (S-UVC): %1',_type];
										{
											_xname = name _x;
											_xuid = getPlayerUID _x;
											[_xname,_xuid,'HLOG',toArray(_log)] call "+_FNC_AH_KICKLOG+";
										} forEach _crew;
										_veh call CQC_fnc_deleteObject;
									};
								};
							};
						"; }; _expression = _expression + "
						};
					} forEach allPlayers;
				};
				uiSleep 7;
				SERVER_FPS = diag_fps;publicVariable 'SERVER_FPS';
				SERVER_THREADS = count diag_activeSQFScripts;publicVariable 'SERVER_THREADS';
			};

			['HACKLOG',format['%1 - LOOP - BROKEN!',time]] call CQC_fnc_ahLog;
		};

		[
			'',
			{
				if(hasInterface)then
				{
					_AHKickOFF = compileFinal '[] spawn {scriptName ''KICKOFF'';sleep 0.1;(findDisplay 46)closeDisplay 0;if(!isNil''"+_AHKickLog+"'')then{[profileName,getPlayerUID player,''KICKME''] call "+_AHKickLog+";};};';
					if(isNil'"+_AHKickOFF+"')then{"+_AHKickOFF+" = _AHKickOFF;};
					if(str _AHKickOFF != str "+_AHKickOFF+")then{[] call _AHKickOFF;};
					_AHKickLog = compileFinal ""
						if(!isNil'"+_YourPlayerToken+"')then
						{
							"+_AH_KICKLOG+" = ["+_YourPlayerToken+",_this,netId player];publicVariableServer '"+_AH_KICKLOG+"';"+_AH_KICKLOG+"=nil;
						}
						else
						{
							_this spawn {
								scriptName format['KICKOFF_%1',_this];
								_temptime = time+15;_tempdiagtime = diag_tickTime+15;
								waitUntil{!isNil '"+_YourPlayerToken+"' || time > _temptime || diag_tickTime > _tempdiagtime};
								if(isNil'"+_YourPlayerToken+"')exitWith{KICKED_FOR_NIL_TOKEN_AHKickLog = format['PLAYER__%1__%2',getPlayerUID player,_this];publicVariableServer 'KICKED_FOR_NIL_TOKEN_AHKickLog';(findDisplay 46)closeDisplay 0;};
								"+_AH_KICKLOG+" = ["+_YourPlayerToken+",_this,netId player];publicVariableServer '"+_AH_KICKLOG+"';"+_AH_KICKLOG+"=nil;
							};
						};
					"";
					if(isNil'"+_AHKickLog+"')then{"+_AHKickLog+" = _AHKickLog;};
					if(str _AHKickLog != str "+_AHKickLog+")then{[] call _AHKickOFF;};
					if(!isNil'"+_TokenCT+"')then{if(typeName "+_TokenCT+" == 'SCRIPT')then{terminate "+_TokenCT+";}else{TOKENCT_BROKEN='TOKENCT_BROKEN';publicVariableServer'TOKENCT_BROKEN';[] call _AHKickOFF;};};
					"+_TokenCT+" = [_AHKickOFF] spawn {
						scriptName format['TokenCT_%1',time];
						private['_tmpYourPlayerToken','_AHKickOFF'];
						_AHKickOFF = _this select 0;
						waitUntil {!isNil '"+_YourPlayerToken+"'};
						_tmpYourPlayerToken = "+_YourPlayerToken+";
						if(typeName "+_YourPlayerToken+" != 'STRING')then{TOKEN_NO_STRING='TOKEN_NO_STRING';publicVariableServer'TOKEN_NO_STRING';};
						waitUntil {if(isNil'"+_YourPlayerToken+"')then{"+_YourPlayerToken+"='';};str _tmpYourPlayerToken != str "+_YourPlayerToken+"};
						TOKEN_BROKEN='TOKEN_BROKEN';publicVariableServer'TOKEN_BROKEN';
						[] call _AHKickOFF;
					};
					
					inGameUISetEventHandler ['PrevAction','false'];
					inGameUISetEventHandler ['NextAction','false'];
					inGameUISetEventHandler ['Action','false'];
					_bis_fnc_diagkey = uiNamespace getVariable['bis_fnc_diagkey',{false}];
					if(!isNil'_bis_fnc_diagkey')then{if!((str _bis_fnc_diagkey) in ['{false}','{}'])then{bis_fnc_diagkeychanged='bis_fnc_diagkeychanged';publicVariableServer'bis_fnc_diagkeychanged';};};
				};
			},
			-2,
			'zerocodeJIP'
		] call CQC_fnc_remoteExec;
 
		['SYSTEMLOG','antihackPayload compiled and ran..'] call CQC_fnc_ahLog;

		"+_compile2Var+" = toString [67,81,67];

		true 
	";
	
	//-- Load Anti Hack
	_runCheck = [] call compile _expression;
	switch (true) do {
		case (isNil "_expression"): 			                               {_runCheck="_expression | 2 | nil scope"};
		case (isNil {_runCheck}): 										       {_runCheck="_expression | 2 | nil run check"};
		case (_runCheck isEqualTo false): 								       {_runCheck="_expression | 2 | run check failed"};
		case (isNil {(missionNamespace getVariable _compile2Var)}): 		   {_runCheck="_expression | 2 | nil endvar"};
		case ((missionNamespace getVariable _compile2Var) isNotEqualTo "CQC"): {_runCheck=format["_expression | 2 | bad endvar %1 should be CQC",_compile2Var]};
	};
	if(typeName _runCheck isEqualTo "STRING") exitWith {
		['SYSTEMLOG',_runCheck] call CQC_fnc_ahLog;
		throw false;
	};
	
	//-- Admin Menu
	_runCheck = false;
	_expression = " 
		fnc_admin_c = compile 'compile _this';
		fnc_admin_cc = compile 'call compile _this';
		fnc_admin_ccc = compile 'if(!isNil {call compile _this})then{call compile _this}else{''ANY''}';
		fnc_createctrl = {
			params['_display','_type','_idc'];
			ctrlDelete (_display displayCtrl _idc);
			_ctrl = _display ctrlCreate[_type, _idc];
			_ctrl
		};
		FN_SHOW_LOGID = 554466;
		FN_SHOWN_LOGIDS = [];
		FN_SHOW_LOG = {
			disableSerialization;
			_del = {FN_SHOWN_LOGIDS = FN_SHOWN_LOGIDS - [_this];ctrlDelete _this;};
			{
				if(_forEachIndex < 3)then
				{
					if(count FN_SHOWN_LOGIDS > 40)then{_x call _del;};
				}
				else
				{
					if(ctrlFade _x > 0.9)then{_x call _del;};
				};
			} forEach FN_SHOWN_LOGIDS;
			_ctrl = [findDisplay 46,'RSCText',FN_SHOW_LOGID] call fnc_createctrl;
			FN_SHOW_LOGID = FN_SHOW_LOGID + 1;
			FN_SHOWN_LOGIDS pushBackUnique _ctrl;
			{
				_x ctrlSetPosition [
					0,
					((safeZoneY+0.3) + (_forEachIndex / 30)),
					1.3,
					0.2
				];
				_x ctrlCommit 0;
			} forEach FN_SHOWN_LOGIDS;
			_ctrl ctrlSetText format['<CQC AntiHack> %1',_this];
			_ctrl ctrlSetFade 1;
			_ctrl ctrlCommit 5;
		};
		"+_adminMenuUID+" = getPlayerUID player;
		ALT_IS_PRESSED=false;FILLMAINSTATE=0;LASTSUBBUTTON=1;
		CQC_var_adminSortByName = true;CQC_var_adminSortByRank = nil;CQC_var_adminSortByDistance = nil;
		CQC_add_vehicles=true;
		SELECTED_TARGET_PLAYER = player;
		show_spectate_overlay = true;
		MAIN_DISPLAY_ID = -1338;LEFT_CTRL_ID = 1500;RIGHT_CTRL_ID = 1501;
		draw_infiESPIcon = getText(configfile >> 'cfgGroupIcons' >> 'Empty' >> 'icon');
		uiNamespace setVariable['A3MAPICONS_mainMap', nil];
		uiNamespace setVariable['A3MAPICONS_mainMap', findDisplay 12 displayCtrl 51];
		if(isNil 'AH_HackLogArray')then{AH_HackLogArray = [];};
		if(isNil 'AH_SurvLogArray')then{AH_SurvLogArray = [];};
		if(isNil 'AH_AdmiLogArray')then{AH_AdmiLogArray = [];};
		if(isNil 'CQC_toggled_A')then{CQC_toggled_A = ['==== OnTarget ====','==== Toggleable ===='];};
		if(isNil 'ALL_BAGS_TO_SEARCH_C')then
		{
			ALL_BAGS_TO_SEARCH_C = [];
			ALL_VEHS_TO_SEARCH_C = [];
			ALL_OBJS_TO_SEARCH_C = [];
			ALL_WEPS_TO_SEARCH_C = [];
			ALL_MAGS_TO_SEARCH_C = [];
			_cfg = configFile >> 'cfgVehicles';
			for '_j' from 0 to (count _cfg)-1 do
			{
				_c = _cfg select _j;
				if(isClass _c)then
				{
					_t = configName _c;
					if(toLower _t find '_base' isEqualTo -1)then
					{
						_BackPack = getText(configfile >> 'CfgVehicles' >> _t >> 'vehicleClass') == 'BackPacks';
						if(_BackPack)then
						{
							ALL_BAGS_TO_SEARCH_C pushBack _t;
						}
						else
						{
							if((_t isKindOf 'Air') || (_t isKindOf 'LandVehicle') || (_t isKindOf 'Ship'))then
							{
								_pic = getText(_c >> 'picture');
								if!((toLower _pic) in ['','pictureheal','picturepapercar','picturething','picturestaticobject'])then
								{
									ALL_VEHS_TO_SEARCH_C pushBack _t;
								};
							}
							else
							{
								if((_t isKindOf 'Building') || (_t isKindOf 'ThingX') || (_t isKindOf 'Constructions_static_F') || (_t isKindOf 'Constructions_foundation_F'))then
								{
									_lt = toLower _t;
									if((_lt find 'weapon' == -1) && (_lt find 'proxy' == -1))then
									{
										ALL_OBJS_TO_SEARCH_C pushBack _t;
									};
								};
							};
						};
					};
				};
			};
			_cfg = configFile >> 'CfgWeapons';
			for '_i' from 0 to (count _cfg)-1 do
			{
				_c = _cfg select _i;
				if(isClass _c)then
				{
					_t = configName _c;
					if(toLower _t find '_base' isEqualTo -1)then
					{
						if((getText(_c >> 'displayName') != '') && {getText(_c >> 'picture') != ''} && {getNumber(_c >> 'scope') in [0,2]})then
						{
							ALL_WEPS_TO_SEARCH_C pushBack _t;
						};
					};
				};
			};
			_cfg = configFile >> 'cfgmagazines';
			for '_i' from 0 to (count _cfg)-1 do
			{
				_c = _cfg select _i;
				if(isClass _c)then
				{
					_t = configName _c;
					if(toLower _t find '_base' isEqualTo -1)then
					{
						if((getText(_c >> 'displayName') != '') && {getText(_c >> 'picture') != ''} && {getNumber(_c >> 'scope') in [0,2]})then
						{
							ALL_MAGS_TO_SEARCH_C pushBack _t;
						};
					};
				};
			};
			ALLC_TO_SEARCH = ALL_BAGS_TO_SEARCH_C+ALL_VEHS_TO_SEARCH_C+ALL_OBJS_TO_SEARCH_C+ALL_WEPS_TO_SEARCH_C+ALL_MAGS_TO_SEARCH_C;
		};
		['SYSTEMLOG','config data loaded..'] call CQC_fnc_ahLog; 
		fnc_setFocus = {
			disableSerialization;
			ctrlSetFocus ((findDisplay MAIN_DISPLAY_ID) displayCtrl LEFT_CTRL_ID);
			ctrlSetFocus ((findDisplay MAIN_DISPLAY_ID) displayCtrl RIGHT_CTRL_ID);
		};
		fnc_MouseButtonDown = {
			if(_this select 1 == 0)then
			{
				_pos = ((_this select 0) posScreenToWorld [_this select 2, _this select 3]);
				if(ALT_IS_PRESSED)then
				{
					_veh = vehicle player;
					if(_veh == player)then
					{
						_veh setPosATL _pos;
					}
					else
					{
						if(_veh isKindOf 'AIR')then
						{
							_posObj = getPosATL _veh;
							_pos = [_pos select 0,_pos select 1,_posObj select 2];
						};
						[1,player,_veh,_pos] call fnc_AdminReq;
					};
					ALT_IS_PRESSED = false;
					format['Teleport to %1(GPS: %2)',_pos,mapGridPosition _pos] call fnc_adminLog;
					{player reveal _x;} foreach (_pos nearObjects 50);
				};
				if(!isNil 'CALLED_EMP')then
				{
					CALLED_EMP = nil;
					_pos call fnc_callEMP;
				};
				if(!isNil 'fnc_getParachutePos')then
				{
					_pos call fnc_getParachutePos;
				};
			};
		};
		fnc_addpic = {
			_status = call {
				if(isClass (configFile >> 'CfgWeapons' >> _this))exitWith{'CfgWeapons'};
				if(isClass (configFile >> 'CfgMagazines' >> _this))exitWith{'CfgMagazines'};
				if(isClass (configFile >> 'CfgVehicles' >> _this))exitWith{'CfgVehicles'};
				'';
			};
			if!(_status isEqualTo '')then
			{
				_pic = (getText (configFile >> _status >> _this >> 'picture'));
				if!(_pic isEqualTo '')then
				{
					_ctrl lbSetPicture [(lbsize _ctrl)-1,_pic];
					_ctrl lbSetPictureColor [(lbsize _ctrl)-1,[1, 1, 1, 1]];
				};
			};
		};
		fnc_search = {
			[_txt] spawn {
				_txt = _this#0;
				if(_txt == lastSearched)exitWith{};
				disableSerialization;
				_ctrl = (findDisplay MAIN_DISPLAY_ID) displayCtrl RIGHT_CTRL_ID;
				lbClear _ctrl;
				if(LASTSUBBUTTON isEqualTo 0)then
				{
					if('==== Weapons ====' call "+_adminsUIDAccses+")then
					{
						_ctrl lbAdd '==== Weapons ====';
						if(!isNil 'CQC_add_weapons')then
						{
							{
								_displayName = getText(configFile >> 'CfgWeapons' >> _x >> 'displayName');
								if(((toLower _x) find _txt > -1)||((toLower _displayName) find _txt > -1))then{
									_ctrl lbAdd format['%1 (%2)',_displayName,_x];
									_x call fnc_addpic;
									_ctrl lbSetData [(lbsize _ctrl)-1,_x];
								};
							} forEach ALL_WEPS_TO_SEARCH_C;
						};
					};
					if('==== Magazines ====' call "+_adminsUIDAccses+")then
					{
						_ctrl lbAdd '==== Magazines ====';
						if(!isNil 'CQC_add_magazines')then
						{ 
							{
								_displayName = getText(configFile >> 'CfgMagazines' >> _x >> 'displayName');
								if(((toLower _x) find _txt > -1)||((toLower _displayName) find _txt > -1))then{
									_ctrl lbAdd format['%1 (%2)',_displayName,_x];
									_x call fnc_addpic;
									_ctrl lbSetData [(lbsize _ctrl)-1,_x];
								};
							} forEach ALL_MAGS_TO_SEARCH_C;
						};
					};
					if('==== Bags ====' call "+_adminsUIDAccses+")then
					{
						_ctrl lbAdd '==== Bags ====';
						if(!isNil 'CQC_add_bags')then
						{ 
							{
								_displayName = getText(configFile >> 'CfgVehicles' >> _x >> 'displayName');
								if(((toLower _x) find _txt > -1)||((toLower _displayName) find _txt > -1))then{
									_ctrl lbAdd format['%1 (%2)',_displayName,_x];
									_x call fnc_addpic;
									_ctrl lbSetData [(lbsize _ctrl)-1,_x];
								};
							} forEach ALL_BAGS_TO_SEARCH_C;
				
						};
					}; 
				};
				if(LASTSUBBUTTON isEqualTo 1)then
				{
					if('==== Vehicles ====' call "+_adminsUIDAccses+")then
					{
						_ctrl lbAdd '==== Vehicles ====';
						if(!isNil 'CQC_add_vehicles')then
						{ 
							{
								_displayName = getText(configFile >> 'CfgVehicles' >> _x >> 'displayName');
								if(((toLower _x) find _txt > -1)||((toLower _displayName) find _txt > -1))then{
									_ctrl lbAdd format['%1 (%2)',_displayName,_x];
									_x call fnc_addpic;
									_ctrl lbSetData [(lbsize _ctrl)-1,_x];
								};
							} forEach ALL_VEHS_TO_SEARCH_C; 
						};
					};
				};
				if(LASTSUBBUTTON isEqualTo 2)then
				{
					if('==== Objects ====' call "+_adminsUIDAccses+")then
					{
						_ctrl lbAdd '==== Objects ====';
						if(!isNil 'CQC_add_objects')then
						{
							_ctrl lbAdd '   ==== Objects ====';
							{
								_displayName = getText(configFile >> 'CfgVehicles' >> _x >> 'displayName');
								if(((toLower _x) find _txt > -1)||((toLower _displayName) find _txt > -1))then{
									_ctrl lbAdd format['%1 (%2)',_displayName,_x];
									_ctrl lbSetData [(lbsize _ctrl)-1,_x];
								};
							} forEach ALL_OBJS_TO_SEARCH_C;
						};
					};
				};
				lastSearched = _txt;
				[] call fnc_colorizeMain;
				for '_i' from 0 to 10 do{_ctrl lbAdd '';};
			};
		};
		fnc_searchNfill = {
			if(isNil 'SEARCHLOOP')then{
				SEARCHLOOP = true;
				if(isNil 'lastSearched')then{lastSearched = '';};
				[] spawn {
					disableSerialization;
					while {true} do
					{
						if(isNull (findDisplay MAIN_DISPLAY_ID))exitWith{};
						if(!isNil 'stopthissearchplease')exitWith{stopthissearchplease=nil;};
						_txt = ctrlText((findDisplay MAIN_DISPLAY_ID) displayCtrl 100);
						if(_txt isEqualTo '')then
						{
							[] call fnc_fill_CQC_Player;
							waitUntil {((ctrlText((findDisplay MAIN_DISPLAY_ID) displayCtrl 100) != '')||(isNull (findDisplay MAIN_DISPLAY_ID))||(!isNil 'stopthissearchplease'))};
						}
						else
						{
							_txt = toLower _txt;
							if(FILLMAINSTATE isEqualTo 1)then
							{
								call fnc_search;
							}
							else
							{
								_ctrl = (findDisplay MAIN_DISPLAY_ID) displayCtrl LEFT_CTRL_ID;
								lbclear _ctrl;
								{
									_PUIDX = getPlayerUID _x;
									_name = _x getVariable['playerName',name _x];
									if((toLower _name) find _txt > -1)then
									{
										private _side = side _x;  
										private _veh = vehicle _x;
										private _xpic = getText (configFile >> 'CfgVehicles' >> (typeOf _veh) >> 'picture'); 
										private _clr = _PUIDX call CQC_fnc_getPlayercolor;
										private _name = format['%1 [%2]',_name,_PUIDX call CQC_fnc_getPlayerRank];  
										private _index = _ctrl lbAdd _name; 
										_ctrl lbSetData [(lbsize _ctrl)-1,'1'];

										if(alive _x)then
										{
											if(_x isEqualTo _veh)then
											{
												_wpnstate = weaponState _x;
												_cwep = _wpnstate select 0;
												if(_cwep != '')then
												{
													_xpic = getText (configFile >> 'CfgWeapons' >> _cwep >> 'picture');
												};
											};
										};
										if!(_xpic isEqualTo '')then
										{
											_ctrl lbSetPicture [_index,_xpic];
											_ctrl lbSetPictureColor [_index,[1, 1, 1, 1]];
										};

										_ctrl lbSetColor [_index,_clr];
									};
								} forEach (call fnc_CQC_get_LeftClicks);
							};
						};
						uiSleep 0.1;
					};
					SEARCHLOOP = nil;
				};
			};
		};
		fnc_SearchFieldButtons = {
			disableSerialization;
			_display = findDisplay MAIN_DISPLAY_ID;
			_others=false;
			if(FILLMAINSTATE == 1)then{_others = true;};
			
			_editSearch = _display displayCtrl 100;
			_editSearch ctrlEnable true;
			_editSearch ctrlShow true;
			_editSearch ctrlSetTextColor [0.56,0.04,0.04,1];
			_editSearch ctrlSetText '';
			
			_btnWep = _display displayCtrl 26;
			_btnWep ctrlEnable false;
			_btnWep ctrlShow false;
			
			_btnMag = _display displayCtrl 27;
			_btnMag ctrlEnable false;
			_btnMag ctrlShow false;
			
			_btnBackp = _display displayCtrl 28;
			_btnBackp ctrlEnable false;
			_btnBackp ctrlShow false;
			
			_btnVest = _display displayCtrl 29;
			_btnVest ctrlEnable false;
			_btnVest ctrlShow false;
			
			_btnUniform = _display displayCtrl 30;
			_btnUniform ctrlEnable false;
			_btnUniform ctrlShow false;
			
			_btnTools = _display displayCtrl 31;
			_btnTools ctrlEnable false;
			_btnTools ctrlShow false;
			
			_btnItems = _display displayCtrl 36;
			_btnItems ctrlEnable true;
			_btnItems ctrlShow true;
			_btnItems buttonSetAction '
				LASTSUBBUTTON = 0;FILLMAINSTATE=1;[] call fnc_fill_CQC_MAIN;[] call fnc_setFocus;[] call fnc_colorButtons;
			';
			
			
			_ctrlL = _display displayCtrl LEFT_CTRL_ID;
			if(isNil 'ctrlposL')then{ctrlposL = ctrlPosition _ctrlL;};
			_ctrlLTMP = ctrlposL;
			if(isNil 'ctrlposeditSearch')then{ctrlposeditSearch = ctrlPosition _editSearch;};
			_ctrleditSearchTMP = ctrlposeditSearch;
			if(isNil 'ctrlposbtnItems')then{ctrlposbtnItems = ctrlPosition _btnItems;};
			_ctrlbtnItemsTMP = ctrlposbtnItems;
			if(FILLMAINSTATE in [0,3,4])then
			{
				_btnItems ctrlSetText 'Reset PlayerSearch';
				_btnItems buttonSetAction '
					((findDisplay MAIN_DISPLAY_ID) displayCtrl 100) ctrlSetText '''';
					[] call fnc_fill_CQC_Player;
				';
				
				
				_ctrlLTMP = [(ctrlposL select 0),(ctrlposL select 1)+.165,(ctrlposL select 2),(ctrlposL select 3)-.165];
				_ctrleditSearchTMP = [SafeZoneX,(ctrlposeditSearch select 1)-0.045,(ctrlposL select 2),(ctrlposeditSearch select 3)*0.75];
				_ctrlbtnItemsTMP = [SafeZoneX,(ctrlposbtnItems select 1)-0.035,(ctrlposL select 2),(ctrlposbtnItems select 3)];
			};
			_ctrlL ctrlSetPosition _ctrlLTMP;
			_ctrlL ctrlCommit 0.3;
			_editSearch ctrlSetPosition _ctrleditSearchTMP;
			_editSearch ctrlCommit 0.3;
			_btnItems ctrlSetPosition _ctrlbtnItemsTMP;
			_btnItems ctrlCommit 0.3;
			
			if(FILLMAINSTATE == 1)then{
				_btnItems ctrlSetText 'Items';
				_btnItems buttonSetAction '
					LASTSUBBUTTON = 0;FILLMAINSTATE=1;[] call fnc_fill_CQC_MAIN;[] call fnc_setFocus;[] call fnc_colorButtons;
				';
			};
			
			_btnVehs = _display displayCtrl 37;
			_btnVehs ctrlEnable _others;
			_btnVehs ctrlShow _others;
			_btnVehs buttonSetAction '
				LASTSUBBUTTON = 1;FILLMAINSTATE=1;[] call fnc_fill_CQC_MAIN;[] call fnc_setFocus;[] call fnc_colorButtons;
			';
			
			_btnMisc = _display displayCtrl 38;
			_btnMisc ctrlSetText 'Objects';
			_btnMisc ctrlEnable _others;
			_btnMisc ctrlShow _others;
			_btnMisc buttonSetAction '
				LASTSUBBUTTON = 2;FILLMAINSTATE=1;[] call fnc_fill_CQC_MAIN;[] call fnc_setFocus;[] call fnc_colorButtons;
			';
			
			call fnc_searchNfill;
		};
		fnc_cloneGear = {
			_unit = _this;
			if(isNil'_unit')exitWith{'_unit not defined' call FN_SHOW_LOG;};
			if(isNull _unit)exitWith{'_unit OBJECT-NULL' call FN_SHOW_LOG;};
			_export = '';
			_fnc_addMultiple = {
				_items = _this select 0;
				_expression = _this select 1;
				_itemsUsed = [];
				{
					_item = _x;
					_itemLower = tolower _x;
					if !(_itemLower in _itemsUsed)then{
						_itemsUsed set [count _itemsUsed,_itemLower];
						_itemCount = {_item == _x} count _items;
						_expressionLocal = _expression;
						if(_itemCount > 1)then{
							_expressionLocal = format ['for ''_i'' from 1 to %1 do {%2};',_itemCount,_expression];
						};
						_export = _export + format [_expressionLocal,_var,_x];
					};
				} foreach _items;
			};
			_export = _export + '_unit = player;';
			_var = '_unit';
			_export = _export + format ['removeAllWeapons %1;',_var];
			_export = _export + format ['removeAllItems %1;',_var];
			_export = _export + format ['removeAllAssignedItems %1;',_var];
			_export = _export + format ['removeUniform %1;',_var];
			_export = _export + format ['removeVest %1;',_var];
			_export = _export + format ['removeBackpack %1;',_var];
			_export = _export + format ['removeHeadgear %1;',_var];
			_export = _export + format ['removeGoggles %1;',_var];
			if(uniform _unit != '')then{
				_export = _export + format ['%1 forceAddUniform ''%2'';',_var,uniform _unit];
				[uniformitems _unit,'%1 addItemToUniform ''%2'';'] call _fnc_addMultiple;
			};
			if(vest _unit != '')then{
				_export = _export + format ['%1 addVest ''%2'';',_var,vest _unit];
				[vestitems _unit,'%1 addItemToVest ''%2'';'] call _fnc_addMultiple;
			};
			if(!isnull unitbackpack _unit)then{
				_export = _export + format ['%1 addBackpack ''%2'';',_var,typeof unitbackpack _unit];
				[backpackitems _unit,'%1 addItemToBackpack ''%2'';'] call _fnc_addMultiple;
			};
			if(headgear _unit != '')then{_export = _export + format ['%1 addHeadgear ''%2'';',_var,headgear _unit];};
			if(goggles _unit != '')then{_export = _export + format ['%1 addGoggles ''%2'';',_var,goggles _unit];};
			{
				_weapon = _x select 0;
				_weaponAccessories = _x select 1;
				_weaponCommand = _x select 2;
				if(_weapon != '')then{
					_export = _export + format ['%1 addWeapon ''%2'';',_var,_weapon];
					{
						if(_x != '')then{_export = _export + format ['%1 %3 ''%2'';',_var,_x,_weaponCommand];};
					} foreach _weaponAccessories;
				};
			} foreach [
				[primaryweapon _unit,_unit weaponaccessories primaryweapon _unit,'addPrimaryWeaponItem'],
				[secondaryweapon _unit,_unit weaponaccessories secondaryweapon _unit,'addSecondaryWeaponItem'],
				[handgunweapon _unit,_unit weaponaccessories handgunweapon _unit,'addHandgunItem'],
				[binocular _unit,[],'']
			];
			[assigneditems _unit - [binocular _unit],'%1 linkItem ''%2'';'] call _fnc_addMultiple;
			_export
		};
		fnc_Loadoutmenu = {
			if(isNil'missionNameSpaceLoadouts')then{missionNameSpaceLoadouts=[];};
			
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 44464);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['CQC_RSC_IGUIBack', 44464];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44464) ctrlSetPosition [
				0.554062 * safezoneW + safezoneX,
				1,
				0.3,
				0.2 * safezoneH
			];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44464) ctrlSetBackgroundColor [0.15,0.15,0.15,1];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44464) ctrlCommit 0;
			
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 44465);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['RscListbox', 44465];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44465) ctrlSetPosition [
				0.554062 * safezoneW + safezoneX,
				1
			];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44465) ctrlCommit 0;
			fnc_load_LoadOuts = {
				CQC_LoadOutARRay = profileNamespace getVariable['CQC_LoadOutARRay',[]];
				lbClear (findDisplay MAIN_DISPLAY_ID displayCtrl 44465);
				if!(CQC_LoadOutARRay isEqualTo [])then
				{
					{(findDisplay MAIN_DISPLAY_ID displayCtrl 44465) lbAdd _x;} forEach CQC_LoadOutARRay;
					(findDisplay MAIN_DISPLAY_ID displayCtrl 44465) lbAdd '';
				};
				if!(missionNameSpaceLoadouts isEqualTo [])then
				{
					{(findDisplay MAIN_DISPLAY_ID displayCtrl 44465) lbAdd _x;} forEach missionNameSpaceLoadouts;
					(findDisplay MAIN_DISPLAY_ID displayCtrl 44465) lbAdd '';
				};
				if(!isNil'CQC_Loadouts')then
				{
					{(findDisplay MAIN_DISPLAY_ID displayCtrl 44465) lbAdd _x;} forEach CQC_Loadouts;
				};
			};
			call fnc_load_LoadOuts;
			
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 44469);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['RscEdit', 44469];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44469) ctrlSetPosition [
				0.554062 * safezoneW + safezoneX,
				1.01+(ctrlPosition((findDisplay MAIN_DISPLAY_ID) displayCtrl 44465) select 3),
				(ctrlPosition((findDisplay MAIN_DISPLAY_ID) displayCtrl 44465) select 2),
				0.033 * safezoneH
			];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44469) ctrlCommit 0;
			
			
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 44466);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['RSCButton', 44466];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44466) ctrlSetText 'LOAD';
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44466) ctrlSetPosition [
				0.68 * safezoneW + safezoneX,
				1,
				0.3,
				0.033 * safezoneH
			];
			fnc_ButtonClick_44466 = {
				_txt = lbtext[44465,(lbCurSel 44465)];
				if(_txt != '')then
				{
					_exit = false;
					{if(toUpper _txt isEqualTo toUpper _x)exitWith{_exit=true};} forEach CQC_Loadouts;
					if(_exit)exitWith
					{
						switch (_txt) do {
							case 'Sub Machinegun Kit':{[2] call fnc_add_loadout;};
							case 'Light Infantry Kit':{[3] call fnc_add_loadout;};
							case 'Heavy Infantry Kit':{[4] call fnc_add_loadout;};
							case 'DMR Sniper Kit':{[5] call fnc_add_loadout;};
							case 'LLR Sniper Kit':{[6] call fnc_add_loadout;};
							case 'Lynx Sniper Kit':{[7] call fnc_add_loadout;};
							case 'M107 Sniper Kit':{[8] call fnc_add_loadout;};
						};
					};
					
					if(_txt in missionNameSpaceLoadouts)exitWith
					{
						_m = missionNameSpace getVariable _txt;
						if((!isNil '_m')&&{(typeName _m == 'CODE')})then
						{
							call _m;
						};
					};
					
					if(isNil'FNC_CUSTOM_fn_loadInventory')then
					{
						FNC_CUSTOM_fn_loadInventory = compile (preprocessfile 'A3\functions_f\Inventory\fn_loadInventory.sqf');
					};
					_fnc_scriptName='';[player, [profileNamespace, _txt]] call FNC_CUSTOM_fn_loadInventory;
				};
			};
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44466) ctrlCommit 0;
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44466) ctrlSetEventHandler['ButtonClick','call fnc_ButtonClick_44466'];
			
			
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 44467);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['RSCButton', 44467];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44467) ctrlSetText 'DELETE';
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44467) ctrlSetPosition [
				0.68 * safezoneW + safezoneX,
				1+((ctrlPosition((findDisplay MAIN_DISPLAY_ID) displayCtrl 44465) select 3)/2),
				0.3,
				0.033 * safezoneH
			];
			fnc_ButtonClick_44467 = {
				_txt = lbtext[44465,(lbCurSel 44465)];
				if(_txt != '')then
				{
					if(_txt in CQC_LoadOutARRay)then
					{
						_id = CQC_LoadOutARRay find _txt;
						if(_id == -1)exitWith{'can not find Loadout' call FN_SHOW_LOG;};
						_return = CQC_LoadOutARRay deleteAt _id;
						format['Deleted Loadout: %1',_return] call FN_SHOW_LOG;
						profileNamespace setVariable['CQC_LoadOutARRay',CQC_LoadOutARRay];saveprofileNamespace;
						_fnc_scriptName='';[player, [profileNamespace, _txt]] call BIS_fnc_deleteInventory;
					}
					else
					{
						_exit = false;
						{if(toUpper _txt isEqualTo toUpper _x)exitWith{_exit=true};} forEach CQC_Loadouts;
						if(_exit)exitWith{'can not delete preset Admin Loadouts' call FN_SHOW_LOG;};
						
						_id = missionNameSpaceLoadouts find _txt;
						if(_id == -1)exitWith{'can not find Loadout' call FN_SHOW_LOG;};
						_return = missionNameSpaceLoadouts deleteAt _id;
						format['Deleted Loadout: %1',_return] call FN_SHOW_LOG;
					};
				};
				call fnc_load_LoadOuts;
			};
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44467) ctrlCommit 0;
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44467) ctrlSetEventHandler['ButtonClick','call fnc_ButtonClick_44467'];
			
			
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 44468);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['RSCButton', 44468];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44468) ctrlSetPosition [
				0.68 * safezoneW + safezoneX,
				1+(ctrlPosition((findDisplay MAIN_DISPLAY_ID) displayCtrl 44465) select 3),
				0.3,
				0.033 * safezoneH
			];
			fnc_ButtonClick_44468 = {
				_txt = ctrlText 44469;
				if(_txt == '')exitWith{'Type a Loadout name to save!' call FN_SHOW_LOG;};
				if(count _txt > 30)exitWith{'Loadout name should have max 30 characters!' call FN_SHOW_LOG;};
				if(isNull SELECTED_TARGET_PLAYER)exitWith{'Player selected is NULL-OBJECT' call FN_SHOW_LOG;};
				_exit = false;
				{if(toUpper _txt isEqualTo toUpper _x)exitWith{_exit=true};} forEach CQC_Loadouts;
				if(_exit)exitWith{'can not overwrite preset Admin Loadouts' call FN_SHOW_LOG;};
				
				_exit = false;
				{if(toUpper _txt isEqualTo toUpper _x)exitWith{_exit=true};} forEach missionNameSpaceLoadouts;
				if(_exit)exitWith{'can not overwrite missionNameSpaceLoadouts Admin Loadouts' call FN_SHOW_LOG;};
				
				if!(_txt in CQC_LoadOutARRay)then
				{
					CQC_LoadOutARRay pushBack _txt;
					profileNamespace setVariable['CQC_LoadOutARRay',CQC_LoadOutARRay];saveprofileNamespace;
				};
				_fnc_scriptName='';[SELECTED_TARGET_PLAYER, [profileNamespace, _txt]] call BIS_fnc_saveInventory;
				call fnc_load_LoadOuts;
			};
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44468) ctrlSetEventHandler['ButtonClick','call fnc_ButtonClick_44468'];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44468) ctrlSetText 'SAVE FROM SELECTED';
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44468) ctrlCommit 0;
			
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 44470);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['RSCButton', 44470];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44470) ctrlSetText 'EXPORT';
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44470) ctrlSetPosition [
				0.81 * safezoneW + safezoneX,
				1+(ctrlPosition((findDisplay MAIN_DISPLAY_ID) displayCtrl 44465) select 3),
				0.3,
				0.033 * safezoneH
			];
			fnc_ButtonClick_44470 = {
				_txt = lbtext[44465,(lbCurSel 44465)];
				if(_txt != '')then
				{
					if(_txt in CQC_LoadOutARRay)then
					{
						_id = CQC_LoadOutARRay find _txt;
						if(_id == -1)exitWith{('can not find Loadout: '+_txt) call FN_SHOW_LOG;};
						
						if(isNil'FNC_CUSTOM_fn_exportInventory')then
						{
							_script = preprocessfile 'A3\functions_f_bootcamp\Inventory\fn_exportInventory.sqf';
							if(typeName _script != 'STRING')then
							{
								_script = str _script;
							};
							FNC_CUSTOM_fn_exportInventory = compile _script;
						};
						_fnc_scriptName='';_loadout = [player, [profileNamespace, _txt]] call FNC_CUSTOM_fn_exportInventory; 
						['SYSTEMLOG',_loadout] call CQC_fnc_ahLog; 
						('Loadout: '+_txt+' saved to client RPT file!') call FN_SHOW_LOG;
					}
					else
					{
						'Only Loadouts saved with this tool can be exported!' call FN_SHOW_LOG;
					};
				};
				call fnc_load_LoadOuts;
			};
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44470) ctrlCommit 0;
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44470) ctrlSetEventHandler['ButtonClick','call fnc_ButtonClick_44470'];
			
			
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 44471);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['RSCButton', 44471];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44471) ctrlSetPosition [
				0.81 * safezoneW + safezoneX,
				1+((ctrlPosition((findDisplay MAIN_DISPLAY_ID) displayCtrl 44465) select 3)/2),
				0.3,
				0.033 * safezoneH
			];
			fnc_ButtonClick_44471 = {
				_export = player call fnc_cloneGear;
				[_export,SELECTED_TARGET_PLAYER] call admin_d0_target;
				
				_log = format['Cloned on %1(%2)!',name SELECTED_TARGET_PLAYER,getPlayerUID SELECTED_TARGET_PLAYER];
				_log call FN_SHOW_LOG;
			};
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44471) ctrlSetEventHandler['ButtonClick','call fnc_ButtonClick_44471'];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44471) ctrlSetText 'CLONE ON SELECTED';
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44471) ctrlCommit 0;
			
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 44472);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['RSCButton', 44472];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44472) ctrlSetPosition [
				0.81 * safezoneW + safezoneX,
				1,
				0.3,
				0.033 * safezoneH
			];
			fnc_ButtonClick_44472 = {
				_export = SELECTED_TARGET_PLAYER call fnc_cloneGear;
				call compile _export;
				
				_log = format['Cloned %1(%2) on yourself!',name SELECTED_TARGET_PLAYER,getPlayerUID SELECTED_TARGET_PLAYER];
				_log call FN_SHOW_LOG;
			};
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44472) ctrlSetEventHandler['ButtonClick','call fnc_ButtonClick_44472'];
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44472) ctrlSetText 'CLONE FROM SELECTED';
			(findDisplay MAIN_DISPLAY_ID displayCtrl 44472) ctrlCommit 0;
			
			_ctrl = [(findDisplay MAIN_DISPLAY_ID),'RSCText',44463] call fnc_createctrl;
			_ctrl ctrlSetPosition [
				0.677 * safezoneW + safezoneX,
				0.75,
				0.2 * safezoneW,
				0.03 * safezoneH
			];
			_ctrl ctrlSetText 'SELECTED TARGET: <NULL-object>';
			_ctrl ctrlCommit 0;
		};
		fnc_WeatherLord = {
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 33300);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['RSCText', 33300];
			_text1 = (findDisplay MAIN_DISPLAY_ID displayCtrl 33300);
			_text1 ctrlSetPosition [
				0.55 * safezoneW + safezoneX,
				0.5,
				0.2 * safezoneW,
				0.03 * safezoneH
			];
			_text1 ctrlSetText 'Fog:';
			_text1 ctrlCommit 0;
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 33301);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['RscXSliderH', 33301];
			_slider1 = (findDisplay MAIN_DISPLAY_ID displayCtrl 33301);
			_slider1 ctrlSetPosition [
				0.554 * safezoneW + safezoneX,
				0.55
			];
			_slider1 ctrlSetBackgroundColor [0.15,0.15,0.15,1];
			slider_fog_changed = {
				SET_FOG_VALUE = (_this select 1)/10;
				0 setFog SET_FOG_VALUE;
			};
			_slider1 ctrlRemoveAllEventHandlers 'SliderPosChanged';
			_slider1 ctrlAddEventHandler ['SliderPosChanged','call slider_fog_changed'];
			_slider1 ctrlCommit 0;
			
			
			
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 33302);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['RSCText', 33302];
			_text2 = (findDisplay MAIN_DISPLAY_ID displayCtrl 33302);
			_text2 ctrlSetPosition [
				0.55 * safezoneW + safezoneX,
				0.6,
				0.2 * safezoneW,
				0.03 * safezoneH
			];
			_text2 ctrlSetText 'Overcast:';
			_text2 ctrlCommit 0;
			
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 33303);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['RscXSliderH', 33303];
			_slider2 = (findDisplay MAIN_DISPLAY_ID displayCtrl 33303);
			_slider2 ctrlSetPosition [
				0.554 * safezoneW + safezoneX,
				0.65
			];
			_slider2 ctrlSetBackgroundColor [0.15,0.15,0.15,1];
			slider_overcast_changed = {
				SET_OVERCAST_VALUE = (_this select 1)/10;
				0 setOvercast SET_OVERCAST_VALUE;
				simulWeatherSync;
			};
			_slider2 ctrlRemoveAllEventHandlers 'SliderPosChanged';
			_slider2 ctrlAddEventHandler ['SliderPosChanged','call slider_overcast_changed'];
			_slider2 ctrlCommit 0;
			
			
			
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 33304);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['RSCText', 33304];
			_text3 = (findDisplay MAIN_DISPLAY_ID displayCtrl 33304);
			_text3 ctrlSetPosition [
				0.55 * safezoneW + safezoneX,
				0.7,
				0.2 * safezoneW,
				0.03 * safezoneH
			];
			_text3 ctrlSetText 'Rain:';
			_text3 ctrlCommit 0;
			
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 33305);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['RscXSliderH', 33305];
			_slider3 = (findDisplay MAIN_DISPLAY_ID displayCtrl 33305);
			_slider3 ctrlSetPosition [
				0.554 * safezoneW + safezoneX,
				0.75
			];
			_slider3 ctrlSetBackgroundColor [0.15,0.15,0.15,1];
			slider_rain_changed = {
				SET_RAIN_VALUE = (_this select 1)/10;
				if(SET_RAIN_VALUE > 0.3)then{if(overcast < 0.75)then{SET_OVERCAST_VALUE = 0.75;};};
				0 setRain SET_RAIN_VALUE;
				simulWeatherSync;
			};
			_slider3 ctrlRemoveAllEventHandlers 'SliderPosChanged';
			_slider3 ctrlAddEventHandler ['SliderPosChanged','call slider_rain_changed'];
			_slider3 ctrlCommit 0;
			
			
			ctrlDelete ((findDisplay MAIN_DISPLAY_ID) displayCtrl 33400);
			findDisplay MAIN_DISPLAY_ID ctrlCreate['RSCButton', 33400];
			_btn1 = (findDisplay MAIN_DISPLAY_ID displayCtrl 33400);
			_btn1 ctrlSetText 'CHANGE GLOBAL';
			_btn1 ctrlSetPosition [
				0.554 * safezoneW + safezoneX,
				0.8,
				0.3,
				0.033 * safezoneH
			];
			_btn1 ctrlCommit 0;
			_btn1 ctrlSetEventHandler['ButtonClick','[16,player,SET_FOG_VALUE,SET_OVERCAST_VALUE,SET_RAIN_VALUE] call fnc_AdminReq;'];
			
			SET_FOG_VALUE = fog;
			SET_OVERCAST_VALUE = overcast;
			SET_RAIN_VALUE = rain;
			if(!isNil'fnc_WeatherLordTHREAD')then{terminate fnc_WeatherLordTHREAD;};
			fnc_WeatherLordTHREAD = [] spawn {
				disableSerialization;
				_slider1 = (findDisplay MAIN_DISPLAY_ID displayCtrl 33301);
				_slider2 = (findDisplay MAIN_DISPLAY_ID displayCtrl 33303);
				_slider3 = (findDisplay MAIN_DISPLAY_ID displayCtrl 33305);
				if(isNil'SET_FOG_VALUE')then{SET_FOG_VALUE=fog};
				if(isNil'SET_OVERCAST_VALUE')then{SET_OVERCAST_VALUE=overcast};
				if(isNil'SET_RAIN_VALUE')then{SET_RAIN_VALUE=rain};
				while {!isNull findDisplay MAIN_DISPLAY_ID} do
				{
					_fog = SET_FOG_VALUE;
					if(_fog > 0)then{_fog=_fog*10;};
					_slider1 sliderSetPosition _fog;
					0 setFog SET_FOG_VALUE;
					
					_overcast = SET_OVERCAST_VALUE;
					if(_overcast > 0)then{_overcast=_overcast*10;};
					_slider2 sliderSetPosition _overcast;
					0 setOvercast SET_OVERCAST_VALUE;
					
					_rain = SET_RAIN_VALUE;
					if(_rain > 0)then{_rain=_rain*10;};
					_slider3 sliderSetPosition _rain;
					0 setRain SET_RAIN_VALUE;
					
					uiSleep 0.1;
				};
			};
		}; 
		fn_CQC_addSaveButton = {
			_display = findDisplay MAIN_DISPLAY_ID;
			
			_btn = [_display,'RscButton',1338001] call fnc_createctrl;
			_btn ctrlSetText 'SAVE TOGGLE STATE';
			_btn ctrlSetPosition [
				0.39 * safezoneW + safezoneX + (0.15 * safezoneW),
				0.0379694 * safezoneH + safezoneY,
				0.12 * safezoneW,
				0.02 * safezoneH
			];
			_btn buttonSetAction '
				profileNamespace setVariable [''CQC_saveToggle_A3'',CQC_toggled_A];
				saveprofileNamespace;
				_log = ''Saved currently toggled/enabled admin functions. Next time you login as admin, they will automatically turn on.'';
				_log call FN_SHOW_LOG;
				systemChat (''<CQC AntiHack> ''+_log);
			';
			_btn ctrlCommit 0;
		};
		fnc_FULLinit = {
			disableSerialization;
			if(isNull findDisplay MAIN_DISPLAY_ID)then
			{
				createdialog 'CQC_Rsc_DisplayAdminTools';
				call fn_CQC_addSaveButton; 
			};
			call fnc_initMenu;
			[] call fnc_add_adminMainMapMovement;
			if('==== Loadouts ====' call "+_adminsUIDAccses+")then{call fnc_Loadoutmenu;};
			if('==== WeatherLord ====' call "+_adminsUIDAccses+")then{call fnc_WeatherLord;};
		};
		fnc_btn_html = { 
			[] call fnc_colorButtons;
		};
		fnc_initMenu = {
			_display = findDisplay MAIN_DISPLAY_ID;
			
			_ctrlL = _display displayCtrl LEFT_CTRL_ID;
			_ctrlL ctrlRemoveAllEventHandlers 'LBDblClick';
			_ctrlL ctrlRemoveAllEventHandlers 'LBSelChanged';		
			_ctrlL ctrlAddEventHandler ['LBDblClick', 'call fnc_LBDblClick_LEFT;[] call fnc_setFocus;'];
			_ctrlL ctrlAddEventHandler ['LBSelChanged', 'call fnc_LBSelChanged_LEFT;[] call fnc_setFocus;'];
			[] call fnc_fill_CQC_Player;
			
			_ctrlR = _display displayCtrl RIGHT_CTRL_ID;
			_ctrlR ctrlRemoveAllEventHandlers 'LBDblClick';
			_ctrlR ctrlRemoveAllEventHandlers 'LBSelChanged';
			_ctrlR ctrlAddEventHandler ['LBDblClick', 'call fnc_LBDblClick_RIGHT;[] call fnc_setFocus;'];
			_ctrlR ctrlAddEventHandler ['LBSelChanged', 'call fnc_LBSelChanged_RIGHT;[] call fnc_setFocus;'];
			FILLMAINSTATE=0;[] call fnc_fill_CQC_MAIN;
			
			_ctrl = _display displayCtrl 2;
			
			private _spacing = [];
			_spacing resize 80;
			_spacing = toString (_spacing apply {32});

			private _time = ((call CQC_fnc_serverUpTime) splitString '| ' joinString ' ');
		 
			_ctrl ctrlSetText format[
				(' Connected Players: %1' + _spacing + 'CQC AdminTools' + _spacing + 'SERVER UPTIME: %2 '),
				count allPlayers,
				_time
			];
			
			_btnMainMenu = _display displayCtrl 20;
			_btnMainMenu buttonSetAction 'FILLMAINSTATE=0;[] call fnc_fill_CQC_MAIN;[] call fnc_setFocus;[] call fnc_colorButtons;';
			
			_btnAntiSpawnMenu = _display displayCtrl 21;
			_btnAntiSpawnMenu buttonSetAction 'FILLMAINSTATE=1;[] call fnc_fill_CQC_MAIN;[] call fnc_setFocus;[] call fnc_colorButtons;';
			
			_btnSMap = _display displayCtrl 32;
			_btnSMap ctrlEnable false;
			_btnSMap ctrlShow false;
			
			_btnCMap = _display displayCtrl 33;
			_btnCMap ctrlEnable false;
			_btnCMap ctrlShow false;
			
			_btnTMap = _display displayCtrl 34;
			_btnTMap ctrlEnable false;
			_btnTMap ctrlShow false;
			
			_btnMapPip = _display displayCtrl 35;
			_btnMapPip ctrlEnable false;
			_btnMapPip ctrlShow false;
			
			call fnc_SearchFieldButtons;
			[] call fnc_setFocus;
			[] call fnc_colorButtons;
		};
		fnc_colorizeMain = {
			disableSerialization;
			_ctrl = (findDisplay MAIN_DISPLAY_ID) displayCtrl RIGHT_CTRL_ID;
			_lsize = lbSize RIGHT_CTRL_ID;
			for '_i' from 0 to _lsize do
			{
				_lbtxt = lbtext [RIGHT_CTRL_ID,_i];
				if(_lbtxt in CQC_Toggleable)then
				{
					if(_lbtxt in CQC_toggled_A)then
					{
						_ctrl lbSetColor [_i,[0,1,0,1]];
					}
					else
					{
						_ctrl lbSetColor [_i,[1,0,0,1]];
					};
				};
				if(_lbtxt in CQC_SubMenus)then
				{
					_ctrl lbSetColor [_i,[0.67,0.97,0.97,1]];
				};
				if(_lbtxt in CQC_OnTargetNICE)then
				{
					_ctrl lbSetColor [_i,[0,0.8,1,1]];
				};
				if(_lbtxt in CQC_OnTargetEVIL)then
				{
					_ctrl lbSetColor [_i,[0.99,0.8,0.8,1]];
				};
			};
		};
		fnc_colorButtons = {
			call fnc_SearchFieldButtons;
			disableSerialization;
			_display = findDisplay MAIN_DISPLAY_ID;
			_btnMainMenu = _display displayCtrl 20;
			if(FILLMAINSTATE == 0)then{_btnMainMenu ctrlSetTextColor [0,1,0,1];} else {_btnMainMenu ctrlSetTextColor [1,1,1,1];};
			_btnAntiSpawnMenu = _display displayCtrl 21;
			if(FILLMAINSTATE == 1)then{_btnAntiSpawnMenu ctrlSetTextColor [0,1,0,1];} else {_btnAntiSpawnMenu ctrlSetTextColor [1,1,1,1];};
			
			_btnAntiHackLog = _display displayCtrl 23;
			_btnAntiHackLog ctrlSetText (format['AHLogs: %1',count AH_HackLogArray + count AH_SurvLogArray + count PVAH_AHTMPBAN]);
			_btnAntiHackLog buttonSetAction 'FILLMAINSTATE=3;[] call fnc_fill_HackLog;[] call fnc_setFocus;[] call fnc_colorButtons;';
			if(FILLMAINSTATE isEqualTo 3)then{_btnAntiHackLog ctrlSetTextColor [0,1,0,1];} else {_btnAntiHackLog ctrlSetTextColor [1,1,1,1];};
			
			_btnAdminLog = _display displayCtrl 24;
			_btnAdminLog ctrlSetText (format['AdminLogs: %1',count AH_AdmiLogArray]);
			_btnAdminLog buttonSetAction 'FILLMAINSTATE=4;[] call fnc_fill_AdminLog;[] call fnc_setFocus;[] call fnc_colorButtons;';
			if(FILLMAINSTATE isEqualTo 4)then{_btnAdminLog ctrlSetTextColor [0,1,0,1];} else {_btnAdminLog ctrlSetTextColor [1,1,1,1];};
			
			_btnItems = _display displayCtrl 36;
			if((LASTSUBBUTTON == 0)&&(FILLMAINSTATE == 1))then{_btnItems ctrlSetTextColor [0,1,0,1];} else {_btnItems ctrlSetTextColor [1,1,1,1];};
			_btnVehs = _display displayCtrl 37;
			if(LASTSUBBUTTON == 1)then{_btnVehs ctrlSetTextColor [0,1,0,1];} else {_btnVehs ctrlSetTextColor [1,1,1,1];};
			_btnMisc = _display displayCtrl 38;
			if(LASTSUBBUTTON == 2)then{_btnMisc ctrlSetTextColor [0,1,0,1];} else {_btnMisc ctrlSetTextColor [1,1,1,1];};
			
			_mytime = 0.3;
			_ctrlR = _display displayCtrl RIGHT_CTRL_ID;
			if(isNil 'ctrlposR')then{ctrlposR = ctrlPosition _ctrlR;};
			
			_ctrlRTMP = [(ctrlposR select 0),(ctrlposR select 1),(ctrlposR select 2)*2.35,(ctrlposR select 3)];
			if(FILLMAINSTATE == 0)then
			{
				_ctrlRTMP = ctrlposR;
			};
			if(FILLMAINSTATE == 1)then
			{
				_ctrlRTMP = [(ctrlposR select 0),(ctrlposR select 1)+.25,(ctrlposR select 2),(ctrlposR select 3)-.25];
			};
			_ctrlR ctrlSetPosition _ctrlRTMP;
			_ctrlR ctrlCommit _mytime;
			
			_btnHTML = _display displayCtrl 25;
			_btnHTML ctrlSetTextColor [0,1,0,1];
			_btnHTML ctrlSetText 'FRAGSQUAD';
			(uiNamespace getVariable 'RscHTML_CQC_Admin') ctrlEnable false;
			(uiNamespace getVariable 'RscHTML_CQC_Admin') ctrlShow true;
		};
		fnc_fill_HackLog = {
			disableSerialization;
			_ctrl = (findDisplay MAIN_DISPLAY_ID) displayCtrl RIGHT_CTRL_ID;
			lbclear _ctrl;
			_ctrl lbAdd 'clear ingame HackLog';
			_ctrl lbAdd 'DBL-CLICK TO SYSTEMCHAT';
			_ctrl lbAdd '--------------------';
			
			_ctrl lbAdd format['HackLog: %1',count AH_HackLogArray];
			{_ctrl lbAdd _x;} forEach AH_HackLogArray;
			
			_ctrl lbAdd '';
			_ctrl lbAdd format['SurveillanceLog: %1',count AH_SurvLogArray];
			{_ctrl lbAdd _x;} forEach AH_SurvLogArray;
			
			_ctrl lbAdd '';
			_ctrl lbAdd format['BanLog: %1',count PVAH_AHTMPBAN];
			if(str PVAH_AHTMPBAN != '[]')then
			{
				_ctrl lbAdd 'DBL-CLICK TO REMOVE';
				{_ctrl lbAdd _x;} forEach PVAH_AHTMPBAN;
			};
			for '_i' from 0 to 10 do {_ctrl lbAdd '';};
		};
		fnc_fill_AdminLog = {
			disableSerialization;
			_ctrl = (findDisplay MAIN_DISPLAY_ID) displayCtrl RIGHT_CTRL_ID;
			lbclear _ctrl;
			if('AdminLog' call "+_adminsUIDAccses+")then
			{
				_ctrl lbAdd 'clear ingame AdminLog';
				_ctrl lbAdd 'DBL-CLICK TO SYSTEMCHAT';
				{_ctrl lbAdd _x;} forEach AH_AdmiLogArray;
			}
			else
			{
				_ctrl lbAdd 'Nothin to see here';
			};
			for '_i' from 0 to 10 do {_ctrl lbAdd '';};
		};
		fnc_fill_CQC_MAIN = {
			disableSerialization;
			_ctrl = (findDisplay MAIN_DISPLAY_ID) displayCtrl RIGHT_CTRL_ID;
			lbclear _ctrl;
			CQC_SubMenus =
			[
				'==== Weapons ====','==== Magazines ====','==== Bags ====','==== Vehicles ====',
				'==== Objects ====','==== OnTarget ====','==== Toggleable ====',
				'==== VirtualItems ===='
			];
			CQC_OnTargetNICE =
			[
				'Teleport - Target To Me','Teleport - Me To Target',
				'Request Steam Name','Revive','Heal','Restore',
				'Move In My Vehicle','Move In Target Vehicle','Parachute Target',
				'UnFreeze Target'
			];
			 
			{
				CQC_OnTargetNICE = CQC_OnTargetNICE - [_x];
			} forEach ['Revive'];
		
			CQC_OnTargetEVIL =
			[
				'Restrain','Freeze Target','Remove Gear','Kill','Explode','MineField (around target)','Zeus','Delete Vehicle','Eject','Eject Crew',
				'Force Disconnect','Kick (Silent)','Kick (Announce)','Ban (Silent)','Ban (Announce)',
				'Spawn UAV','Spawn Cloak','Spawn Sapper','Spawn SapperB'
			];
			
			{
				CQC_OnTargetEVIL = CQC_OnTargetEVIL - [_x];
			} forEach ['Spawn UAV','Spawn Cloak','Spawn Sapper','Spawn SapperB'];
	
		
			{
				CQC_OnTargetEVIL = CQC_OnTargetEVIL - [_x];
			} forEach ['Restrain'];
		
			CQC_OnTarget = CQC_OnTargetNICE + CQC_OnTargetEVIL;
			CQC_Toggleable =
			[
				'CQC Player ESP 1','CQC Player ESP 2','CQC AI ESP','CQC Dead ESP',
				'CQC MapIcons','Vehicle Marker','DeadPlayer Marker','Stealth / Invisible',
				'God Mode','Vehicle God Mode','Vehboost','FastFire','UnlimAmmo','noRecoil','Lower Terrain',
				'Disable Announces','Teleport In Facing Direction (10m steps)'
			]; 

			CQC_Loadouts =
			[ 
				'Sub Machinegun Kit','Light Infantry Kit','Heavy Infantry Kit','DMR Sniper Kit','LLR Sniper Kit',
				'Lynx Sniper Kit','M107 Sniper Kit'
			];
			
		
			if(FILLMAINSTATE == 1)then
			{
				switch (LASTSUBBUTTON) do {
					case 0:{
						if('==== Weapons ====' call "+_adminsUIDAccses+")then
						{
							_ctrl lbAdd '==== Weapons ====';
							if(!isNil 'CQC_add_weapons')then
							{
						
								{
									_ctrl lbAdd format['%1 (%2)',getText(configFile >> 'CfgWeapons' >> _x >> 'displayName'),_x];
									_x call fnc_addpic;
									_ctrl lbSetData [(lbsize _ctrl)-1,_x];
								} forEach ALL_WEPS_TO_SEARCH_C; 
							};
						};
						if('==== Magazines ====' call "+_adminsUIDAccses+")then
						{
							_ctrl lbAdd '==== Magazines ====';
							if(!isNil 'CQC_add_magazines')then
							{ 
								{
									_ctrl lbAdd format['%1 (%2)',getText(configFile >> 'CfgMagazines' >> _x >> 'displayName'),_x];
									_x call fnc_addpic;
									_ctrl lbSetData [(lbsize _ctrl)-1,_x];
								} forEach ALL_MAGS_TO_SEARCH_C; 
							};
						};
						if('==== Bags ====' call "+_adminsUIDAccses+")then
						{
							_ctrl lbAdd '==== Bags ====';
							if(!isNil 'CQC_add_bags')then
							{ 
								{
									_ctrl lbAdd format['%1 (%2)',getText(configFile >> 'CfgVehicles' >> _x >> 'displayName'),_x];
									_x call fnc_addpic;
									_ctrl lbSetData [(lbsize _ctrl)-1,_x];
								} forEach ALL_BAGS_TO_SEARCH_C;
							};
						};
					};
					case 1:{
						if('==== Vehicles ====' call "+_adminsUIDAccses+")then
						{
							_ctrl lbAdd '==== Vehicles ====';
							if(!isNil 'CQC_add_vehicles')then
							{ 
								{
									_ctrl lbAdd format['%1 (%2)',getText(configFile >> 'CfgVehicles' >> _x >> 'displayName'),_x];
									_x call fnc_addpic;
									_ctrl lbSetData [(lbsize _ctrl)-1,_x];
								} forEach ALL_VEHS_TO_SEARCH_C;
							};
						};
					};
					case 2:{
						if('==== Objects ====' call "+_adminsUIDAccses+")then
						{
							_ctrl lbAdd '==== Objects ====';
							if(isNil 'CQC_add_objects')then
							{ 
								_ctrl lbAdd '   ==== Objects ====';
								{
									_ctrl lbAdd format['%1 (%2)',getText(configFile >> 'CfgVehicles' >> _x >> 'displayName'),_x];
									_ctrl lbSetData [(lbsize _ctrl)-1,_x];
								} forEach ALL_OBJS_TO_SEARCH_C;  
							};
						};
					};
				};
			};
			if(FILLMAINSTATE == 0)then
			{
				_onTarget = [];
				{if(_x call "+_adminsUIDAccses+")then{_onTarget pushBack _x;};} forEach CQC_OnTargetNICE;
				if!(_onTarget isEqualTo [])then{_onTarget pushBack '---';};
				{if(_x call "+_adminsUIDAccses+")then{_onTarget pushBack _x;};} forEach CQC_OnTargetEVIL;
				if!(_onTarget isEqualTo [])then
				{
					_ctrl lbAdd '==== OnTarget ====';
					if(isNil 'CQC_add_OnTarget')then
					{
						{_ctrl lbAdd _x;} forEach _onTarget;
					};
				};
				
				
				_Toggleable = [];
				{if(_x call "+_adminsUIDAccses+")then{_Toggleable pushBack _x;};} forEach CQC_Toggleable;
				if!(_Toggleable isEqualTo [])then
				{
					_ctrl lbAdd '==== Toggleable ====';
					if(isNil 'CQC_add_Toggleable')then
					{
						{_ctrl lbAdd _x;} forEach _Toggleable;
					};
				};

				if('BIS FreeRoam Cam (works with ESP)' call "+_adminsUIDAccses+")then{_ctrl lbAdd 'BIS FreeRoam Cam (works with ESP)'};
				if('FreeRoam Cam (does not work with ESP)' call "+_adminsUIDAccses+")then{_ctrl lbAdd 'FreeRoam Cam (does not work with ESP)'};
				if('AdminConsole' call "+_adminsUIDAccses+")then{_ctrl lbAdd 'AdminConsole';};
				if('Mass Message' call "+_adminsUIDAccses+")then{_ctrl lbAdd 'Mass Message';};
				if('Call EMP' call "+_adminsUIDAccses+")then{_ctrl lbAdd 'Call EMP'};
				if('DayTime' call "+_adminsUIDAccses+")then{_ctrl lbAdd 'DayTime';};
				if('NightTime' call "+_adminsUIDAccses+")then{_ctrl lbAdd 'NightTime';};
				if('Spawn Support-Box1' call "+_adminsUIDAccses+")then{_ctrl lbAdd 'Spawn Support-Box1';};
				if('Spawn Support-Box2' call "+_adminsUIDAccses+")then{_ctrl lbAdd 'Spawn Support-Box2';};
				if('Spawn Support-Box3' call "+_adminsUIDAccses+")then{_ctrl lbAdd 'Spawn Support-Box3';};
				if('Spawn Ammo' call "+_adminsUIDAccses+")then{_ctrl lbAdd 'Spawn Ammo';};
				_ctrl lbAdd 'Self Disconnect';
				_target = lbtext[LEFT_CTRL_ID,(lbCurSel LEFT_CTRL_ID)];
				if('ServerState' call "+_adminsUIDAccses+")then
				{ 
					if("+_serverLocked+")then{
						_ctrl lbAdd 'Server Unlock';
					}else{
						_ctrl lbAdd 'Server Lock';
					}; 
				};
				if('Login as Arma Admin' call "+_adminsUIDAccses+")then
				{
					if(isNil 'serverCommandLoginDone')then{_ctrl lbAdd 'Login';}; 
					if(serverCommandAvailable '#logout')then
					{
						_ctrl lbAdd format['#kick %1',_target];
						_ctrl lbAdd format['#exec ban %1',str _target];
					};
				};
			};
			[] call fnc_colorizeMain;
			for '_i' from 0 to 10 do {_ctrl lbAdd '';};
		};
		fnc_CQC_get_LeftClicks = {
			_array = allPlayers;
			_array append allDeadMen;
			_array
		};
		fnc_fill_CQC_Player = {
			disableSerialization;
			if(!isNil 'CQC_var_adminFillPlayerBox')exitWith{};
			CQC_var_adminFillPlayerBox = positionCameraToWorld [0,0,0];
			_ctrl = (findDisplay MAIN_DISPLAY_ID) displayCtrl LEFT_CTRL_ID;
			lbclear _ctrl;
			_unsorted = call fnc_CQC_get_LeftClicks;
			_sorted = _unsorted;
			lbclear _ctrl;
			if!(_sorted isEqualTo [])then
			{
				private _admins = missionNamespace getVariable ['CQCAdmins',[]];
				private _donators = missionNamespace getVariable ['CQCDonators',[]]; 
				private _developers = if(!isNil 'CQC_DEVS')then{CQC_DEVS}else{getArray(missionConfigFile >> 'enableDebugConsole')};

				private _fnc_addPlayerToList = {
					params [['_POBJX',objNull]];
					if(isNull _POBJX)exitWith{};
					_PUIDX = getPlayerUID _POBJX;
					if(_PUIDX == '')exitWith{};
					_name = _POBJX getVariable['playerName',name _POBJX];
					_side = side _POBJX; 
					 
					private _clr = _PUIDX call CQC_fnc_getPlayercolor;
					private _name = format['%1 [%2]',_name,_PUIDX call CQC_fnc_getPlayerRank]; 
					
					_index = _ctrl lbAdd _name;
					
					_veh = vehicle _POBJX;
					_xpic = getText (configFile >> 'CfgVehicles' >> (typeOf _veh) >> 'picture');
					if(alive _POBJX)then
					{
						if(_POBJX == _veh)then
						{
							_wpnstate = weaponState _POBJX;
							_cwep = _wpnstate select 0;
							if(_cwep != '')then
							{
								_xpic = getText (configFile >> 'CfgWeapons' >> _cwep >> 'picture');
							};
						};
					};
					if(_xpic isNotEqualTo '')then
					{
						_ctrl lbSetPictureRight [_index,_xpic];
						_ctrl lbSetPictureRightColor [_index,[1, 1, 1, 1]];
					};
				
					_ctrl lbSetColor [_index,_clr];
				};
				 
				if(!isNil'CQC_var_adminSortByName')exitWith {
					private _shown = [];
					private _abc = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

					for '_i' from 0 to ((count _abc) - 1) do 
					{
						private _char = _abc select [_i,1]; 

						{
							private _pobj = _x;
							private _puid = getPlayerUID _pobj;
							private _pchar = toUpper((name player) select [0,1]); 
							if !(_puid in _shown) then { 
								if(_pchar isEqualTo _char)then{ 
									_shown pushBackUnique _puid; 
									_shown pushBackUnique format['%1&&',_char];
									[_pobj] call _fnc_addPlayerToList;
								}; 	
							};
						} forEach _sorted;

						if !((format['%1&&',_char]) in _shown) then {
							_shown pushBackUnique format['%1&&',_char];
							_ctrl lbAdd _char;
						};
					};
					{
						private _pobj = _x;
						private _puid = getPlayerUID _pobj;
						private _pchar = toUpper((name player) select [0,1]); 
						if !(_puid in _shown) then {  
							if !((format['%1&&',_char]) in _shown) then {
								_shown pushBackUnique format['%1&&',_char];
								_ctrl lbAdd _char;
							};
							_shown pushBackUnique _puid;
							[_pobj] call _fnc_addPlayerToList;
						};
					} forEach _sorted;
				};

				if(!isNil'CQC_var_adminSortByRank')exitWith
				{
					_shown = [];
					_ctrl lbAdd '______Developers______';
					{ 
						private _pobj = _x;
						private _puid = getPlayerUID _pobj; 
						{
							private _uid = _x;
							if (_puid isEqualTo _uid AND !(_uid in _shown)) then {
								_shown pushBackUnique _uid;
								[_pobj] call _fnc_addPlayerToList;
							}; 
						} forEach _developers;
					} forEach _sorted;
					_ctrl lbAdd '______Admins______';
					{ 
						private _pobj = _x;
						private _puid = getPlayerUID _pobj; 
						{
							private _uid = _x;
							if (_puid isEqualTo _uid AND !(_uid in _shown)) then {
								_shown pushBackUnique _uid;
								[_pobj] call _fnc_addPlayerToList;
							}; 
						} forEach _admins;  
					} forEach _sorted;
					_ctrl lbAdd '______Donators______';
					{ 
						private _pobj = _x;
						private _puid = getPlayerUID _pobj; 
						{
							private _uid = _x;
							if (_puid isEqualTo _uid AND !(_uid in _shown)) then {
								_shown pushBackUnique _uid;
								[_pobj] call _fnc_addPlayerToList;
							}; 
						} forEach _donators;  
					} forEach _sorted;
					_ctrl lbAdd '______Players______';
					{ 
						private _pobj = _x;
						private _puid = getPlayerUID _pobj;   
						if !(_puid in _shown) then {
							_shown pushBackUnique _puid;
							[_pobj] call _fnc_addPlayerToList;
						}; 
					} forEach _sorted;
				};

				if(!isNil'CQC_var_adminSortByDistance')exitWith
				{
					private _shown = [];
					_sorted = [_unsorted,[],{CQC_var_adminFillPlayerBox distance _x},'ASCEND'] call BIS_fnc_sortBy;
					 
					{
						private _pobj = _x;
						private _puid = getPlayerUID _pobj;  
						if !(_puid in _shown) then {
							switch (true) do {
								case (CQC_var_adminFillPlayerBox distance _pobj >= 10000): 
								{ 
									_var = '10000 + Meters';
									if !(_var in _shown) then {
										_shown pushBackUnique _var;
										_ctrl lbAdd _var; 
									};
									_shown pushBackUnique _puid;
									[_pobj] call _fnc_addPlayerToList;
								};
								case (CQC_var_adminFillPlayerBox distance _pobj >= 7500): 
								{ 
									_var = '7500 - 10000 Meters'; 
									if !(_var in _shown) then {
										_shown pushBackUnique _var;
										_ctrl lbAdd _var;  
									};
									_shown pushBackUnique _puid;
									[_pobj] call _fnc_addPlayerToList;
								};
								case (CQC_var_adminFillPlayerBox distance _pobj >= 5000): 
								{ 
									_var = '5000 - 7500 Meters';
									if !(_var in _shown) then {
										_shown pushBackUnique _var;
										_ctrl lbAdd _var;  
									};
									_shown pushBackUnique _puid;
									[_pobj] call _fnc_addPlayerToList;
								};
								case (CQC_var_adminFillPlayerBox distance _pobj >= 2500): 
								{ 
									_var = '2500 - 5000 Meters';
									if !(_var in _shown) then {
										_shown pushBackUnique _var;
										_ctrl lbAdd _var;  
									};
									_shown pushBackUnique _puid;
									[_pobj] call _fnc_addPlayerToList;
								};
								case (CQC_var_adminFillPlayerBox distance _pobj >= 1000): 
								{ 
									_var = '1000 - 2500 Meters';
									if !(_var in _shown) then {
										_shown pushBackUnique _var;
										_ctrl lbAdd _var; 
									};
									_shown pushBackUnique _puid;
									[_pobj] call _fnc_addPlayerToList;
								};
								default 
								{ 
									_var = '0 - 1000 Meters'; 
									if !(_var in _shown) then {
										_shown pushBackUnique _var;
										_ctrl lbAdd _var; 
									};
									_shown pushBackUnique _puid;
									[_pobj] call _fnc_addPlayerToList;
								}; 
							}; 
						};
					} forEach _sorted;
				};
			};
			_display = findDisplay MAIN_DISPLAY_ID;
			_btnSortAlpha = _display displayCtrl 10;if(!isNil 'CQC_var_adminSortByName')then{lbSort _ctrl;_btnSortAlpha ctrlSetTextColor [0,1,0,1];} else {_btnSortAlpha ctrlSetTextColor [1,1,1,1];};
			_btnSortRanks = _display displayCtrl 11;if(!isNil 'CQC_var_adminSortByRank')then{_btnSortRanks ctrlSetTextColor [0,1,0,1];} else {_btnSortRanks ctrlSetTextColor [1,1,1,1];};
			_btnSortRange = _display displayCtrl 12;if(!isNil 'CQC_var_adminSortByDistance')then{_btnSortRange ctrlSetTextColor [0,1,0,1];} else {_btnSortRange ctrlSetTextColor [1,1,1,1];};
			for '_i' from 0 to 17 do {_ctrl lbAdd '';};
			CQC_var_adminFillPlayerBox = nil;
		};
		fnc_LBDblClick_LEFT = {
			_target = lbtext[LEFT_CTRL_ID,(lbCurSel LEFT_CTRL_ID)];
			SELECTED_DOUBLECLICK_TARGET = objNull;
			if(!isNil 'SELECTED_TARGET_PLAYER')then
			{
				if(!isNull SELECTED_TARGET_PLAYER)then
				{
					SELECTED_DOUBLECLICK_TARGET = SELECTED_TARGET_PLAYER;
				};
			};
			if(isNull SELECTED_DOUBLECLICK_TARGET)then
			{
				_break = false;
				{
					_puid = getPlayerUID _x;
					if(_puid != '')then
					{
						private _developers = if(!isNil 'CQC_DEVS')then{CQC_DEVS}else{getArray(missionConfigFile >> 'enableDebugConsole')};
						_search = switch (true) do {
							case (_puid in _developers): {format['%1 [Developer]',_name]};
							case (_puid in (missionNamespace getVariable ['CQCAdmins',[]])): {format['%1 [Admin]',name _x]};
							case (_puid in (missionNamespace getVariable ['CQCDonators',[]])): {format['%1 [VIP Player]',name _x]};
							default {format['%1 [Player]',name _x]};
						};
						if(_search == _target)then
						{
							_break = true;
							SELECTED_DOUBLECLICK_TARGET = _x;
						};
					};
					if(_break)exitWith{true};
				} forEach (call fnc_CQC_get_LeftClicks);
			};
			if('spectating' call "+_adminsUIDAccses+")then{SELECTED_TARGET_PLAYER call fnc_beginspectate;};
		};
		fnc_LBSelChanged_LEFT = {
			_target = lbtext[LEFT_CTRL_ID,(lbCurSel LEFT_CTRL_ID)];
			_break = false;
			_puid = '';
			SELECTED_TARGET_PLAYER = objNull;
			{
				_puid = getPlayerUID _x;
				if(_puid != '')then
				{
					private _developers = if(!isNil 'CQC_DEVS')then{CQC_DEVS}else{getArray(missionConfigFile >> 'enableDebugConsole')};
					_search = switch (true) do {
						case (_puid in _developers): {format['%1 [Developer]',_name]};
						case (_puid in (missionNamespace getVariable ['CQCAdmins',[]])): {format['%1 [Admin]',name _x]};
						case (_puid in (missionNamespace getVariable ['CQCDonators',[]])): {format['%1 [VIP Player]',name _x]};
						default {format['%1 [Player]',name _x]};
					};
					if(_search == _target)then
					{
						_break = true;
						SELECTED_TARGET_PLAYER = _x;
					};
				};
				if(_break)exitWith{true};
			} forEach (call fnc_CQC_get_LeftClicks);
			if(!isNull (findDisplay MAIN_DISPLAY_ID displayCtrl 44463))then
			{
				(findDisplay MAIN_DISPLAY_ID displayCtrl 44463) ctrlSetText format['SELECTED TARGET: %1',name SELECTED_TARGET_PLAYER];
			};
			if(visibleMap)then
			{
				(uiNamespace getVariable 'A3MAPICONS_mainMap') ctrlMapAnimAdd [1, 0.1, getPos SELECTED_TARGET_PLAYER];
				ctrlMapAnimCommit (uiNamespace getVariable 'A3MAPICONS_mainMap');
			};
			SELECTED_TARGET_PLAYER
		};
		fnc_toggleables = {
			switch (_this) do {
				case 'CQC Player ESP 1':{call CQC_fnc_infiESP_player1;};
				case 'CQC Player ESP 2':{call CQC_fnc_infiESP_player2;};
				case 'CQC AI ESP':{call CQC_fnc_infiESP_AI;};
				case 'CQC Dead ESP':{call CQC_fnc_infiESP_DEAD;};   
				case 'CQC MapIcons':{call CQC_A3MAPICONS;}; 
				case 'Vehicle Marker':{call adminVehicleMarker;};  
				case 'DeadPlayer Marker':{call adminDeadPlayer;};
				case 'God Mode':{call CQC_A3Invulnerability;};
				case 'Vehicle God Mode':{call fnc_CQC_A3cargod;};
				case 'Lower Terrain':{call fnc_LowerTerrain;};
				case 'Vehboost':{call CQC_VehicleBoost;};
				case 'UnlimAmmo':{[] spawn fnc_CQC_A3UnlAmmo;};
				case 'noRecoil':{[] spawn fnc_CQC_A3noRecoil;};
				case 'FastFire':{[] spawn fnc_CQC_A3FF;};
				case 'Stealth / Invisible':{call fnc_CQCHIDE;};
				case 'Disable Announces':{call fnc_DisableAnnouncements;};
				case 'Teleport In Facing Direction (10m steps)':{if(isNil'CQC_TpdirectionENABLED')then{CQC_TpdirectionENABLED=true}else{CQC_TpdirectionENABLED=nil;};};
			};
			if(_this in CQC_toggled_A)then
			{
				lbSetColor [RIGHT_CTRL_ID,1,[1,0,0,1]];
				CQC_toggled_A = CQC_toggled_A - [_this];
				_log = format['%1 - 0',_this];
				_log call fnc_adminLog;
			}
			else
			{
				lbSetColor [RIGHT_CTRL_ID,1,[0,1,0,1]];
				CQC_toggled_A pushBack _this;
				_log = format['%1 - 1',_this];
				_log call fnc_adminLog;
			};
		};
		fnc_LBDblClick_RIGHT = {
			_click = lbtext[RIGHT_CTRL_ID,(lbCurSel RIGHT_CTRL_ID)];
			if(!isNil'VIRTUAL_ITEMSTHREAD')then{terminate VIRTUAL_ITEMSTHREAD;VIRTUAL_ITEMSTHREAD=nil;};
			if(_click == '')exitWith{};
			if(_click in AH_HackLogArray)exitWith{_click call FN_SHOW_LOG;['SYSTEMLOG',_click] call CQC_fnc_ahLog;};
			if(_click in AH_SurvLogArray)exitWith{_click call FN_SHOW_LOG;['SYSTEMLOG',_click] call CQC_fnc_ahLog;};
			if(_click in AH_AdmiLogArray)exitWith{_click call FN_SHOW_LOG;['SYSTEMLOG',_click] call CQC_fnc_ahLog;};
			if(_click in PVAH_AHTMPBAN)exitWith{
				[-667,player,_click] call fnc_AdminReq;
				_log = format['Removed  %1  from TempBan Variable. Might still be banned in ban(s).txt',_click];
				_log call FN_SHOW_LOG;
				[] call fnc_fill_HackLog;[] call fnc_setFocus;
			};
			if(_click in CQC_Toggleable)then{_click call fnc_toggleables;};
			if(_click in CQC_OnTarget)then
			{
				_target = lbtext[LEFT_CTRL_ID,(lbCurSel LEFT_CTRL_ID)];
				_uid = '';
				if(_target == '')then
				{
					_log = 'You did not select a Target!';
					_log call FN_SHOW_LOG;
				}
				else
				{
					if(isNil 'SELECTED_TARGET_PLAYER')then{SELECTED_TARGET_PLAYER = objNull;};
					_unit = SELECTED_TARGET_PLAYER;
					if(isNull _unit)then
					{
						_unit = objNull;
						_break = false;
						{
							_uid = getPlayerUID _x;
							if(_uid != '')then
							{
								private _developers = if(!isNil 'CQC_DEVS')then{CQC_DEVS}else{getArray(missionConfigFile >> 'enableDebugConsole')};
								_search = switch (true) do {
									case (_uid in _developers): {format['%1 [Developer]',_name]};
									case (_uid in (missionNamespace getVariable ['CQCAdmins',[]])): {format['%1 [Admin]',name _x]};
									case (_uid in (missionNamespace getVariable ['CQCDonators',[]])): {format['%1 [VIP Player]',name _x]};
									default {format['%1 [Player]',name _x]};
								};
								if(_search == _target)then
								{
									_break = true;
									_unit = _x;
								};
							};
							if(_break)exitWith{true};
						} forEach (call fnc_CQC_get_LeftClicks);
					};
					if(!isNull _unit)then
					{
						if(_uid == '')then
						{
							_uid = getPlayerUID _unit;
						};
						switch (_click) do {
							case 'Teleport - Target To Me':{[_unit] call fnc_TP2ME;};
							case 'Teleport - Me To Target':{[_unit] call fnc_TPME2;};
							case 'Request Steam Name':{[_unit] call fnc_getSteamName;}; 
							case 'Revive':{[_unit] call fnc_ReviveTarget;};
							case 'Heal':{[_unit] call fnc_HealTarget;};
							case 'Restore':{[_unit] call fnc_RepairTarget;};
							case 'Move In My Vehicle':{[_unit] call fnc_MoveInMyVehicle;};
							case 'Move In Target Vehicle':{[_unit] call fnc_MoveInTargetVehicle;};
							case 'Parachute Target':{[_unit] call fnc_MoveInParachute;};
							case 'Freeze Target':{[_unit,true] call fnc_freezeTarget;};
							case 'UnFreeze Target':{[_unit,false] call fnc_freezeTarget;};
							case 'Remove Gear':{[_unit] call fnc_RemoveGear;};
							case 'Restrain':{[_unit,true] call fnc_restrainTarget;};
							case 'Unrestrain':{[_unit,false] call fnc_restrainTarget;};
							case 'Add / Remove Crypto':{call fnc_spawn_CryptoINSERTVALUE;};
							case 'Spawn UAV':{[_unit,'I_UAV_01_F'] call fnc_spawn_EVENT;}; 
							case 'Eject':{[_unit] call fnc_EjectTargetVeh;};
							case 'Eject Crew':{[_unit] call fnc_EjectCrewTargetVeh;};
							case 'Kill':{[_unit] call fnc_Kill_selected;};
							case 'Explode':{[_unit] call fnc_Explode_selected;};
							case 'MineField (around target)':{[_unit] call fnc_createMinefield;};
							case 'Zeus':{[_unit] call zeus_attack;};
							case 'Delete Vehicle':{[_unit] call fnc_deleteVeh_selected;};
							case 'Force Disconnect':{[_unit] call fnc_Disconnect_selected;};
							case 'Kick (Silent)':{[_unit,0] call fnc_Kick_selected;};
							case 'Kick (Announce)':{[_unit,1] call fnc_Kick_selected;};
							case 'Ban (Silent)':{[_unit,0] call fnc_Ban_selected;};
							case 'Ban (Announce)':{[_unit,1] call fnc_Ban_selected;};
						};
						_log = format['%1 - %2(%3)',_click,_target,_uid];_log call fnc_adminLog;
					};
				};
			};
			switch (_click) do {
				case '==== OnTarget ====':{if(isNil 'CQC_add_OnTarget')then{CQC_add_OnTarget = true;} else {CQC_add_OnTarget = nil;};};
				case '==== Toggleable ====':{if(isNil 'CQC_add_Toggleable')then{CQC_add_Toggleable = true;} else {CQC_add_Toggleable = nil;};};
				case '==== Weapons ====':{if(isNil 'CQC_add_weapons')then{CQC_add_weapons = true;} else {CQC_add_weapons = nil;};};
				case '==== Magazines ====':{if(isNil 'CQC_add_magazines')then{CQC_add_magazines = true;} else {CQC_add_magazines = nil;};};
				case '==== Bags ====':{if(isNil 'CQC_add_bags')then{CQC_add_bags = true;} else {CQC_add_bags = nil;};};
				case '==== Vehicles ====':{if(isNil 'CQC_add_vehicles')then{CQC_add_vehicles = true;} else {CQC_add_vehicles = nil;};};
				case '==== Objects ====':{if(isNil 'CQC_add_objects')then{CQC_add_objects = true;} else {CQC_add_objects = nil;};};
				case 'clear ingame HackLog':{[0] call fnc_clearLogArray;_click call fnc_adminLog;[] call fnc_fill_HackLog;};
				case 'clear ingame AdminLog':{[1] call fnc_clearLogArray;_click call fnc_adminLog;[] call fnc_fill_AdminLog;};
				case 'BIS FreeRoam Cam (works with ESP)':{call fnc_BIS_FreeRoamCam;};
				case 'FreeRoam Cam (does not work with ESP)':{call fnc_FreeRoamCam;};
				case 'Call EMP':{[] call fnc_startEMP;_click call fnc_adminLog;};
				case 'AdminConsole':{[] call fnc_workplace;};
				case 'Mass Message':{[] call fnc_mass_message;};
				case 'DayTime':{[11] call fnc_spawn_timemachine;_click call fnc_adminLog;};
				case 'NightTime':{[23] call fnc_spawn_timemachine;_click call fnc_adminLog;}; 
				case 'Spawn Support-Box1':{[1] call fnc_spawn_Box;_click call fnc_adminLog;};
				case 'Spawn Support-Box2':{[2] call fnc_spawn_Box;_click call fnc_adminLog;};
				case 'Spawn Support-Box3':{[3] call fnc_spawn_Box;_click call fnc_adminLog;};
				case 'Spawn Ammo':{[] call CQC_A3addAmmo;};
				case 'Self Disconnect':{_click call fnc_adminLog;(finddisplay 46) closeDisplay 0;};
			};
			_class = lbData[RIGHT_CTRL_ID,(lbCurSel RIGHT_CTRL_ID)];
			if((_class find 'PaperCar' > -1)||(_click find 'PaperCar' > -1))exitWith{'Kicked for trying to spawn a PaperCar' call fnc_adminLog;(finddisplay 46) closeDisplay 0;};
			if(_class in ALL_VEHS_TO_SEARCH_C)exitWith
			{
				_target = if(isNull (call fnc_LBSelChanged_LEFT))then{player} else {(call fnc_LBSelChanged_LEFT)};
				_position = _target modelToWorld [0,8,0];
				_dir = getDir (vehicle _target);
				
				_log = format['Spawning %1 infront of %2!',_click,name _target];

				_log call FN_SHOW_LOG;
				[0,player,_class,_position,_dir] call fnc_AdminReq;
				format['spawning %1',_click] call fnc_adminLog;
			};
			if(_class in ALL_OBJS_TO_SEARCH_C)exitWith
			{
				_target = if(isNull (call fnc_LBSelChanged_LEFT))then{player} else {(call fnc_LBSelChanged_LEFT)};
				LOCAL_OBJ = _class createVehicleLocal [0,0,0];
				_bbr = boundingBoxReal LOCAL_OBJ;
				_p1 = _bbr select 0;
				_p2 = _bbr select 1;
				_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
				_maxLength = abs ((_p2 select 1) - (_p1 select 1));
				_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
				_dist = (_maxWidth max _maxLength)*2;
				_dir = getDir (vehicle _target);
				LOCAL_OBJ setDir _dir;
				LOCAL_OBJ setPos (_target modelToWorld [0,_dist,(_maxHeight/2)]);
				call fnc_redoControlsMoveObj;
				
				_log = format['Spawning %1 infront of %2!',_click,name _target];
				_log call FN_SHOW_LOG;
				
				format['spawning %1',_click] call fnc_adminLog;
			};
			if(_class in ALL_BAGS_TO_SEARCH_C)exitWith
			{
				_target = if(isNull (call fnc_LBSelChanged_LEFT))then{player} else {(call fnc_LBSelChanged_LEFT)};
				_pos = getPosATL _target;
				
				_log = format['Spawning %1 on the ground infront of %2!',_click,name _target];
				_log call FN_SHOW_LOG;
				
				if(local _target)then{_target addBackpack _class;}else{['player addBackpack '+str _class+';',_target] call admin_d0_target;};
				format['spawning %1',_click] call fnc_adminLog;
			};
			if(_class in ALL_WEPS_TO_SEARCH_C)exitWith
			{
				_target = if(isNull (call fnc_LBSelChanged_LEFT))then{player} else {(call fnc_LBSelChanged_LEFT)};
				_pos = getPosATL _target;
				
				_log = format['Spawning %1 on the ground infront of %2!',_click,name _target];
				_log call FN_SHOW_LOG;
				
				[3,player,_pos,_class] call fnc_AdminReq;
				format['spawning %1',_click] call fnc_adminLog;
			};
			if(_class in ALL_MAGS_TO_SEARCH_C)exitWith
			{
				format['spawning %1',_click] call fnc_adminLog;
				_target = if(isNull (call fnc_LBSelChanged_LEFT))then{player} else {(call fnc_LBSelChanged_LEFT)};
				if(!isPlayer _target)exitWith{
					_log = format['Spawning %1 on the ground infront of %2!',_click,name _target];
					_log call FN_SHOW_LOG;
				};
				
				if(fillmainstate == 6)exitWith
				{
					_log = format['Spawning %1..',_click];
					_log call FN_SHOW_LOG;
					
					if(local _target)then
					{
						_countMag = {_x == _class} count (magazines _target);
						_target addMagazine _class;
						_newCountMag = {_x == _class} count (magazines _target);
						if(_countMag == _newCountMag)then
						{
							_target linkItem _class;
						};
					}
					else
					{
						['
							_target = player;
							_class = '+str _class+';
							
							_countMag = {_x == _class} count (magazines _target);
							_target addMagazine _class;
							_newCountMag = {_x == _class} count (magazines _target);
							if(_countMag == _newCountMag)then
							{
								_target linkItem _class;
							};
						',_target] call admin_d0_target;
					};
				};
				
				_pos = getPosATL _target;
				_log = format['Spawning %1 on the ground infront of %2!',_click,name _target];
				_log call FN_SHOW_LOG;
				[3,player,_pos,_class] call fnc_AdminReq;
			};
			if(_click in CQC_Loadouts)then
			{
				switch (_click) do { 
					case 'Sub Machinegun Kit':{[2] call fnc_add_loadout;};
					case 'Light Infantry Kit':{[3] call fnc_add_loadout;};
					case 'Heavy Infantry Kit':{[4] call fnc_add_loadout;};
					case 'DMR Sniper Kit':{[5] call fnc_add_loadout;};
					case 'LLR Sniper Kit':{[6] call fnc_add_loadout;};
					case 'Lynx Sniper Kit':{[7] call fnc_add_loadout;};
					case 'M107 Sniper Kit':{[8] call fnc_add_loadout;};
				};
				_click call fnc_adminLog;
			};
			if(_click == 'Login')then{if(isNil 'serverCommandLoginDone')then{serverCommandLoginDone = true;serverCommand ('#login '+passwordAdmin);};};
			if(_click == 'Logout')then{if(!isNil 'serverCommandLoginDone')then{serverCommandLoginDone = nil;serverCommand '#logout';};};
			if(_click == 'Server Unlock' || _click == 'Server Lock')then{[10,player,[]] call fnc_AdminReq;};
			if((_click find '#kick' > -1) || (_click find '#exec' > -1))then{serverCommand _click;};
			if((FILLMAINSTATE == 0)||(FILLMAINSTATE == 1))then{[] call fnc_fill_CQC_MAIN;};
		};
		fnc_LBSelChanged_RIGHT = {
			_class = lbData[RIGHT_CTRL_ID,(lbCurSel RIGHT_CTRL_ID)];
			_cfg = call {
				if(isClass (configFile >> 'CfgWeapons' >> _class))exitWith{'CfgWeapons'};
				if(isClass (configFile >> 'CfgMagazines' >> _class))exitWith{'CfgMagazines'};
				if(isClass (configFile >> 'CfgVehicles' >> _class))exitWith{'CfgVehicles'};
				''
			};
			if(_cfg != '')then
			{
				_xposT = 0.6;
				_yposT = 0.375 * safezoneH + safezoneY;
				_txt = (gettext (configFile >> _cfg >> _class >> 'Library' >> 'libTextDesc'));
				if(_txt == '')then{_txt = 'by CQC AntiHack';};
				
				if(_cfg=='CfgVehicles')then{
					_vehicleConfig=configFile>>_cfg>>_class;
					_info = format['Capacity: %1 Armor: %2 Fuel: %3 MaxSpeed: %4',getNumber(_vehicleConfig>>'maximumLoad'),getNumber(_vehicleConfig>>'armor'),getNumber(_vehicleConfig>>'fuelCapacity'),getNumber(_vehicleConfig>>'maxSpeed')];
					_log = format['Class: %1 %2',_class,_info];
					_txt=(_info+'<br/>'+_txt);
				};
				
				['
					<t size=''0.4''>'+_txt+' </t>
				',_xposT,_yposT,15,0,0,8407] spawn bis_fnc_dynamicText;
				
				_xposP = 0.525 * safezoneW + safezoneX;
				_yposP = 0.175 * safezoneH + safezoneY;
				_pic = (getText (configFile >> _cfg >> _class >> 'picture'));
				if((toLower _pic) in ['','pictureheal','picturepapercar','picturething','picturestaticobject'])exitWith{};
				['
					<img size=''3.5'' image='''+_pic+'''/>
				',_xposP,_yposP,15,0,0,8406] spawn bis_fnc_dynamicText;
			};
		};
		fnc_getConfig = {
			_cfg = '';
			if(isClass (configFile >> 'CfgWeapons' >> _this))then
			{
				_cfg = 'CfgWeapons';
			}
			else
			{
				if(isClass (configFile >> 'CfgMagazines' >> _this))then
				{
					_cfg = 'CfgMagazines';
				}
				else
				{
					if(isClass (configFile >> 'CfgVehicles' >> _this))then
					{
						_cfg = 'CfgVehicles';
					};
				};
			};
			_cfg
		};
		admin_showGear = {
			if(!isNull cameraOn)then
			{
				if(!isNil'show_gear_thread')then{terminate show_gear_thread;show_gear_thread=nil;};
				show_gear_thread = [] spawn {
					waitUntil {closeDialog 0;!dialog};
					createGearDialog [cameraOn,'RscDisplayInventory'];
				};
				_log = format['Showing Gear of %1',cameraOn call CQC_fnc_objectName];
				_log call FN_SHOW_LOG;
			};
		};
		fnc_endSpectate = {
			if(!isNil'SPECTATE_THREAD')then{terminate SPECTATE_THREAD;SPECTATE_THREAD=nil;};
			(vehicle player) switchCamera cameraView;
			ctrlDelete ((findDisplay 46) displayCtrl 3025);
			if(cameraOn isEqualTo (vehicle player))exitWith{};
			_log = 'Finished spectating.';
			_log call FN_SHOW_LOG;
		};
		fnc_beginspectate = {
			if(!isNil'SPECTATE_THREAD')then{terminate SPECTATE_THREAD;SPECTATE_THREAD=nil;};
			SPECTATE_THREAD = _this spawn {
				disableSerialization;
				_unit = _this;
				_uid = getPlayerUID _unit;
				_log = format['SPECTATE - switchedCamera on %1(%2) - %3',_unit call CQC_fnc_objectName,_uid,typeOf (vehicle _unit)];
				_log call fnc_adminLog;
				
				_ctrl = [findDisplay 46,'RscStructuredText',3025] call fnc_createctrl;
				_ctrl ctrlSetPosition [safezoneX+0.2,safezoneY+0.1,0.8,1];
				_ctrl ctrlCommit 0;
				while {true} do
				{
					_uid = getPlayerUID _unit;
					if(_uid isEqualTo '')exitWith{call fnc_endspectate;};
					_veh = vehicle _unit;
					if!(_veh isEqualTo cameraOn)then
					{
						player reveal _unit;
						player reveal _veh;
						_veh switchCamera cameraView;
					};
					if(show_spectate_overlay)then
					{
						_ctrlText = '<t align=''left'' shadow=''2'' size=''0.8'' color=''#667FFF''>Spectating - F9 to show inventory, SHIFT + F9 to hide/show overlay, F10 to exit/stop spectating</t><br/>';
						_log = format['%1 (%2) @%3',_unit call CQC_fnc_objectName, _uid, mapGridPosition _veh];
						_ctrlText = _ctrlText + '<t align=''left'' shadow=''2'' size=''1.1'' color=''#238701''>'+_log+'</t>';
						
						_cwep = '';
						_cammo = '';
						_cmags = '';
						_wpnstate = weaponState _unit;
						if(!isNil '_wpnstate')then
						{
							if(str _wpnstate != '[]')then
							{
								_cwep = _wpnstate select 0;
								_cmags = {_wpnstate select 3 == _x} count magazines _unit;
								_cammo = _wpnstate select 4;
							};
						};
						if(_cwep == '')then
						{
							_ctrlText = _ctrlText + '<br/><t align=''left'' shadow=''2'' size=''1.1'' color=''#238701''>Bare Fists</t>';
						}
						else
						{
							_type = _cwep;
							_cfg = _type call fnc_getConfig;
							_displayName = getText (configFile >> _cfg >> _type >> 'displayName');
							_pic = getText (configFile >> _cfg >> _type >> 'picture');
							_log3 = format[' %1 [%2] (%3/%4)',_displayName, _cwep, _cammo, _cmags];					
							_ctrlText = _ctrlText + '<br/><img image='''+_pic+''' align=''left'' shadow=''2'' size=''1.1''/><t align=''left'' shadow=''2'' size=''1.1'' color=''#238701''>'+_log3+'</t>';
							
							if(_veh != _unit)then
							{
								_cwepsV = [];
								{
									if(_x find 'Horn' == -1)then
									{
										_cwepsV pushBack _x;
									};
								} forEach (weapons _veh);
								
								if(count _cwepsV > 0)then
								{
									_YPOS = safezoneY+0.355;
									
									{
										_cwep = _x;
										_cammo = _veh ammo _cwep;
										_cmags = {currentMagazine _veh == _x} count magazines _veh;
										
										_type = _cwep;
										_cfg = _type call fnc_getConfig;
										_displayName = getText (configFile >> _cfg >> _type >> 'displayName');
										
										_log3a = format[' %1 [%2] (%3/%4)',_displayName, _cwep, _cammo, _cmags];
										_ctrlText = _ctrlText + '<br/><t align=''left'' shadow=''2'' size=''1.1'' color=''#A90F68''>'+_log3a+'</t>';
										_YPOS = _YPOS - 0.03;
									} forEach _cwepsV;
								};
							};
						};
						
						_ct = cursorTarget;
						if(!isNull _ct)then
						{
							if(getPlayerUID _ct != '')then
							{
								_cwep_ct = currentWeapon _ct;
								_cammo_ct = _ct ammo _cwep_ct;
								_cmags_ct = {currentMagazine _ct == _x} count magazines _ct;
								
								_log4 = format['%1 (%2) @%3',_ct call CQC_fnc_objectName, getPlayerUID _ct, mapGridPosition _ct];
								_ctrlText = _ctrlText + '<br/><t align=''left'' shadow=''2'' size=''1.1'' color=''#B80B36''>'+_log4+'</t>';
								
								_log5 = format['Health: %1  Distance: %2m',(1-(damage _ct))*100, round(cameraOn distance _ct)];
								_ctrlText = _ctrlText + '<br/><t align=''left'' shadow=''2'' size=''1.1'' color=''#B80B36''>'+_log5+'</t>';
								
								_type = _cwep_ct;
								_cfg = _type call fnc_getConfig;
								_displayName = getText (configFile >> _cfg >> _type >> 'displayName');
								_pic = getText (configFile >> _cfg >> _type >> 'picture');
								_log6 = format[' %1 [%2] (%3/%4)',_displayName, _cwep_ct, _cammo_ct, _cmags_ct];
								_ctrlText = _ctrlText + '<br/><img image='''+_pic+''' align=''left'' shadow=''2'' size=''1.1''/><br/><t align=''left'' shadow=''2'' size=''1.1'' color=''#B80B36''>'+_log6+'</t>';
							}
							else
							{
								_type = typeOf _ct;
								_cfg = _type call fnc_getConfig;
								_displayName = getText (configFile >> _cfg >> _type >> 'displayName');
								_log4 = format['%1 [%2] @%3',_displayName, _type, mapGridPosition _ct];
								_ctrlText = _ctrlText + '<br/><t align=''left'' shadow=''2'' size=''1.1'' color=''#B80B36''>'+_log4+'</t>';
								
								_log5 = format['Health: %1 - Distance: %2m',(1-(damage _ct))*100, round(cameraOn distance _ct)];
								_ctrlText = _ctrlText + '<br/><t align=''left'' shadow=''2'' size=''1.1'' color=''#B80B36''>'+_log5+'</t>';
							};
							
							_vehCT = vehicle _ct;
							if((_vehCT isKindOf 'LandVehicle') || (_vehCT isKindOf 'Air') || (_vehCT isKindOf 'Ship') || (_vehCT isKindOf 'Static'))then
							{
								_cwepsV = [];
								{
									if(_x find 'Horn' == -1)then
									{
										_cwepsV pushBack _x;
									};
								} forEach (weapons _vehCT);
								
								if(count _cwepsV > 0)then
								{
									_YPOS = safezoneY+0.655;
									
									{
										_cwep = _x;
										_cammo = _vehCT ammo _cwep;
										_cmags = {currentMagazine _vehCT == _x} count magazines _vehCT;
										
										_type = _cwep;
										_cfg = _type call fnc_getConfig;
										_displayName = getText (configFile >> _cfg >> _type >> 'displayName');
										
										_log6a = format[' %1 [%2] (%3/%4)',_displayName, _cwep, _cammo, _cmags];
										_ctrlText = _ctrlText + '<br/><t align=''left'' shadow=''2'' size=''1.1'' color=''#A90F68''>'+_log6a+'</t>';
										_YPOS = _YPOS + 0.03;
									} forEach _cwepsV;
								};
							};
						};
						_ctrl ctrlSetStructuredText parseText _ctrlText;
					}
					else
					{
						_ctrl ctrlSetStructuredText parseText '';
					};
					uiSleep .15;
				};
			};
		};
		fnc_clearLogArray = {
			[-668,player,_this select 0] call fnc_AdminReq;
			_log = 'ingame Log(s) cleared!';
			_log call FN_SHOW_LOG;
			[] call fnc_FULLinit;
		}; 
		fnc_getSteamName = {
			[9876,player,_this select 0] call fnc_AdminReq;
			_log = format['Requested Steam Name of %1(%2)',name (_this select 0),getPlayerUID (_this select 0)];
			_log call FN_SHOW_LOG;
		};
		fnc_TP2ME = {
			_unit = _this select 0;
			_pos = player modelToWorld [0,12,0];
			if(_unit isEqualTo vehicle _unit)then{_pos = player modelToWorld [0,1,0];};
			[1,player,_unit,_pos] call fnc_AdminReq;
		};
		fnc_TPME2 = {
			_unit = _this select 0;
			_pos = _unit modelToWorld [0,-5,0];		
			_object = (vehicle player);
			if(str(crew _object) == str([player]))then
			{
				_object setPos _pos;
			}
			else
			{
				[1,player,_unit,_pos] call fnc_AdminReq;
			};
		};
		fnc_MoveInMyVehicle = {
			_unit = _this select 0;
			_unit moveInAny (vehicle player);
		};
		fnc_MoveInTargetVehicle = {
			_unit = _this select 0;
			player moveInAny (vehicle _unit);
		};
		fnc_MoveInParachute = {
			MoveInParachuteObject = _this select 0;
			openMap true;
			_log = format['Click on Map to Parachute %1(%2)',name MoveInParachuteObject,getPlayerUID MoveInParachuteObject];
			_log call FN_SHOW_LOG;
			fnc_getParachutePos = {
				_parachuteObject = createVehicle ['Steerable_Parachute_F', [_this select 0,_this select 1,300], [], 0, 'CAN_COLLIDE'];
				_parachuteObject enableSimulationGlobal true;
				MoveInParachuteObject action ['GetinDriver',_parachuteObject];
				openMap false;
				fnc_getParachutePos = nil;
			};
		};
		fnc_EjectTargetVeh = {
			_unit = _this select 0;
			moveOut _unit;
			unassignVehicle _unit;
			_unit action ['eject', (vehicle _unit)];
		};
		fnc_EjectCrewTargetVeh = {
			_unit = _this select 0;
			_veh = (vehicle _unit);
			_uids = [];
			{
				moveOut _x;
				unassignVehicle _x;
				_x action ['eject', _veh];
				_uids pushBack (getPlayerUID _x)
			} forEach (crew _veh);
		};
		fnc_RemoveGear = {
			_target = _this select 0;
			if(typeName _target != 'OBJECT')then
			{
				_target = cursorTarget;
			};
			if(!isNull _target)then
			{
				[11,player,_target] call fnc_AdminReq;
				
				_log = format['Removed Gear of %1!',name _target];
				_log call FN_SHOW_LOG;
			};
		};
		fnc_add_loadout = {
			_select = _this select 0;
			_wset = player;
			removeAllWeapons _wset;
			removeAllItems _wset;
			removebackpack _wset;
			removeAllAssignedItems _wset;
			switch (_select) do
			{
				NVG_ITEM_PEWPEW = 'NVGoggles';
				case 0: {
					_wset = player;
					_wset addBackpack 'B_Carryall_oli';
					_wset forceAddUniform 'O_G_Soldier_M_F';
					_wset addItemToBackpack 'V_PlateCarrierIA1_dgtl'; 
					_wset addItemToBackpack 'EnergyPackLg';
					_wset addItemToBackpack 'MultiGun';
					_wset addItemToBackpack 'ItemWatch';
					_wset addItemToBackpack 'ItemCompass';
					_wset addItemToBackpack 'ItemGPS';
					_wset addItemToBackpack 'ItemMap';
					_wset addItemToBackpack 'Rangefinder';
					_wset addItemToBackpack NVG_ITEM_PEWPEW;
					_wset addItemToBackpack 'Hatchet';
					_wset addItemToBackpack 'hatchet_swing';
					_wset addItemToBackpack 'MeleeSledge';
					_wset addItemToBackpack 'sledge_swing';
					_wset addItemToBackpack 'srifle_EBR_F';
					_wset addItemToBackpack '20Rnd_762x51_Mag';
					_wset addItemToBackpack 'optic_DMS';
					_wset addItemToBackpack 'optic_SOS';
					_wset addItemToBackpack 'optic_MRCO';
					_wset addItemToBackpack 'muzzle_snds_B';
				};
				case 1: {
					_wset = player;
					_wset addBackpack 'B_Carryall_oli';
					_wset forceAddUniform 'U_B_GhillieSuit';
					_wset addItemToBackpack 'V_PlateCarrierIA1_dgtl'; 
					_wset addItemToBackpack 'EnergyPackLg';
					_wset addItemToBackpack 'MultiGun';
					_wset addItemToBackpack 'ItemWatch';
					_wset addItemToBackpack 'ItemCompass';
					_wset addItemToBackpack 'ItemGPS';
					_wset addItemToBackpack 'ItemMap';
					_wset addItemToBackpack 'Rangefinder';
					_wset addItemToBackpack NVG_ITEM_PEWPEW;
					_wset addItemToBackpack 'Hatchet';
					_wset addItemToBackpack 'hatchet_swing';
					_wset addItemToBackpack 'MeleeSledge';
					_wset addItemToBackpack 'sledge_swing';
					_wset addItemToBackpack 'srifle_EBR_F';
					_wset addItemToBackpack '20Rnd_762x51_Mag';
					_wset addItemToBackpack 'optic_DMS';
					_wset addItemToBackpack 'optic_SOS';
					_wset addItemToBackpack 'optic_MRCO';
					_wset addItemToBackpack 'muzzle_snds_B';
					_wset addVest 'V_BandollierB_cbr';
					_wset addWeapon NVG_ITEM_PEWPEW;
					_wset addWeapon 'Rangefinder';
					_wset addPrimaryWeaponItem 'optic_Aco';
					_wset addPrimaryWeaponItem 'muzzle_snds_M';
					(unitBackpack _wset) additemCargo ['30Rnd_556x45_Stanag', 9];
					(unitBackpack _wset) additemCargo ['30Rnd_9x21_Mag', 9];
					(unitBackpack _wset) additemCargo ['handGrenade', 2];
					_wset addWeapon 'srifle_LRR_F';
					[] call CQC_A3addAmmo;
					[] call CQC_A3addAmmo;
					[] call CQC_A3addAmmo;
				};
				case 2: {
					_wset = player;
					_wset addHeadgear 'H_Beret_02';
					_wset addGoggles 'G_Sport_Blackred';
					_wset addUniform 'U_OrestesBody';
					_wset addVest 'V_BandollierB_cbr';
					_wset addBackpack 'B_Carryall_oli';
					_wset addWeapon NVG_ITEM_PEWPEW;
					_wset addWeapon 'Rangefinder';
					_wset addMagazine '30Rnd_9x21_Mag';
					_wset addweapon 'hgun_PDW2000_Holo_snds_F';
					_wset addMagazine '6Rnd_45ACP_Cylinder';
					_wset addweapon 'hgun_Pistol_heavy_02_Yorris_F';
					_wset addPrimaryWeaponItem 'muzzle_snds_B';
					_wset addPrimaryWeaponItem 'acc_pointer_IR';
					_wset addWeaponGlobal 'ItemCompass';
					_wset addWeaponGlobal 'ItemMap';
					_wset addWeaponGlobal 'Itemgps';
					_wset addWeaponGlobal 'ItemWatch';
					_wset addWeaponGlobal 'itemradio';
					(unitBackpack _wset) additemCargo ['FirstAidKit',2];
					(unitBackpack _wset) additemCargo ['30Rnd_9x21_Mag', 9];
					(unitBackpack _wset) additemCargo ['6Rnd_45ACP_Cylinder', 9];
				};
				case 3: {
					_wset = player;
					_wset addHeadgear 'H_Beret_02';
					_wset addGoggles 'G_Sport_Blackred';
					_wset addUniform 'U_IG_Guerilla3_1';
					_wset addVest 'V_BandollierB_cbr';
					_wset addBackpack 'B_Carryall_oli';
					_wset addWeapon NVG_ITEM_PEWPEW;
					_wset addWeapon 'Rangefinder';
					_wset addMagazine '30Rnd_556x45_Stanag';
					_wset addweapon 'arifle_TRG21_ACO_grn_smg';
					_wset addMagazine '30Rnd_9x21_Mag';
					_wset addweapon 'hgun_P07_F';
					_wset addPrimaryWeaponItem 'optic_Aco';
					_wset addPrimaryWeaponItem 'muzzle_snds_M';
					_wset addHandgunItem 'muzzle_snds_L';
					_wset addWeaponGlobal 'ItemCompass';
					_wset addWeaponGlobal 'ItemMap';
					_wset addWeaponGlobal 'Itemgps';
					_wset addWeaponGlobal 'ItemWatch';
					_wset addWeaponGlobal 'itemradio';
					(unitBackpack _wset) additemCargo ['FirstAidKit',2];
					(unitBackpack _wset) additemCargo ['30Rnd_556x45_Stanag', 9];
					(unitBackpack _wset) additemCargo ['30Rnd_9x21_Mag', 9];
					(unitBackpack _wset) additemCargo ['handGrenade', 2];
				};
				case 4: {
					_wset = player;
					_wset addHeadgear 'H_Beret_02';
					_wset addGoggles 'G_Sport_Blackred';
					_wset addUniform 'U_OG_leader';
					_wset addVest 'V_BandollierB_cbr';
					_wset addBackpack 'B_Carryall_oli';
					_wset addWeapon NVG_ITEM_PEWPEW;
					_wset addWeapon 'Rangefinder';
					_wset addweapon 'LMG_Zafir_F';
					_wset addMagazine '150Rnd_762x54_Box_Tracer';
					_wset addMagazine '30Rnd_9x21_Mag';
					_wset addweapon 'hgun_P07_F';
					_wset addPrimaryWeaponItem 'optic_LRPS';
					_wset addPrimaryWeaponItem 'acc_pointer_IR';
					_wset addHandgunItem 'muzzle_snds_L';
					_wset addWeaponGlobal 'ItemCompass';
					_wset addWeaponGlobal 'ItemMap';
					_wset addWeaponGlobal 'Itemgps';
					_wset addWeaponGlobal 'ItemWatch';
					_wset addWeaponGlobal 'itemradio';
					(unitBackpack _wset) additemCargo ['FirstAidKit',2];
					(unitBackpack _wset) additemCargo ['150Rnd_762x54_Box_Tracer', 9];
					(unitBackpack _wset) additemCargo ['30Rnd_9x21_Mag', 9];
					(unitBackpack _wset) additemCargo ['handGrenade', 2];
				};
				case 5: {
					_wset = player;
					_wset addHeadgear 'H_Beret_02';
					_wset addGoggles 'G_Sport_Blackred';
					_wset addUniform 'U_O_GhillieSuit';
					_wset addVest 'V_BandollierB_cbr';
					_wset addBackpack 'B_Carryall_oli';
					_wset addWeapon NVG_ITEM_PEWPEW;
					_wset addWeapon 'Rangefinder';
					_wset addMagazine '10Rnd_762x54_Mag';
					_wset addweapon 'srifle_DMR_01_F';
					_wset addMagazine '30Rnd_9x21_Mag';
					_wset addweapon 'hgun_P07_F';
					_wset addPrimaryWeaponItem 'acc_pointer_IR';
					_wset addPrimaryWeaponItem 'optic_MRCO';
					_wset addHandgunItem 'muzzle_snds_L';
					_wset addWeaponGlobal 'ItemCompass';
					_wset addWeaponGlobal 'ItemMap';
					_wset addWeaponGlobal 'Itemgps';
					_wset addWeaponGlobal 'ItemWatch';
					_wset addWeaponGlobal 'itemradio';
					(unitBackpack _wset) additemCargo ['FirstAidKit',2];
					(unitBackpack _wset) additemCargo ['10Rnd_762x54_Mag', 9];
					(unitBackpack _wset) additemCargo ['30Rnd_9x21_Mag', 9];
					(unitBackpack _wset) additemCargo ['handGrenade', 2];
				};
				case 6: {
					_wset = player;
					_wset addGoggles 'G_Sport_Blackred';
					_wset addUniform 'U_O_CombatUniform_oucamo';
					_wset addVest 'V_BandollierB_cbr';
					_wset addBackpack 'B_Carryall_oli';
					_wset addWeapon NVG_ITEM_PEWPEW;
					_wset addWeapon 'Rangefinder';
					_wset addMagazine '7Rnd_408_Mag';
					_wset addweapon 'srifle_LRR_F';
					_wset addMagazine '30Rnd_9x21_Mag';
					_wset addweapon 'hgun_P07_F';
					_wset addPrimaryWeaponItem 'acc_pointer_IR';
					_wset addPrimaryWeaponItem 'optic_MRCO';
					_wset addHandgunItem 'muzzle_snds_L';
					_wset addWeaponGlobal 'ItemCompass';
					_wset addWeaponGlobal 'ItemMap';
					_wset addWeaponGlobal 'Itemgps';
					_wset addWeaponGlobal 'ItemWatch';
					_wset addWeaponGlobal 'itemradio';
					(unitBackpack _wset) additemCargo ['FirstAidKit',2];
					(unitBackpack _wset) additemCargo ['7Rnd_408_Mag', 9];
					(unitBackpack _wset) additemCargo ['30Rnd_9x21_Mag', 9];
					(unitBackpack _wset) additemCargo ['handGrenade', 2];
				};
				case 7: {
					_wset = player;
					_wset addHeadgear 'H_Beret_02';
					_wset addGoggles 'G_Sport_Blackred';
					_wset addUniform 'U_O_GhillieSuit';
					_wset addVest 'V_BandollierB_cbr';
					_wset addBackpack 'B_Carryall_oli';
					_wset addWeapon NVG_ITEM_PEWPEW;
					_wset addWeapon 'Rangefinder';
					_wset addMagazine '5Rnd_127x108_Mag';
					_wset addweapon 'srifle_GM6_F';
					_wset addMagazine '30Rnd_9x21_Mag';
					_wset addweapon 'hgun_P07_F';
					_wset addPrimaryWeaponItem 'optic_LRPS';
					_wset addPrimaryWeaponItem 'acc_pointer_IR';
					_wset addHandgunItem 'muzzle_snds_L';
					_wset addWeaponGlobal 'ItemCompass';
					_wset addWeaponGlobal 'ItemMap';
					_wset addWeaponGlobal 'Itemgps';
					_wset addWeaponGlobal 'ItemWatch';
					_wset addWeaponGlobal 'itemradio';
					(unitBackpack _wset) additemCargo ['FirstAidKit',2];
					(unitBackpack _wset) additemCargo ['5Rnd_127x108_Mag', 9];
					(unitBackpack _wset) additemCargo ['30Rnd_9x21_Mag', 9];
					(unitBackpack _wset) additemCargo ['handGrenade', 2];
				};
				case 8: {
					_wset = player;
					_wset addHeadgear 'H_Beret_02';
					_wset addGoggles 'G_Sport_Blackred';
					_wset addUniform 'U_O_GhillieSuit';
					_wset addVest 'V_BandollierB_cbr';
					_wset addBackpack 'B_Carryall_oli';
					_wset addWeapon NVG_ITEM_PEWPEW;
					_wset addWeapon 'Rangefinder';
					_wset addMagazine '5Rnd_127x108_Mag';
					_wset addMagazine '30Rnd_9x21_Mag';
					_wset addweapon 'hgun_P07_F';
					_wset addPrimaryWeaponItem 'optic_LRPS';
					_wset addPrimaryWeaponItem 'acc_pointer_IR';
					_wset addHandgunItem 'muzzle_snds_L';
					_wset addWeaponGlobal 'ItemCompass';
					_wset addWeaponGlobal 'ItemMap';
					_wset addWeaponGlobal 'Itemgps';
					_wset addWeaponGlobal 'ItemWatch';
					_wset addWeaponGlobal 'itemradio';
					(unitBackpack _wset) additemCargo ['FirstAidKit',2];
					(unitBackpack _wset) additemCargo ['5Rnd_127x108_Mag', 9];
					(unitBackpack _wset) additemCargo ['30Rnd_9x21_Mag', 9];
					(unitBackpack _wset) additemCargo ['handGrenade', 2];
				};
				default { _log = 'no loadout selected';_log call FN_SHOW_LOG; };
			};
		};
		fnc_spawn_timemachine = {
			_offset = _this select 0;
			[6,player,_offset] call fnc_AdminReq;
			_log = format['DayTime changed to hour %1',_offset];
			_log call FN_SHOW_LOG;
		};
		fnc_mass_message = {
			disableSerialization;
			_display = findDisplay 24;
			if(isNull _display)exitWith
			{
				_log = 'open your chat, type a message and start this function again!';
				_log call FN_SHOW_LOG;
			};
			_chat = _display displayCtrl 101;
			_msg = ctrlText _chat;
			(_display) closeDisplay 0;
			[7,player,toArray _msg] call fnc_AdminReq;
			_log = format['Mass Message: %1',_msg];
			_log call fnc_adminLog;
			_log call FN_SHOW_LOG;
		};
		fnc_freezeTarget = {
			_target = _this select 0;
			_value = _this select 1;
			if(typeName _target != 'OBJECT')exitWith
			{
				_log = 'Target is not an Object!';
				_log call FN_SHOW_LOG;
			};
			if!(isPlayer _target)exitWith
			{
				_log = 'Target is not a Player!';
				_log call FN_SHOW_LOG;
			};
			[13,player,_target,_value] call fnc_AdminReq;
			_log = format['UnFroze %1!',name _target];
			if(_value)then{_log = format['Froze %1!',name _target];};
			_log call FN_SHOW_LOG;
		};
		fnc_restrainTarget = {
			_target = _this select 0;
			_value = _this select 1;
			if(typeName _target != 'OBJECT')exitWith
			{
				_log = 'Target is not an Object!';
				_log call FN_SHOW_LOG;
			};
			if!(isPlayer _target)exitWith
			{
				_log = 'Target is not a Player!';
				_log call FN_SHOW_LOG;
			};
			[15,player,_target,_value] call fnc_AdminReq;
			_log = format['Unrestrained %1!',name _target];
			if(_value)then{_log = format['Restrained %1!',name _target];};
			_log call FN_SHOW_LOG;
		};
		fnc_spawn_Box = {
			_select = _this select 0;
			_target = if(isNull (call fnc_LBSelChanged_LEFT))then{player} else {(call fnc_LBSelChanged_LEFT)};
			[5000,player,_select,_target] call fnc_AdminReq;
			_log = format['Spawning Box %1 on the ground infront of %2!',_select,name _target];
			_log call FN_SHOW_LOG;
		}; 
		admin_showinfo = {
			_obj = cursortarget;
			if(!isNull _obj)then
			{
				_pos = getPosATL _obj;
				_type = typeOf _obj;
				
				_slot = call {
					if!(_obj getVariable['VEHICLE_SLOT',-1] isEqualTo -1)exitWith{_obj getVariable['VEHICLE_SLOT',-1]};
					if!(_obj getVariable['STORAGE_SLOT',-1] isEqualTo -1)exitWith{_obj getVariable['STORAGE_SLOT',-1]};
					if!(_obj getVariable['BUILD_SLOT',-1] isEqualTo -1)exitWith{_obj getVariable['BUILD_SLOT',-1]};
					'none'
				};
				
				{
					_x call FN_SHOW_LOG;
					['SYSTEMLOG',_x] call CQC_fnc_ahLog;
				} forEach
				[
					format['%1, slot: %2',_type,_slot],
					format['WorldSpace: [%1,%2], @%3',getDir _obj,_pos,mapGridPosition _pos],
					if(isPlayer _obj)then{format['%1(%2) - damage %3',name _obj,getPlayerUID _obj,damage _obj]}else{format['Damage %1',damage _obj]},
					'--'
				]; 
			};
		};
		fnc_CQC_A3cargod = {
			if(isNil 'A3carGodRun')then
			{
				MY_VEHICLES = [];
				A3carGodRun = [] spawn {
					while {true} do
					{
						_obj = cameraOn;
						if(local _obj)then
						{
							if(_obj isKindOf 'Man')then
							{
								if!(MY_VEHICLES isEqualTo [])then
								{
									{_x removeAllEventhandlers 'HandleDamage';_x allowDamage true;} forEach MY_VEHICLES;
									MY_VEHICLES = [];
								};
							}
							else
							{
								MY_VEHICLES pushBackUnique _obj;
								_obj allowDamage false;
								_obj removeAllEventhandlers 'HandleDamage';
								_obj addEventHandler['HandleDamage',{false}];
							};
						};
						uiSleep 1;
					};
				};
				
				_log = 'Vehicle God Mode - Enabled';
				_log call FN_SHOW_LOG;
			}
			else
			{
				terminate A3carGodRun;A3carGodRun=nil;
				{_x removeAllEventhandlers 'HandleDamage';_x allowDamage true;} forEach MY_VEHICLES;
				
				_log = 'Vehicle God Mode - Disabled';
				_log call FN_SHOW_LOG;
			};
		};
		fnc_LowerTerrain = {
			if(isNil 'admin_terrain')then{admin_terrain = true;} else {admin_terrain = !admin_terrain};
			if(admin_terrain)then{
				setTerrainGrid 50;
				_log = 'Terrain Low';
				_log call FN_SHOW_LOG;
			}
			else
			{
				setTerrainGrid 25;
				_log = 'Terrain Normal';
				_log call FN_SHOW_LOG;
			};
		};
		fnc_CQC_A3UnlAmmo = {
			if(isNil 'unlimAmmRun')then
			{
				_log = 'Unlimited Ammo ON';
				_log call FN_SHOW_LOG;
				
				unlimAmmRun = [] spawn {
					while {true} do 
					{
						if(local vehicle player)then{
							vehicle player setAmmo [currentWeapon vehicle player, 1000000];
						};
						player setAmmo [primaryWeapon player, 1000000];
						(vehicle player) setVehicleAmmo 1;
						player setFatigue 0;
						uiSleep 0.3;
					};
				};
			}
			else
			{
				_log = 'Unlimited Ammo OFF';
				_log call FN_SHOW_LOG;
				
				terminate unlimAmmRun;
				unlimAmmRun = nil;
			};
		};
		fnc_CQC_A3noRecoil = {
			if(isNil 'noRecoilRun')then
			{
				_log = 'No Recoil ON';
				_log call FN_SHOW_LOG;
				
				noRecoilRun = [] spawn {
					while {true} do 
					{
						(vehicle player) setUnitRecoilCoefficient 0;
						player setUnitRecoilCoefficient 0;
						player setCustomAimCoef 0;
						player setFatigue 0;
						uiSleep 2;
					};
				};
			}
			else
			{
				_log = 'No Recoil OFF';
				_log call FN_SHOW_LOG;
				
				terminate noRecoilRun;
				noRecoilRun = nil;
				
				(vehicle player) setUnitRecoilCoefficient 1;
				player setUnitRecoilCoefficient 1;
			};
		};
		fnc_CQC_A3FF = {
			if(isNil 'A3FFrun')then
			{
				_log = 'FastFire ON';
				_log call FN_SHOW_LOG;
				
				A3FFrun = [] spawn {
					while {true} do 
					{
						_muzzle = currentMuzzle player;
						if(_muzzle isEqualType '')then{ (vehicle player) setWeaponReloadingTime [player, _muzzle, 0]; };
						uiSleep 0.1;
					};
				};
			}
			else
			{
				_log = 'FastFire OFF';
				_log call FN_SHOW_LOG;
				
				terminate A3FFrun;
				A3FFrun = nil;
			};
		};
		fnc_CQCHIDE = {
			if(!isNil'A3HIDErun')then{terminate A3HIDErun;};
			if(isObjectHidden player)then
			{
				[2,player,netId player,false] call fnc_AdminReq;
				
				_log = 'Stealth / Invisible OFF';
				_log call FN_SHOW_LOG;
			}
			else
			{
				A3HIDErun = [] spawn {
					while {true} do
					{
						if(!isObjectHidden player)then
						{
							[2,player,netId player,true] call fnc_AdminReq;
						};
						uiSleep 1;
					};
				};
				
				_log = 'Stealth / Invisible ON';
				_log call FN_SHOW_LOG;
			};
		};
		fnc_DisableAnnouncements = {
			if(isNil 'A3DANNrun')then{A3DANNrun = 0;};
			if(A3DANNrun==0)then
			{
				A3DANNrun=1;
				AdminAnnounceDisabled = true;
				
				_log = 'Disable Announces - ON';
				_log call FN_SHOW_LOG;
			}
			else
			{
				A3DANNrun=0;
				AdminAnnounceDisabled = nil;
				
				_log = 'Disable Announces - OFF';
				_log call FN_SHOW_LOG;
			};
		};
		fnc_FreeRoamCam = {
			if(isNil 'freeFlightCam')then
			{
				camDestroy freeFlightCam;
				freeFlightCam = nil;
				_getPos = player modelToWorld[0,3, 1.75];
				freeFlightCam = 'camera' camCreate _getPos;
				freeFlightCam setDir([_getPos, player] call BIS_fnc_dirTo);
				freeFlightCam camCommand 'MANUAL ON';
				freeFlightCam camCommand 'INERTIA OFF';
				freeFlightCam cameraEffect['INTERNAL', 'BACK'];
				showCinemaBorder false;
				_log = 'Right Click To Cancel!';
				_log call FN_SHOW_LOG;
			}
			else
			{
				camDestroy freeFlightCam;
				freeFlightCam = nil;
			};
		};
		fnc_BIS_FreeRoamCam = {
			[] spawn (uinamespace getvariable 'bis_fnc_camera');
		};
		fnc_deleteVeh_selected = {
			{player reveal _x;} foreach (player nearObjects 50);
			_target = _this select 0;
			if(typeName _target != 'OBJECT')then{_target = cursorTarget;};
			if(isNull _target)then{_target = cursorObject;};
			if(!isNull _target)then
			{
				_delete = (vehicle _target);
				
				if(isNil 'DELETE_TARGET')then{DELETE_TARGET = objNull;};
				if(str DELETE_TARGET != str _delete)exitWith
				{
					_type = typeOf _delete;
					_displayName = gettext (configFile >> 'CfgVehicles' >> _type >> 'displayName');
					_distance = round(cameraOn distance _delete);
					
					_log = format['DELETE:   %1 (%2)   distance %3m?  (press continue and delete again)',_displayName,_type,_distance];
					_log call FN_SHOW_LOG;
					DELETE_TARGET = _delete;
				};
				
				if(isNil 'ToDeleteArray')then{ToDeleteArray = [];};
				if(_delete in ToDeleteArray)then
				{
					_log = format['%1 - IN DELETE QUEUE',_delete];
					_log call FN_SHOW_LOG;
				}
				else
				{
					_netId = netId _delete;
					if(_netId isEqualTo '0:0')then
					{
						deleteVehicle _delete;
					}
					else
					{
						ToDeleteArray pushBack _delete;
						[-4,player,_delete] call fnc_AdminReq;
					};
					
					_log = format['Deleting %1 @%2..',typeOf _delete,mapGridPosition _delete];
					if(getPlayerUID _target != '')then
					{
						_log = format['Deleting %1(%2) vehicle: %3 @%4..',name _target,getPlayerUID _target,typeOf _delete,mapGridPosition _delete];
					};
					_log call FN_SHOW_LOG;
					_log call fnc_adminLog;
				};
			}
			else
			{
				DELETE_TARGET = objNull;
			};
		};
		fnc_flipVeh = {
			_target = _this select 0;
			if(typeName _target != 'OBJECT')then
			{
				_target = cursorTarget;
			};
			if((!isNull _target) && {alive _target} && {_target isKindOf 'Landvehicle' || _target isKindOf 'Air' || _target isKindOf 'Ship'})then
			{
				if(local _target)then
				{
					_pos = getPos _target;
					_pos set[2,(_pos select 2)+2];
					_target setPos _pos;
					_target setVectorUp [0,0,1];
				}
				else
				{
					[-3,player,_target] call fnc_AdminReq;
				};
				
				_log = format['Flipping %1 @%2..',typeOf _veh,mapGridPosition _target];
				_log call FN_SHOW_LOG;
			}
			else
			{
				_log = 'invalid target';
				if((!alive _target) && {_target isKindOf 'Landvehicle' || _target isKindOf 'Air' || _target isKindOf 'Ship'})then{_log = 'vehicle destroyed..';};
				_log call FN_SHOW_LOG;
			};
		};
		zeus_attack = {
			_target = _this select 0;
			_pos = screenToWorld [0.5,0.5];
			_log = format['Zeus @%1',mapGridPosition _pos];
			if(typeName _target != 'OBJECT')then
			{
				_target = cursorTarget;
			};
			if(!isNull _target)then
			{
				_pos = getPos _target;
				
				_log = format['Zeus %1 @%2',typeOf _target,mapGridPosition _pos];
				if(getPlayerUID _target != '')then
				{
					_log = format['Zeus %1(%2) @%3',name _target,getPlayerUID _target,mapGridPosition _pos];
				};
			};
			_log call FN_SHOW_LOG;
			_log call fnc_adminLog;
			[-1,player,_pos] call fnc_AdminReq;
		};
		fnc_Kill_selected = {
			_target = _this select 0;
			if(typeName _target != 'OBJECT')then
			{
				_target = cursorTarget;
			};
			if(!isNull _target)then
			{
				if(alive _target)then
				{
					_log = format['Killing %1 @%2',typeOf _target,mapGridPosition _target];
					if(getPlayerUID _target != '')then
					{
						_log = format['Killing %1(%2) @%3',name _target,getPlayerUID _target,mapGridPosition _target];
					};
					_log call FN_SHOW_LOG;
					_log call fnc_adminLog;
					[-2,player,_target] call fnc_AdminReq;
				}
				else
				{
					_log = 'target is dead';
					_log call FN_SHOW_LOG;
				};
			}
			else
			{
				_log = 'target does not exist';
				_log call FN_SHOW_LOG;
			};
		};
		fnc_createMinefield = {
			_target = _this select 0;
			if(typeName _target != 'OBJECT')then
			{
				_target = cursorTarget;
			};
			_pos = screenToWorld [0.5,0.5];
			_log = format['MineField (around target) @%1',mapGridPosition _pos];
			if(!isNull _target)then
			{
				_log = format['MineField (around target) %1 @%2',typeOf _target,mapGridPosition _target];
				if(isPlayer _target)then
				{
					_log = format['MineField (around target) %1(%2) @%3',name _target,getPlayerUID _target,mapGridPosition _target];
				};
				_pos = ATLtoASL (_target modelToWorldVisual [0,0,0]);
			};
			_log call FN_SHOW_LOG;
			_log call fnc_adminLog;
			
			_mineFields =
			[
				[_pos,5]
			];
			{
				_center = _x select 0;
				_radius = _x select 1;
				for '_i' from 0 to 360 step (90 / _radius)*1 do
				{
					_location = [(_center select 0) + ((cos _i) * _radius), (_center select 1) + ((sin _i) * _radius),0];
					_dir = ((_center select 0) - (_location select 0)) atan2 ((_center select 1) - (_location select 1));
					_object = createVehicle ['APERSTripMine_Wire_Ammo', _location, [], 0, 'CAN_COLLIDE'];
					_object setDir _dir;
				};
			} forEach _mineFields;
		};	
		fnc_Explode_selected = {
			_target = _this select 0;
			if(typeName _target != 'OBJECT')then
			{
				_target = cursorTarget;
			};
			_pos = screenToWorld [0.5,0.5];
			_log = format['Exploding @%1',mapGridPosition _pos];
			if(!isNull _target)then
			{
				_log = format['Exploding %1 @%2',typeOf _target,mapGridPosition _target];
				if(isPlayer _target)then
				{
					_log = format['Exploding %1(%2) @%3',name _target,getPlayerUID _target,mapGridPosition _target];
				};
				
				_eyepos = ASLToATL eyepos _target;if(surfaceIsWater _eyepos)then{_eyepos = eyepos _target;};
				_pos = getPosVisual _target;
				_pos set[2,_eyepos select 2];
			};
			_log call FN_SHOW_LOG;
			_log call fnc_adminLog;
			_bomb = 'HelicopterExploSmall' createVehicleLocal _pos;
		};
		fnc_Disconnect_selected = {
			_target = _this select 0;
			if(!isNull _target)then
			{
				_TUID = getPlayerUID _target;
				if(_TUID != '')then
				{
					[-664,player,_TUID] call fnc_AdminReq;	
					_log = format['Disconnect %1(%2)',name _target,_TUID];
					_log call FN_SHOW_LOG;
				};
			}
			else
			{
				_log = 'target does not exist';
				_log call FN_SHOW_LOG;
			};
		};
		fnc_Kick_selected = {
			_target = _this select 0;
			_opt = _this select 1;
			if(!isNull _target)then
			{
				_TUID = getPlayerUID _target;
				if(_TUID != '')then
				{
					_TNAME = name _target;
					[-665,player,_TUID,_TNAME] call fnc_AdminReq;
					if(_opt == 1)then
					{
						_msg = format['%1(%2) has been KICKED by an Admin!',_TNAME,_TUID];
						[7,player,toArray _msg] call fnc_AdminReq;
					};
					
					_log = format['Kicking %1(%2)',_TNAME,_TUID];
					_log call FN_SHOW_LOG;
				};
			}
			else
			{
				_log = 'target does not exist';
				_log call FN_SHOW_LOG;
			};
		};
		fnc_Ban_selected = {
			_target = _this select 0;
			_opt = _this select 1;
			if(!isNull _target)then
			{
				_TUID = getPlayerUID _target;
				if(_TUID != '')then
				{
					_TNAME = name _target;
					[-666,player,_TUID,_TNAME] call fnc_AdminReq;
					if(_opt == 1)then
					{
						_msg = format['%1(%2) has been BANNED by an Admin!',_TNAME,_TUID];
						[7,player,toArray _msg] call fnc_AdminReq;
					};
					
					_log = format['Ban %1(%2)',_TNAME,_TUID];
					_log call FN_SHOW_LOG;
				};
			}
			else
			{
				_log = 'target does not exist';
				_log call FN_SHOW_LOG;
			};
		};
		fnc_ATTACH_TO = {
			if(isNil'LastAttachedObject')then{LastAttachedObject=objNull;};
			if(!isNull LastAttachedObject)exitWith{detach LastAttachedObject;LastAttachedObject = nil;};
			
			_target = _this select 0;
			if(typeName _target != 'OBJECT')then
			{
				_target = cursorTarget;
			};	
			if(!isNull _target)then
			{
				_bbr = boundingBoxReal _target;
				_p1 = _bbr select 0;
				_p2 = _bbr select 1;
				_offset = 5;
				_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
				_maxLength = abs ((_p2 select 1) - (_p1 select 1));
				if(_maxWidth > _offset)then{_offset = _maxWidth;};
				if(_maxLength > _offset)then{_offset = _maxLength;};
				
				_bbr = boundingBoxReal vehicle player;
				_p1 = _bbr select 0;
				_p2 = _bbr select 1;
				_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
				
				[5,player,_target,_offset,_maxHeight] call fnc_AdminReq;
				LastAttachedObject = _target;
				
				_log = format['Attaching   %1   to player',typeOf _target];
				_log call FN_SHOW_LOG;
			}
			else
			{
				_log = 'target does not exist';
				_log call FN_SHOW_LOG;
			};
		};
		fnc_spawn_EVENT = {
			_target = _this select 0;
			_EVENT = _this select 1;
			
			if(!isNull _target)then
			{
				[4,player,_target,_EVENT] call fnc_AdminReq;
				
				_log = format['%1..',_EVENT];
				_log call FN_SHOW_LOG;
			}
			else
			{
				_log = 'target does not exist';
				_log call FN_SHOW_LOG;
			};
		};
		fnc_ReviveTarget = {
			_target = _this select 0;
			if(isNil'_target')then
			{
				_target = cursorTarget;
			};
			if(isNull _target)exitWith
			{
				_log = 'Can not revive: target does not exist!';
				_log call FN_SHOW_LOG;
			};
			if!(isPlayer _target)exitWith
			{
				_log = 'Can not revive: target not a player!';
				_log call FN_SHOW_LOG;
			};
			if((getPlayerUID _target) isEqualTo '')exitWith
			{
				_log = 'Can not revive: player left target body already..!';
				_log call FN_SHOW_LOG;
			};
			_log = format['Revived %1(%2) @%3',name _target,getPlayerUID _target,mapGridPosition _target];
			_log call FN_SHOW_LOG;


			closeDialog 0;
			[8,player,_target] call fnc_AdminReq;
		};
		fnc_HealTarget = {
			_target = _this select 0;
			if(typeName _target != 'OBJECT')then
			{
				_target = cursorTarget;
			};
			if(!isNull _target)then
			{
				_log = format['Healed %1 @%2',typeOf _target,mapGridPosition _target];
				if(getPlayerUID _target != '')then
				{
					_log = format['Healed %1(%2) @%3',name _target,getPlayerUID _target,mapGridPosition _target];
				};
				_log call FN_SHOW_LOG;
				[9,player,_target] call fnc_AdminReq;
			}
			else
			{
				_log = 'target does not exist';
				_log call FN_SHOW_LOG;
			};
		};
		fnc_RepairTarget = {
			_target = _this select 0;
			if(typeName _target != 'OBJECT')then
			{
				_target = cursorTarget;
			};
			if(!isNull _target)then
			{
				_log = format['%1 @%2 - Repaired & Refueled',typeOf _target,mapGridPosition _target];
				if(getPlayerUID _target != '')then
				{
					_log = format['%1 @%2 - Repaired & Refueled   @%3',name _target,getPlayerUID _target,mapGridPosition _target];
				};
				_log call FN_SHOW_LOG;
				
				[9,player,vehicle _target] call fnc_AdminReq;
				(vehicle _target) setFuel 1;
			}
			else
			{
				_log = 'target does not exist';
				_log call FN_SHOW_LOG;
			};
		};
		CQC_A3Heal = { 
			[9,player,cameraOn] call fnc_AdminReq;
			_log = format['Healed: %1',name cameraOn];
			_log call FN_SHOW_LOG;
		};
		CQC_A3RestoreNear = { 
			_done = [];
			{
				_crewandobject = [_x];
				_crewandobject append (crew _x);
				
				{
					_id = _done pushBackUnique _x;
					if(_id > -1)then
					{
						[9,player,_x] call fnc_AdminReq;
					};
				} forEach _crewandobject;
			} forEach (cameraOn nearEntities ['AllVehicles',15]);
			
			_log = 'Restored Near';
			_log call FN_SHOW_LOG;
		};
		CQC_A3Togglelock = {
			private ['_veh'];
			{player reveal _x;} foreach (position player nearObjects 50);
			_veh = vehicle player;
			if(vehicle player == player)then
			{
				_veh = cursorTarget;
			};
			if(isNull _veh)exitWith
			{
				_log = 'target does not exist';
				_log call FN_SHOW_LOG;
			};
			if(!alive _veh)exitWith
			{
				_log = 'target is destroyed ';
				_log call FN_SHOW_LOG;
			};
			if(_veh isKindOf 'AllVehicles')exitWith{
				if((player distance _veh < 12) || ((_veh == vehicle player) && (vehicle player != player)))then
				{
					_locked = locked _veh;
					if(_locked isEqualTo 2)then
					{
					
						_veh lock false;
						[10,player,_veh,false] call fnc_AdminReq;
						
						_log = format['unlocked - [%1]',typeOf _veh];
						_log call FN_SHOW_LOG;
						_log call fnc_adminLog;
					}
					else
					{ 
						_veh lock true;
						[10,player,_veh,true] call fnc_AdminReq;
				
						_log = format['locked - [%1]',typeOf _veh];
						_log call FN_SHOW_LOG;
						_log call fnc_adminLog;
					};
				};
			};
			
			{
				_animationPhase = cursorTarget animationPhase _x;
				cursorTarget animate [_x,if(_animationPhase > 0)then{0}else{1}];
			} forEach ['DoorRotation','DoorRotationLeft','DoorRotationRight','open_left','open_right','lock_cGarage','Open_Door','lock_Door','raise','Open_top','Open_bot'];
		};
		CQC_A3addAmmo = {
			if(isNil'SELECTED_TARGET_PLAYER')then{SELECTED_TARGET_PLAYER=player;};
			if(isNull SELECTED_TARGET_PLAYER)then{SELECTED_TARGET_PLAYER=player;};
			if(!alive SELECTED_TARGET_PLAYER)then{SELECTED_TARGET_PLAYER=player;};
			_log = '';
			_veh = vehicle SELECTED_TARGET_PLAYER;
			if(_veh == SELECTED_TARGET_PLAYER)then 
			{
				_muzzle = currentMuzzle SELECTED_TARGET_PLAYER;
				_magArray = getArray(configFile >> 'CfgWeapons' >> _muzzle >> 'magazines');
				if((((toLower _muzzle) find '_gl' != -1) && {((toLower _muzzle) find '_glock' == -1)})||((toLower _muzzle) find 'm203' != -1))then
				{
					_pewpews = [];
					{
						
						if(((toLower _x) select [0,4] in ['1rnd','3rnd'])||((toLower _x) find 'ugl_' != -1))then
						{
							_pewpews pushBack _x;
						};
					} forEach ALL_MAGS_TO_SEARCH_C;
					_magArray append _pewpews;
				};
				if(_magArray isEqualTo [])exitWith{};
				[] call fnc_FULLinit;
				fillmainstate = 6;
				disableSerialization;
				_ctrl = (findDisplay MAIN_DISPLAY_ID) displayCtrl RIGHT_CTRL_ID;
				lbclear _ctrl;
				_ctrl lbAdd '==== Magazines ====';
				{
					_ctrl lbAdd format['%1 (%2)',getText(configFile >> 'CfgMagazines' >> _x >> 'displayName'),_x];
					_x call fnc_addpic;
					_ctrl lbSetData [(lbsize _ctrl)-1,_x];
				} forEach _magArray;
				[] call fnc_colorizeMain;
				for '_i' from 0 to 10 do {_ctrl lbAdd '';};
			}
			else
			{
				_log = format['%1 added Ammo to %2',profileName,typeOf _veh];
				{_wep = _x;{_veh addmagazine _x;} forEach (getArray (configFile >> 'CfgWeapons' >> _wep >> 'magazines'));} forEach (weapons _veh);
			};
			_log call FN_SHOW_LOG;
			_log call fnc_adminLog;
		};
		CQC_A3Invulnerability = {
			fnc_A3_stopGod =
			{
				player removeAllEventhandlers 'HandleDamage';
				player removeAllEventhandlers 'Hit';
				player allowDamage true; 
				player addEventHandler ['HandleDamage',{}];  
			};
			if(isNil 'CQC_A3GodRun')then{CQC_A3GodRun = 0;};
			if(CQC_A3GodRun == 0)then
			{
				CQC_A3GodRun = 1;
				
				 
				CQC_A3InvulnerabilityLoop = [] spawn {
					while {1==1} do
					{
						if(CQC_A3GodRun == 0)exitWith{call fnc_A3_stopGod;};
						player setFatigue 0;
						player allowDamage false;
						player removeAllEventhandlers 'HandleDamage';
						player removeAllEventhandlers 'Hit';
						
						player addEventhandler ['HandleDamage', {false}];
						player addEventHandler ['Hit',{false}];
						 
						uiSleep 1;
					};
					call fnc_A3_stopGod;
				};
				_log = 'God Mode Enabled';
				_log call FN_SHOW_LOG;
			}
			else
			{
				CQC_A3GodRun = 0;
				call fnc_A3_stopGod;
				terminate CQC_A3InvulnerabilityLoop;
				call fnc_A3_stopGod;
				_log = 'God Mode Disabled';
				_log call FN_SHOW_LOG;
			};
		};
		fn_xgetname = {
			if(alive _x)then{name _x}else{_x getVariable['playerName','unknown']}
		};
		fnc_draw3dhandlerPLAYER1 = ""
			if(!isNull cameraOn)then
			{
				{
					if(isPlayer _x)then
					{
						_shown = [];
						if((crew (vehicle cameraOn)) isEqualTo (crew cameraOn))then{_shown = [vehicle cameraOn];};
						
						_veh = vehicle _x;
						_id = _shown pushBackUnique _veh;
						if!(_id isEqualTo -1)then
						{
							_distance = round(cameraOn distance _x);
							_fontSize = 0.024;
							_IconSize = 0.5;
							_alpha = 1;
							if(_veh isKindOf 'Man')then
							{
								_curwep = currentWeapon _x;
								_hp = round((damage _x - 1) * -100);
								_txt = format['unarmed - %1HP',_hp];
								
								_pos = _x modelToWorldVisual (_x selectionPosition 'head');
								
								if(_curwep != '')then
								{
									_txt = format[
										'%1 - [%2/%3] - %4HP',
										gettext(configFile >> 'CfgWeapons' >> _curwep >> 'displayName'),
										_x ammo _curwep,
										getNumber(configFile >> 'CfgMagazines' >> currentMagazine _x >> 'count'),
										_hp
									];
								};
								
								_txt = '';
								private _PUIDX = getPlayerUID _x;
								private _clr = _PUIDX call CQC_fnc_getPlayercolor;
								_dir = [_x,cameraOn] call BIS_fnc_relativeDirTo;
								drawIcon3D['',_clr,_pos,_IconSize,1.5,0,_txt,1,_fontSize,'PuristaBold'];
								
								_txt = format['%1 - %2m',call fn_xgetname,_distance];
								drawIcon3D['iconManMedic',_clr,_pos,_IconSize,_IconSize,if(_x isEqualTo cameraOn)then{_dir}else{_dir+180},_txt,1,_fontSize,'PuristaBold'];
							}
							else
							{
								_class = typeOf _veh;
								_speed = round(speed _veh*100)/100;
								_maxSpeed = getNumber(configFile >> 'CfgVehicles' >> _class >> 'maxSpeed');
								_typename = gettext(configFile >> 'CfgVehicles' >> _class >> 'displayName');
								
								_pos = _x modelToWorldVisual [0,0,0];
								_crew = crew _veh;
								_cnt = count _crew;
								_clr = [1,1,1,_alpha];
								drawIcon3D['\A3\ui_f\data\map\Markers\Military\dot_ca.paa',_clr,_pos,_IconSize,_IconSize,0,'',1];
								_pos = _x modelToWorldVisual [0,0,3];
								
								if(_cnt > 0)then
								{
									_num = _cnt * -1;
									{
										_height = _num + _forEachIndex;
										_role = assignedVehicleRole _x;
										if(_role isEqualTo [])then{_role = 'Passenger';}else{_role = _role select 0;};
										_txt = format['%1 - %2 %3HP',_role,call fn_xgetname,round((1-(damage _x))*100)];
										private _PUIDX = getPlayerUID _x;
										private _clr = _PUIDX call CQC_fnc_getPlayercolor;
										drawIcon3D['',_clr,_pos,.5,_height * 0.8,0,_txt,1,_fontSize,'PuristaBold'];
									} forEach _crew;
								};
								
								_fuel = fuel _veh;
								_fuelCapacity = getNumber(configFile >> 'CfgVehicles' >> _class >> 'fuelCapacity');
								_realFuel = _fuelCapacity * _fuel;
								
								_txt = format['%1 - %2L - %3/%4km/h - %5m',_typename,round(_realFuel*100)/100,_speed,_maxSpeed,_distance];
								drawIcon3D['',_clr,_pos,.5,0,0,_txt,1,_fontSize,'PuristaBold'];
							};
						};
					};
				} forEach ((cameraOn nearEntities[['Man', 'LandVehicle', 'Ship', 'Air'], 1800]) - [cameraOn, vehicle cameraOn]);
			};
		"";
		fnc_draw3dhandlerPLAYER2 = ""
			_shown = [];
			{
				if(!isNull _x)then
				{
					_veh = vehicle _x;
					if(_veh in _shown)exitWith{};
					_shown pushBack _veh;
					if(_veh == vehicle cameraOn)exitWith{};
					if(alive _x)then
					{
						_PUIDX = getPlayerUID _x;
						if(_PUIDX != '')then
						{
							_distance = round(cameraOn distance _x);
							if(_distance > 1600)exitWith{};
							_name = _x getVariable['playerName',name _x];
							_txt = format['%1 (%2m) %3HP',_name,_distance,floor((1-(damage _x))*100)]; 
							_crew = crew _veh;
							if(_x != _veh)then
							{ 
								_type = typeOf _veh; 
								_typename = gettext (configFile >> 'CfgVehicles' >> _type >> 'displayName');
								
								_names = '';
								{
									if(_forEachIndex == 0)then
									{
										_names = _names + (_x getVariable['playerName',name _x]);
									}
									else
									{
										if(alive _x)then{_names = _names + format[', %1',_x getVariable['playerName',name _x]];};
									};
								} forEach _crew;
								_txt = format['%1 - %2 (%3m)',_names,_typename,_distance];
							};
					 
							private _clr = _PUIDX call CQC_fnc_getPlayercolor;
							_txt = _txt+' '+(_PUIDX call CQC_fnc_getPlayerRank);

							private _colorHighlighted = getArray(missionConfigFile >> 'CQCColors' >> 'highlighted');
							if(SELECTED_TARGET_PLAYER in _crew)then{_clr = _colorHighlighted};
							
							_grpx = group _x;
							if(!isNull _grpx)then
							{
								_alive = {alive _x} count units _grpx;
								if(_alive > 1)then
								{
									_id=allGroups find _grpx;
									_txt = _txt + format[' GRP:%1 PLR:%2',_id,_alive];
								};
							};
							
							_pos = ASLToATL eyepos _x;
							if(surfaceIsWater _pos)then{_pos = eyepos _x;};
							drawIcon3D['',_clr,_pos,.1,.1,0,_txt,1,.035];
						};
					};
				};
			} forEach allPlayers;
		"";
		fnc_draw3dhandlerAI = ""
			if(!isNull cameraOn)then
			{
				_maxD = 300;
				ALLVEHICLES_OBJECTS_300m = cameraOn nearEntities ['Allvehicles',_maxD];
				{
					if(!isNull _x)then
					{
						if(alive _x)then
						{
							_PUIDX = getPlayerUID _x;
							if(_PUIDX == '')then
							{
								_distance = cameraOn distance _x;
								
								_veh = vehicle _x;
								_type = typeOf _veh;
								if((_x isKindOf 'Man')&&!(_x isKindOf 'Animal_Base_F'))then
								{
									_name = 'AI';
									_txt = format['%1 %2m',_name,round _distance];
									_txt = _txt+' '+str side _x;
									_clr = [1,1,1,0.7];
									
									_pos = ASLToATL eyepos _x;
									if(surfaceIsWater _pos)then{_pos = eyepos _x;};
									drawIcon3D['',_clr,_pos,.1,.1,0,_txt,1,.032];
								};
							};
						};
					};
				} forEach ALLVEHICLES_OBJECTS_300m;
			};
		"";
		fnc_draw3dhandlerDEAD = ""
			{
				if(!isNull _x)then
				{
					if!(getPlayerUID _x isEqualTo '')exitWith{};
					
					_distance = cameraOn distance _x;
					if(_distance < 500)then
					{
						_name = _x getVariable['playerName',''];
						if(_name != '')then
						{
							_clr = [1,1,1,0.7];
							_txt = format['%1 %2m',_name,round _distance];
							_pos = _x modelToWorld [0,0,1];
							drawIcon3D['',_clr,_pos,0,0,45,_txt,0,.032];
						};
					};
				};
			} forEach allDeadMen;
		"";  
		fnc_call_single_esps = {
			if(!isNil'CQCEspEHVAR')then{
				removeMissionEventHandler ['Draw3D',CQCEspEHVAR];
				CQCEspEHVAR=nil;
			};
			_string = '';
			if(!isNil 'fnc_infiESP_statePlayer1')then
			{
				_string = _string + fnc_draw3dhandlerPLAYER1;
			};
			if(!isNil 'fnc_infiESP_statePlayer2')then
			{
				_string = _string + fnc_draw3dhandlerPLAYER2;
			};
			if(!isNil 'fnc_infiESP_stateAI')then
			{
				_string = _string + fnc_draw3dhandlerAI;
			};
			if(!isNil 'fnc_infiESP_stateDEAD')then
			{
				_string = _string + fnc_draw3dhandlerDEAD;
			};  
			if(_string != '')then
			{
				_string = ('if(!isNull findDisplay 49)exitWith{true};'+_string);
				CQCEspEHVAR = addMissionEventHandler ['Draw3D',_string];
			};
		};
		CQC_fnc_infiESP_player1 = {
			if(isNil 'fnc_infiESP_statePlayer1')then{
				fnc_infiESP_statePlayer1 = 1;_log = 'CQC Player ESP 1 - ON (ESP DECREASES FPS A LOT!)';_log call FN_SHOW_LOG;
			} else {
				fnc_infiESP_statePlayer1 = nil;_log = 'CQC Player ESP 1 - OFF';_log call FN_SHOW_LOG;
			};
			call fnc_call_single_esps;
		};
		CQC_fnc_infiESP_player2 = {
			if(isNil 'fnc_infiESP_statePlayer2')then{
				fnc_infiESP_statePlayer2 = 1;_log = 'CQC Player ESP 2 - ON (ESP DECREASES FPS A LOT!)';_log call FN_SHOW_LOG;
			} else {
				fnc_infiESP_statePlayer2 = nil;_log = 'CQC Player ESP 2 - OFF';_log call FN_SHOW_LOG;
			};
			call fnc_call_single_esps;
		};
		CQC_fnc_infiESP_AI = {
			if(isNil 'fnc_infiESP_stateAI')then{
				fnc_infiESP_stateAI = 1;_log = 'CQC AI ESP - ON (ESP DECREASES FPS A LOT!)';_log call FN_SHOW_LOG;
			} else {
				fnc_infiESP_stateAI = nil;_log = 'CQC AI ESP - OFF';_log call FN_SHOW_LOG;
			};
			call fnc_call_single_esps;
		};
		CQC_fnc_infiESP_DEAD = {
			if(isNil 'fnc_infiESP_stateDEAD')then{
				fnc_infiESP_stateDEAD = 1;_log = 'CQC DEAD ESP - ON (ESP DECREASES FPS A LOT!)';_log call FN_SHOW_LOG;
			} else {
				fnc_infiESP_stateDEAD = nil;_log = 'CQC DEAD ESP - OFF';_log call FN_SHOW_LOG;
			};
			call fnc_call_single_esps;
		};   
		fnc_draw_MapIcons = {
			if!(visibleMap || dialog)exitWith{};
			private['_ctrl'];
			_ctrl =  _this select 0;
			_iscale = ((1 - ctrlMapScale _ctrl) max .2) * 28;
			_icon = '';
			  
			if(visibleMap)then
			{
				if(mapiconsshowplayer)then
				{
					_shown = [];
					{
						if(!isNull _x)then
						{
							_veh = vehicle _x;
							if(_veh in _shown)exitWith{};
							_shown pushBack _veh;
							_PUIDX = getPlayerUID _x;
							if(_PUIDX != '')then
							{
								_name = _x getVariable['playerName',name _x];
								_type = typeOf _veh;
								_dist = round(_veh distance player);
								_txt = format['%1 (%2m) (DEAD, but still watching)',_name,_dist];
								if(alive _x)then
								{
									if(_x == _veh)then
									{
										_txt = format['%1 (%2m)',_name,_dist];
									}
									else
									{
										_names = '';
										{
											if(_forEachIndex == 0)then
											{
												_names = _names + format['%1',_x getVariable['playerName',name _x]];
											}
											else
											{
												_names = _names + format[', %1',_x getVariable['playerName',name _x]];
											};
										} forEach (crew _veh);
										_typename = gettext (configFile >> 'CfgVehicles' >> _type >> 'displayName');
										_txt = format['%1 - %2 (%3m)',_names,_typename,_dist];
									};
								};
								
								_clr = _PUIDX call CQC_fnc_getPlayercolor;
								if(((_PUIDX in CQC_ADMINS)&&!(_PUIDX in CQC_DEVS))||((_PUIDX in CQC_DEVS)&&("+_adminMenuUID+" in CQC_DEVS))||(_PUIDX == "+_adminMenuUID+"))then{_clr = [0,1,0,1];};
								if(SELECTED_TARGET_PLAYER in (crew _veh))then{_clr = [1,0.7,0.15,1];};
								
								_icon = getText(configFile >> 'CfgVehicles' >> _type >> 'icon');
								_txt = _txt+' '+str side _x;
								
								_grpx = group _x;
								if(!isNull _grpx)then
								{
									_alive = {alive _x} count units _grpx;
									if(_alive > 1)then
									{
										_id=allGroups find _grpx;
										_txt = _txt + format[' GRP:%1 PLR:%2',_id,_alive];
									};
								};
								
								_ctrl drawIcon [_icon, _clr, getPosASL _veh, _iscale, _iscale, getDir _veh,_txt];
							};
						};
					} forEach allPlayers;
				};
				
				if(mapiconsshowvehicles||mapiconsshowai)then
				{
					_allvehicles = [0,0,0] nearEntities ['Allvehicles',1000000];
					{
						if(!isNull _x)then
						{
							_PUIDX = getPlayerUID _x;
							if(_PUIDX == '')then
							{
								_veh = vehicle _x;
								_type = typeOf _veh;
								if(mapiconsshowvehicles)then
								{
									if!(_x isKindOf 'Man')then
									{
										_icon = getText(configFile >> 'CfgVehicles' >> _type >> 'icon');
										_clr = _PUIDX call CQC_fnc_getPlayercolor;
										_ctrl drawIcon [_icon, _clr, getPosASL _x, _iscale, _iscale, getDir _x];
									};
								};
								if(mapiconsshowai)then
								{
									if((_x isKindOf 'Man') && !(_x isKindOf 'Animal_Base_F'))then
									{
										_txt = 'AI'; 
										_icon = getText(configFile >> 'CfgVehicles' >> _type >> 'icon');
										_ctrl drawIcon [_icon, [1,1,1,1], getPosASL _x, _iscale, _iscale, getDir _x,_txt];
									};
								};
							};
						};
					} forEach _allvehicles;
				};
				if(mapiconsshowdeadvehicles)then
				{
					{
						if((_x isKindOf 'Air')||(_x isKindOf 'Landvehicle'))then
						{
							_veh = vehicle _x;
							_type = typeOf _veh;
							_clr = [1,1,1,1];
							if(_x isEqualTo SELECTED_TARGET_PLAYER)then{_clr = [1,0.7,0.15,1];};
							_icon = getText(configFile >> 'CfgVehicles' >> _type >> 'icon');
							_ctrl drawIcon [_icon, _clr, getPosASL _x, _iscale, _iscale, getDir _x];
						};
					} forEach allDead;
				};
				if(mapiconsshowdeadplayer)then
				{
					{
						if(!isNull _x)then
						{
							_name = _x getVariable['playerName',''];
							if(_name != '')then
							{
								if(getPlayerUID _x != '')then
								{
									_name = format['%1 (DEAD, but still watching)',_name];
								};
								_veh = vehicle _x;
								_type = typeOf _veh;
								_clr = [1,1,1,1];
								_dist = round(_veh distance player);
								_txt = format['%1 %2m',_name,_dist];
								
								_icon = getText(configFile >> 'CfgVehicles' >> _type >> 'icon');
								_txt = _txt+' '+str side _x;
								_ctrl drawIcon [_icon, _clr, getPosASL _veh, _iscale, _iscale, getDir _veh,_txt];
							};
						};
					} forEach allDeadMen;
				};
			};
		};
		fnc_removeButtons = {
			{ctrlDelete (_display displayCtrl _x);} forEach [1084,1085,1086,1087,1088];
		};
		fnc_addButtons = {
			_xpos = 0.5;
			_y = safeZoneY+0.06;
			
			_ctrl1 = [_display,'RscButton',1084] call fnc_createctrl;
			_ctrl1 ctrlSetPosition [_xpos,_y,0.3,0.05];
			
			_y = _y + 0.0495;
			_ctrl2 = [_display,'RscButton',1085] call fnc_createctrl;
			_ctrl2 ctrlSetPosition [_xpos,_y,0.3,0.05];
			
			_y = _y + 0.0495;
			_ctrl3 = [_display,'RscButton',1086] call fnc_createctrl;
			_ctrl3 ctrlSetPosition [_xpos,_y,0.3,0.05];
			
			_y = _y + 0.0495;
			_ctrl4 = [_display,'RscButton',1087] call fnc_createctrl;
			_ctrl4 ctrlSetPosition [_xpos,_y,0.3,0.05];
			
			_y = _y + 0.0495;
			_ctrl5 = [_display,'RscButton',1088] call fnc_createctrl;
			_ctrl5 ctrlSetPosition [_xpos,_y,0.3,0.05];
		};
		CQC_A3MAPICONS = {
			if(isNil 'MAP_BUTTON_THREAD')then
			{
				_log = 'MapIcons Enabled';
				_log call FN_SHOW_LOG;
				
				if(isNil'mapiconsshowplayer')then{mapiconsshowplayer=true;};
				if(isNil'mapiconsshowvehicles')then{mapiconsshowvehicles=false;};
				if(isNil'mapiconsshowdeadplayer')then{mapiconsshowdeadplayer=false;};
				if(isNil'mapiconsshowdeadvehicles')then{mapiconsshowdeadvehicles=false;};
				if(isNil'mapiconsshowai')then{mapiconsshowai=false;};
				
				MAP_BUTTON_THREAD = [] spawn {
					disableSerialization;
					private['_display','_ctrl1','_ctrl2','_ctrl3','_ctrl4','_ctrl5','_button','_state','_text','_function','_color'];
					_display = findDisplay 12;
					while{true}do
					{
						if(visibleMap)then
						{
							if(isNil'EventHandlerDrawAdded')then
							{
								call fnc_removeButtons;
								call fnc_addButtons;
								EventHandlerDrawAdded = (uiNamespace getVariable 'A3MAPICONS_mainMap') ctrlAddEventHandler['Draw','_this call fnc_draw_MapIcons'];
							};
							
							{
								_button = _x select 0;
								_state = _x select 1;
								_text = if(_state)then{_x select 2}else{_x select 3};
								_function = if(_state)then{_x select 4}else{_x select 5};
								_color = if(_state)then{[0.56,0.04,0.04,1]}else{[0,1,0,1]};
								
								_button ctrlSetText _text;
								_button ctrlSetTextColor _color;
								_button ctrlRemoveAllEventHandlers 'ButtonDown';
								_button ctrlAddEventHandler ['ButtonDown',_function];
								_button ctrlCommit 0;
							} forEach
							[
								[_ctrl1,mapiconsshowplayer,'Hide Player','Show Player',{mapiconsshowplayer = false;},{mapiconsshowplayer = true;}],
								[_ctrl2,mapiconsshowdeadplayer,'Hide DeadPlayer','Show DeadPlayer',{mapiconsshowdeadplayer = false;},{mapiconsshowdeadplayer = true;}],
								[_ctrl3,mapiconsshowvehicles,'Hide Vehicles','Show Vehicles',{mapiconsshowvehicles = false;},{mapiconsshowvehicles = true;}],
								[_ctrl4,mapiconsshowdeadvehicles,'Hide DeadVehicles','Show DeadVehicles',{mapiconsshowdeadvehicles = false;},{mapiconsshowdeadvehicles = true;}],
								[_ctrl5,mapiconsshowai,'Hide AI','Show AI',{mapiconsshowai = false;},{mapiconsshowai = true;}]
							];
						}
						else
						{
							if(!isNil'EventHandlerDrawAdded')then
							{
								call fnc_removeButtons;
								(uiNamespace getVariable 'A3MAPICONS_mainMap') ctrlRemoveEventHandler ['Draw',EventHandlerDrawAdded];EventHandlerDrawAdded=nil;
							};
						};
						uiSleep 0.3;
					};
				};
			} 
			else 
			{
				_log = 'MapIcons Disabled';
				_log call FN_SHOW_LOG;
				
				terminate MAP_BUTTON_THREAD;MAP_BUTTON_THREAD=nil;
				if(!isNil'EventHandlerDrawAdded')then{(uiNamespace getVariable 'A3MAPICONS_mainMap') ctrlRemoveEventHandler ['Draw',EventHandlerDrawAdded];EventHandlerDrawAdded=nil;};
				{ctrlDelete ((findDisplay 12) displayCtrl _x);} forEach [1084,1085,1086,1087,1088];
			};
		};
		adminVehicleMarker = {
			adminVehicleMarkers =
			{
				while {markadVehicleMarker == 1} do
				{
					{
						_typename = gettext (configFile >> 'CfgVehicles' >> typeOf _x >> 'displayName');
						_xPos = getPos _x;
						
						_cm = ('adminVehicleMarkers' + (str _forEachIndex));
						_pos = getMarkerPos _cm;
						if((_pos select 0 != _xPos select 0) || (_pos select 1 != _xPos select 1))then
						{
							deleteMarkerLocal _cm;
							_vm = createMarkerLocal [_cm,_xPos];
							_vm setMarkerDirLocal (getDir _x);
							_vm setMarkerTypeLocal 'mil_start';
							_vm setMarkerColorLocal 'ColorBlue';
							_vm setMarkerTextLocal format['%1',_typename];
						};
						if(markadVehicleMarker == 0)exitWith{};
					} forEach ([0,0,0] nearEntities[['LandVehicle','Ship','Air','Tank'],1000000]);
					if(markadVehicleMarker == 0)exitWith{};
					uiSleep 1;
					if(markadVehicleMarker == 0)exitWith{};
				};
				for '_i' from 0 to 99999 do {deleteMarkerLocal ('adminVehicleMarkers' + (str _i));};
			};
			if(isNil 'markadVehicleMarker')then{markadVehicleMarker = 0;};
			if(markadVehicleMarker == 0)then
			{
				_log = '2D Map VehicleMarkerMarker Enabled';
				_log call FN_SHOW_LOG;
				
				markadVehicleMarker = 1;
				[] spawn adminVehicleMarkers;
			}
			else
			{
				_log = '2D Map VehicleMarkerMarker Disabled';
				_log call FN_SHOW_LOG;
				
				markadVehicleMarker = 0;
				for '_i' from 0 to 99999 do {deleteMarkerLocal ('adminVehicleMarkers' + (str _i));};
			};
		}; 
		adminDeadPlayer = {
			adminDeadPlayers =
			{
				while {markadDeadPlayer == 1} do
				{
					ADMIN_DeadPlayer_LIST = [] + allDeadMen;
					if(markadDeadPlayer == 0)exitWith{};
					for '_i' from 0 to (count ADMIN_DeadPlayer_LIST)-1 do
					{
						if(markadDeadPlayer == 0)exitWith{};
						
						deleteMarkerLocal ('adminDeadPlayers' + (str _i));
						_c = ADMIN_DeadPlayer_LIST select _i;
						if(!isNull _c)then
						{
							_txt = _c getVariable['playerName','DEAD'];
							if(_txt != 'DEAD')then
							{
								_txt = format['%1 (DEAD)',_txt];
								_vm = createMarkerLocal [('adminDeadPlayers' + (str _i)), getPos _c];
								_vm setMarkerTypeLocal 'waypoint';
								_vm setMarkerColorLocal 'ColorBlack';
								_vm setMarkerTextLocal _txt;
							};
						};
						
						if(markadDeadPlayer == 0)exitWith{};
					};
					if(markadDeadPlayer == 0)exitWith{};
					uiSleep 20;
					if(markadDeadPlayer == 0)exitWith{};
				};
				for '_i' from 0 to 99999 do {deleteMarkerLocal ('adminDeadPlayers' + (str _i));};
			};
			if(isNil 'markadDeadPlayer')then{markadDeadPlayer = 0;};
			if(markadDeadPlayer == 0)then
			{
				_log = '2D Map DeadPlayerMarker Enabled';
				_log call FN_SHOW_LOG;
				
				markadDeadPlayer = 1;
				[] spawn adminDeadPlayers;
			}
			else
			{
				_log = '2D Map DeadPlayerMarker Disabled';
				_log call FN_SHOW_LOG;
				
				markadDeadPlayer = 0;
				for '_i' from 0 to 99999 do {deleteMarkerLocal ('adminDeadPlayers' + (str _i));};
			};
		};
		fnc_CQC_vehboostKeydown = {
			_key = _this select 1;
			_shiftState = _this select 2;
			_ctrlState = _this select 3;
			_altState = _this select 4;
			
			_obj = cameraOn;
			if(!local _obj)exitWith{};
			if(_obj == player)exitWith{};
			
			
			if(_key isEqualTo 0x39)exitWith
			{
				_vel = velocity _obj;
				_obj setVelocity [
					(_vel select 0) * 0.96, 
					(_vel select 1) * 0.96, 
					(_vel select 2) * 0.98
				];
				false
			};
			
			_maxSpeed = getNumber(configFile >> 'CfgVehicles' >> typeOf _obj >> 'maxSpeed');
			_speed = speed _obj;
			_absspeed = abs _speed;
			if(((_absspeed > _maxSpeed * 2.5)&&(_obj isKindOf 'Air'))||((_absspeed > _maxSpeed * 1.1)&&!(_obj isKindOf 'Air')))exitWith{false};
			
			if(isEngineOn _obj)then 
			{
				if(_shiftState)exitWith
				{
					if(visibleMap)exitWith{false};
					if(_key isEqualTo 0x05)exitWith{false};
					_vel = velocity _obj;
					if(_speed < 30)then
					{
						_dir = direction _obj;
						_obj setVelocity [
							(_vel select 0) + (sin _dir * 1.02), 
							(_vel select 1) + (cos _dir * 1.02), 
							(_vel select 2)
						];
					}
					else
					{
						_obj setVelocity [
							(_vel select 0) * 1.015, 
							(_vel select 1) * 1.015, 
							(_vel select 2)
						];
					};
				};
			};
			false
		};
		CQC_VehicleBoost = {
			if(isNil 'CQC_vehboost_keybind')then
			{
				CQC_vehboost_keybind = (findDisplay 46) displayAddEventHandler ['KeyDown', '_this call fnc_CQC_vehboostKeydown'];
				'<CQC AntiHack> Vehboost Keybinds added: SHIFT FOR SPEED - SPACEBAR TO BREAK' call FN_SHOW_LOG;
			}
			else
			{
				(findDisplay 46) displayRemoveEventHandler ['KeyDown',CQC_vehboost_keybind];
				CQC_vehboost_keybind = nil;
				'<CQC AntiHack> Vehboost Keybinds removed' call FN_SHOW_LOG;
			};
		};
		CQC_FlyUp = {
			_obj = cameraOn;
			if(!local _obj)exitWith{};
			if((_shift)||(_obj isKindOf 'Air'))exitWith
			{
				_vel = velocity _obj;
				if(_obj isKindOf 'Air')then 
				{
					_obj setVelocity [(_vel select 0),(_vel select 1),30];
				}
				else
				{
					_obj setVelocity [(_vel select 0),(_vel select 1),8];
				};
			};
			if(_ctrl)exitWith
			{
				_obj setPos (_obj modelToWorld [0,0,3]);
			};
		};
		CQC_shortTP = {
			_veh = vehicle player;
			if(_veh isKindOf 'Air')exitWith{
				_vel = velocity _veh;
				_posZ = (getPos _veh) select 2;
				if(_posZ > 6)then 
				{
					_veh setVelocity [(_vel select 0),(_vel select 1),-20];
				};
				if(_posZ < 10)then 
				{
					_veh setVelocity [0,0,-3];
				};
				if((_posZ < 6) and (_posZ > 4))then 
				{
					_veh setVectorUp [0,0,1];
				};
			};
			_distance = 1;
			_object = player;
			_dir = getdir _object;
			_pos = getPos _object;
			_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),(_pos select 2)];
			_object setPos _pos;
		};
		CQC_Eject_Join = {
			EjectJoinTarget = nil;
			NameEjectJoinTarget = nil;
			go_in_nearestvehicle_callmevar = 
			{
				_vehicleair = (nearestObject[vehicle player,'AIR']);
				_vehicleland = (nearestObject[vehicle player,'Landvehicle']);
				if((player distance _vehicleair) > (player distance _vehicleland))then 
				{
					player action ['getInDriver', _vehicleland];
				}
				else
				{
					player action ['getInDriver', _vehicleair];
				};
			};
			EjectJoinTarget = cursorTarget;
			NameEjectJoinTarget = gettext (configFile >> 'CfgVehicles' >> (typeof EjectJoinTarget) >> 'displayName');
			if(count(crew EjectJoinTarget)>0)then
			{
				EjectJoinTarget action ['eject',EjectJoinTarget];
				EjectJoinTarget action ['getout',EjectJoinTarget];
				_log = format['%1 Ejected',NameEjectJoinTarget];
				_log call FN_SHOW_LOG;
			}
			else
			{
				_log = format['Get in %1 ?',NameEjectJoinTarget];
				_log call FN_SHOW_LOG;
				
			_arma_bug = {
				JoinOrNotJoinIsTheQuestion = 
				[
					['',true],
					['Get in ?', [-1], '', -5, [['expression', '']], '1', '0'],
					['YES', [2], '', -5, [['expression', 'player action [''getInDriver'', EjectJoinTarget];']], '1', '1'],
					['Nearest', [4], '', -5, [['expression', 'call go_in_nearestvehicle_callmevar;']], '1', '1']
				];
				showCommandingMenu '#USER:JoinOrNotJoinIsTheQuestion';
			};
				player action ['getInDriver', EjectJoinTarget];
				_log = format['%1 NO ONE TO EJECT',NameEjectJoinTarget];
				_log call FN_SHOW_LOG;
			};
		};
		CQC_Tpdirection = {
			_distance = 10;
			_veh = vehicle player;
			if(local _veh)then
			{
				_dir = getdir _veh;
				if(surfaceIsWater position _veh)then
				{
					_pos = getPosASL _veh;
					_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),(_pos select 2)];
					_veh setPosASL _pos;
				}
				else
				{
					_pos = getPosATL _veh;
					_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),(_pos select 2)];
					_veh setPosATL _pos;
				};
			};
		};
		fnc_startEMP = {
			CALLED_EMP = true;
			_log = 'Click on the Map position for the EMP!';
			_log call FN_SHOW_LOG;
		};
		fnc_callEMP = {
			_position = _this;
			
			_doGlobal = ""
				_objects =
				[
					'Lamps_Base_F','Land_LampAirport_F','Land_LampSolar_F','Land_LampStreet_F','Land_LampStreet_small_F','PowerLines_base_F',
					'Land_LampDecor_F','Land_LampHalogen_F','Land_LampHarbour_F','Land_LampShabby_F','Land_PowerPoleWooden_L_F','Land_NavigLight',
					'Land_runway_edgelight','Land_runway_edgelight_blue_F','Land_Flush_Light_green_F','Land_Flush_Light_red_F','Land_Flush_Light_yellow_F',
					'Land_Runway_PAPI','Land_Runway_PAPI_2','Land_Runway_PAPI_3','Land_Runway_PAPI_4','Land_fs_roof_F','Land_fs_sign_F'
				];
				{
					_x say3D 'electricity_loop';
					_x setHit ['light_1_hitpoint',0.97];
					_x setHit ['light_2_hitpoint',0.97];
					_x setHit ['light_3_hitpoint',0.97];
					_x setHit ['light_4_hitpoint',0.97];
				} forEach nearestObjects [""+str _position+"",_objects,250];
			"";
			[_doGlobal] call admin_d0;
			
			_log = format['Emp called @%1!',mapGridPosition _position];
			_log call FN_SHOW_LOG;
		};
		fnc_RscDisplayDebugPublic = {
			disableSerialization;
			if(isNull findDisplay 316000)then{createdialog 'RscDisplayDebugPublic';};
			waitUntil {!isNull findDisplay 316000};
			_display = findDisplay 316000;
			
			{
				if!(str _x in ['Control #1','Control #13284','Control #13288'])then
				{
					_x ctrlRemoveAllEventHandlers 'ButtonDown';
					_x ctrlRemoveAllEventHandlers 'ButtonClick';
					_x ctrlRemoveAllEventHandlers 'MouseButtonClick';
					_x ctrlRemoveAllEventHandlers 'MouseButtonDown';
				};
			} forEach (allControls _display);
			
			_testRscListBox1 = _display ctrlCreate ['RscListBox',122000];
			_testRscListBox1 ctrlSetposition [0.83,0,0.5,1];
			_testRscListBox1 ctrlEnable true;
			_testRscListBox1 ctrlCommit 0;
			lbClear _testRscListBox1;
			_testRscListBox1 lbadd format['Player connected: %1',{getPlayerUID _x != ''} count allPlayers];
			_names = [];
			{
				if(getPlayerUID _x != '')then
				{
					if!(name _x in _names)then{_names pushBack (name _x);};
				};
			} forEach (units (group player));
			{
				if(getPlayerUID _x != '')then
				{
					if!(name _x in _names)then{_names pushBack (name _x);};
				};
			} forEach allPlayers;
			{
				_testRscListBox1 lbadd _x;
			} forEach _names;
			
			_watchField1 = _display displayCtrl 12285;
			_watchField2 = _display displayCtrl 12287;
			_watchField3 = _display displayCtrl 12289;		
			_watchField4 = _display displayCtrl 12291;
			
			
			_pos = [0.83,1,0.5,0.05];
			_buttonXPos = _pos select 0;
			_buttonYPos = _pos select 1;
			_buttonwidth = _pos select 2;
			_buttonheight = _pos select 3;
			
			_ctrl = [_display,'RSCEdit',55291] call fnc_createctrl;
			_ctrl ctrlSetText '';
			_ctrl ctrlSetPosition [_buttonXPos,_buttonYPos,_buttonwidth,_buttonheight];
			_ctrl ctrlCommit 0;
			
			_ctrl = [_display,'RSCButton',55292] call fnc_createctrl;
			_ctrl ctrlSetText 'SET';
			_ctrl ctrlSetPosition [_buttonXPos,_buttonYPos + _buttonheight,_buttonwidth,_buttonheight];
			_ctrl ctrlCommit 0;
			_ctrl ctrlSetEventHandler['ButtonClick','
				((findDisplay 316000) displayCtrl 12284) ctrlSetText str(call compile (ctrlText((findDisplay 316000) displayCtrl 55291)));
			'];
			
			
			waitUntil
			{
				_title = _display displayCtrl 11884;
				_title ctrlSetText 'Debug & Admin Console - modified by CQC AntiHack';
				
				_titleBox = _display displayCtrl 11892;
				_titleBox ctrlSetText 'ENTER: CODE TO EXECUTE - BE MESSAGE - KICK/BAN REASON';
				
				_btnSpectator = _display displayCtrl 13287;
				_btnSpectator ctrlEnable true;
				_btnSpectator ctrlShow true;
				_btnSpectator ctrlSetText 'clear';
				_btnSpectator buttonSetAction '
					[''SYSTEMLOG'',(ctrlText ((findDisplay 316000) displayCtrl 12284))] call CQC_fnc_ahLog; 
					((findDisplay 316000) displayCtrl 12284) ctrlSetText '''';
				';
				
				_btnCamera = _display displayCtrl 13288;
				_btnCamera ctrlEnable true;
			
				_btnFunctions = _display displayCtrl 13289;
				_btnFunctions ctrlSetText 'lock';
				_btnFunctions buttonSetAction '
					[-662,player,1] call fnc_AdminReq;
				';
				
				_btnConfig = _display displayCtrl 13290;
				_btnConfig ctrlSetText 'unlock';
				_btnConfig buttonSetAction '
					[-662,player,2] call fnc_AdminReq;
				';
				
				_btnAnimations = _display displayCtrl 13291;
				_btnAnimations ctrlSetText 'ban';
				_btnAnimations buttonSetAction '
					_lbtxt = lbtext[122000,(lbCurSel 122000)];
					{
						_xUID = getPlayerUID _x;
						if(_xUID != '''')then
						{
							if(name _x == _lbtxt)exitWith
							{
								_reason = (ctrlText ((findDisplay 316000) displayCtrl 12284));
								if(_reason == '''')then{_reason=''Admin Ban'';};
								_input = [3,_xUID,toArray _lbtxt,toArray _reason];
								[-662,player,_input] call fnc_AdminReq;
							};
						};
					} forEach allPlayers;
				';
				
				_btnGuiEditor = _display displayCtrl 13292;
				_btnGuiEditor ctrlSetText 'kick';
				_btnGuiEditor buttonSetAction '
					_lbtxt = lbtext[122000,(lbCurSel 122000)];
					{
						_xUID = getPlayerUID _x;
						if(_xUID != '''')then
						{
							if(name _x == _lbtxt)exitWith
							{
								_reason = (ctrlText ((findDisplay 316000) displayCtrl 12284));
								if(_reason == '''')then{_reason=''Admin Kick'';};
								_input = [4,_xUID,toArray _lbtxt,toArray _reason];
								[-662,player,_input] call fnc_AdminReq;
							};
						};
					} forEach allPlayers;
				';
				_btnSE = _display displayCtrl 13286;
				_btnSE buttonSetAction '[ctrlText ((findDisplay 316000) displayCtrl 12284)] call admin_d0_server;';
				_btnGE = _display displayCtrl 13285;
				_btnGE buttonSetAction '[ctrlText ((findDisplay 316000) displayCtrl 12284)] call admin_d0;';
				isNull findDisplay 316000
			};
		}; 
		"+ ([CQC_fnc_debugConsole] call CQC_fnc_tooExpression) + " 
		[] spawn {
			waituntil { !(isNull findDisplay 46) }; 
			if(isNil 'OPEN_ADMIN_MENU_KEY')then{OPEN_ADMIN_MENU_KEY = 0x3B;};
			
			fnc_redoControlsMoveObj = {
				fnc_show_LOCAL_OBJinfo = {
					_pos = getPos LOCAL_OBJ;
					_dir = getDir LOCAL_OBJ;
					_type = typeOf LOCAL_OBJ;
					_log = format['%1: [%2,%3]',_type,_dir,_pos];
					['SYSTEMLOG',_log] call CQC_fnc_ahLog;
					['<t size=''0.4'' align=''left'' font=''TahomaB''>'+_log+'</t>',safezoneX,0.98 * safezoneH + safezoneY,15,0,0,1339] spawn bis_fnc_dynamicText;
				};
				fnc_infiMoveObj = {
					if(isNil 'LOCAL_OBJ')then{LOCAL_OBJ = objNull;};
					if(isNull LOCAL_OBJ)exitWith{};
					switch (_key) do {
						case 0xC8: {
							_cpos = getPos LOCAL_OBJ;
							_cpos = [_cpos select 0,_cpos select 1,(_cpos select 2)+0.5];
							LOCAL_OBJ setPos _cpos;
						};
						case 0xD0: {
							_cpos = getPos LOCAL_OBJ;
							_cpos = [_cpos select 0,_cpos select 1,(_cpos select 2)-0.5];
							LOCAL_OBJ setPos _cpos;
						};
						case 0xCB: {
							_cdir = getDir LOCAL_OBJ;
							LOCAL_OBJ setDir (_cdir-3);
						};
						case 0xCD: {
							_cdir = getDir LOCAL_OBJ;
							LOCAL_OBJ setDir (_cdir+3);
						};
						case 0x10: {
							_cdir = getDir LOCAL_OBJ;
							LOCAL_OBJ setDir (_cdir-3);
						};
						case 0x12: {
							_cdir = getDir LOCAL_OBJ;
							LOCAL_OBJ setDir (_cdir+3);
						};
						case 0x0F: {
							_cpos = LOCAL_OBJ modelToWorld [0,0,0];
							LOCAL_OBJ setPos [_cpos select 0,_cpos select 1,0];
						};
						case 0x39: {
							_pos = getPos LOCAL_OBJ;
							_dir = getDir LOCAL_OBJ;
							_type = typeOf LOCAL_OBJ;
							
							['
								_vehClass = '+str _type+';
								_position = '+str _pos+';
								_dir = '+str _dir+';
								_vehObj = _vehClass createVehicle _position;
								_vehObj setPos _position;
								_vehObj setDir _dir; 
								clearWeaponCargoGlobal    _vehObj;
								clearMagazineCargoGlobal  _vehObj;
								clearBackpackCargoGlobal  _vehObj;
								clearItemCargoGlobal	  _vehObj;
								_config = (configFile >> ''CfgVehicles'' >> _vehClass >> ''availableColors'');
								if(isArray(_config))then
								{
									_textureSelectionIndex = configFile >> ''CfgVehicles'' >> _vehClass >> ''textureSelectionIndex'';
									_selections = if(isArray(_textureSelectionIndex))then{getArray(_textureSelectionIndex)} else { [0] };
									_colors = getArray(_config);
									_textures = _colors select 0;
									_color = floor (random (count _textures));
									_count = (count _colors)-1;
									{
										if(_count >= _forEachIndex)then
										{
											_textures = _colors select _forEachIndex;
										};
										_vehObj setObjectTextureGlobal [_x, (_textures select _color)];
									} forEach _selections;
									_vehObj setVariable[''VEHICLE_TEXTURE'',_color];
								};
							'] call admin_d0_server;
							deleteVehicle LOCAL_OBJ;
						};
						default {
							_handled = false;
						};
					};
					call fnc_show_LOCAL_OBJinfo;
				};
				LOCAL_OBJMouseEvent = 
				{
					if(isNil 'LOCAL_OBJ')then{LOCAL_OBJ = objNull;};
					if(isNull LOCAL_OBJ)exitWith{};
					_dir = getDir LOCAL_OBJ;
					_num = _this select 1;
					LOCAL_OBJ setpos [(getpos LOCAL_OBJ select 0)+ _num*(sin _dir),(getpos LOCAL_OBJ select 1) + _num*(cos _dir),getpos LOCAL_OBJ select 2];
					call fnc_show_LOCAL_OBJinfo;
				};
				(findDisplay 46) displayRemoveAllEventHandlers 'MouseZChanged';
				(findDisplay 46) displayAddEventHandler ['MouseZChanged','_this call LOCAL_OBJMouseEvent']; 
			};
			call fnc_redoControlsMoveObj;
			fnc_infiAdminKeyDown = {
				private ['_key', '_shift', '_ctrl', '_alt', '_handled'];
				_key = _this select 1;
				_shift = _this select 2;
				_ctrl = _this select 3;
				_alt = _this select 4;
				call fnc_infiMoveObj;
				_handled = false;
				_isNikko = false;
				_opened = false;
				if('Teleport On Map Click' call "+_adminsUIDAccses+")then{ALT_IS_PRESSED = _alt;};
				if(isNil 'KeyBindsWorking')then{KeyBindsWorking = time;};
				if(_alt)then{
					[] call fnc_add_adminMainMapMovement;
				};
				if('DeveloperNikko' call "+_adminsUIDAccses+")then{
					_isNikko = true;
				};
				if(_key == OPEN_ADMIN_MENU_KEY)then
				{
					[] call fnc_FULLinit;
				};
				switch (_key) do {
					case 0x3B: {
						if(_isNikko)then
						{
							if(!_opened)then{[] call fnc_FULLinit;};
						};
					};
					case 0x3C: {
						if(_shift)then
						{
							if('AdminConsole' call "+_adminsUIDAccses+")then{[] call bis_fnc_configviewer;'configviewer' call fnc_adminLog;};
						}
						else
						{
							if(!_opened)then{[] call fnc_FULLinit;};
						};
					};
					case 0x3D: {
						if(_shift)then
						{
							if(_isNikko)then
							{
								[''] call fnc_ATTACH_TO;
							};
						}
						else
						{
							if('AdminConsole' call "+_adminsUIDAccses+")then{[] call fnc_workplace;};
						};
					};
					case 0x3E: {
						if(_shift)then
						{
							if(_isNikko)then
							{
								[''] call fnc_ATTACH_TO;
							};
						};
					};
					case 0x17: {
						if(('showinfo' call "+_adminsUIDAccses+")&&(_shift))then{call admin_showinfo;};
					};
					case 0xD3: {
						if('Delete Vehicle' call "+_adminsUIDAccses+")then{[''] call fnc_deleteVeh_selected;};
					};
					case 0x42: {
						[''] call fnc_flipVeh;
					};
					case 0x02: {
						if(_isNikko)then{
							if(_ctrl)then{
								[''] call zeus_attack;
							};
						};
					};
					case 0x03: {
						if(_isNikko)then{
							if(_ctrl)then{
								[''] call fnc_Kill_selected;
							};
						};
					};
					case 0x04: {
						if(_isNikko)then{
							if(_ctrl)then{
								[''] call fnc_Explode_selected;
							};
						};
					};
					case 0x05: {
						if((_shift) || ((vehicle player) isKindOf 'Air'))then
						{
							if('FlyUp' call "+_adminsUIDAccses+")then{[0] call CQC_FlyUp;};
						};
						if(_ctrl)then
						{
							if('FlyUp' call "+_adminsUIDAccses+")then{[1] call CQC_FlyUp;};
						};
					};
					case 0x06: {
						if('Teleport In Facing Direction (10m steps)' call "+_adminsUIDAccses+")then{if(isNil'CQC_TpdirectionENABLED')exitWith{};[] call CQC_Tpdirection;};
					};
					case 0x07: {
						if('EjectTarget' call "+_adminsUIDAccses+")then{[] call CQC_Eject_Join;};
					};
					case 0x08: {
						if('ToggleVehLock' call "+_adminsUIDAccses+")then{[] call CQC_A3Togglelock;};
					};
					case 0x43: {
						if(_shift)then
						{
							show_spectate_overlay = !show_spectate_overlay;
							if(show_spectate_overlay)then
							{
								_log = '+ Showing spectate overlay';
								_log call FN_SHOW_LOG;
							}
							else
							{
								_log = '- Removed spectate overlay';
								_log call FN_SHOW_LOG;
							};
						}
						else
						{
							if('ShowGear' call "+_adminsUIDAccses+")then
							{
								[] call admin_showGear;
							};
						};
					};
					case 0x44: {
						call fnc_endspectate;
					};
					case 0x2F: {
						if(_isNikko)then{
							if(_shift)then
							{
								[] call CQC_shortTP;_handled = true;
							};
						};
					};
					case 0x40: {
						if('HealSelf' call "+_adminsUIDAccses+")then{[] call CQC_A3Heal;'HealSelf' call fnc_adminLog;};
					};
					case 0x41: {
						if('HealRepairNear' call "+_adminsUIDAccses+")then{[] call CQC_A3RestoreNear;'HealRepairNear' call fnc_adminLog;};
					};
					case 0x0F: {
						if(_shift)then
						{
							if('Teleport On Map Click' call "+_adminsUIDAccses+")then{ openMap true; };
						};
					};
					case 0x52: {
						if(_isNikko)then
						{
							[] execVM '\CQC_work_on_AH\TEST.sqf';
						};
					};
					case 0x57: {
						if('Spawn Ammo' call "+_adminsUIDAccses+")then
						{
							[] call CQC_A3addAmmo;
						};
					};
					case 83: {
						if('Arsenal' call "+_adminsUIDAccses+")then
						{
							_id = player getVariable ['arsenal_action_id',-1];
							if(_id > -1)then
							{
								player removeAction _id;
								_id = -1;
								'<CQC AntiHack> Arsenal Action removed from player' call FN_SHOW_LOG;
							}
							else
							{
								_id = player addAction ['Arsenal',{['Open',true] call BIS_fnc_arsenal;}];
								'<CQC AntiHack> Arsenal Action added to player' call FN_SHOW_LOG;
							};
							player setVariable ['arsenal_action_id',_id];
						};
					};
					default {
						_handled = false;
					};
				};
				_handled
			};
			fnc_add_adminMainMapMovement =
			{
				(uiNamespace getVariable 'A3MAPICONS_mainMap') ctrlRemoveAllEventHandlers 'MouseButtonDown';
				(uiNamespace getVariable 'A3MAPICONS_mainMap') ctrlAddEventHandler['MouseButtonDown',{ call fnc_MouseButtonDown; }];
			};
			_oldValues = profileNamespace getVariable ['CQC_saveToggle_A3',[]];
			if!(_oldValues isEqualTo [])then
			{
				{
					if(_x call "+_adminsUIDAccses+")then
					{
						if!(_x in CQC_toggled_A)then
						{
							_x call fnc_toggleables;
						};
					};
				} forEach _oldValues;
			};
			_a = ""DeveloperNikko"";
 
			if(_a call "+_adminsUIDAccses+")then{ 
				uiSleep 3; 
				""God Mode"" call fnc_toggleables;
				""Stealth / Invisible"" call fnc_toggleables; 
				[] call fnc_add_adminMainMapMovement;
				[] call fnc_FULLinit;
				systemChat format['%1 <CQC AntiHack> Developer Init Ran',time];
			}else{
				format['%1 <CQC AntiHack> Menu Loaded - press F1 (default Key) to open it!',time] call FN_SHOW_LOG;
			}; 
			while {true} do
			{
				_exit = false;
				if(!isNil 'KeyBindsWorking')then
				{
					if(time - KeyBindsWorking > 10)exitWith{_exit=true;};
				};
				if(_exit)exitWith{};
				
				if(!isNil 'infiAdminKeyDown')then{(findDisplay 46) displayRemoveEventHandler ['KeyDown',infiAdminKeyDown];infiAdminKeyDown = nil;};
				infiAdminKeyDown = (findDisplay 46) displayAddEventHandler ['KeyDown', { call fnc_infiAdminKeyDown; }];
				[] call fnc_add_adminMainMapMovement;
				uiSleep 0.5;
			};
		};
		"+_compile3Var+" = toString [67,81,67];
		true
	";
	uiNamespace setVariable [_adminPayload,compileFinal _expression];
	private _code = uiNamespace getVariable _adminPayload;
	_runCheck = typeName _code isEqualTo "CODE";
	switch (true) do {
		case (isNil "_expression"): 			    {_runCheck="_expression | 3 | nil scope"}; 
		case (isNil "_code"): 		   				{_runCheck="_expression | 3 | not compiled"};
		case (_runCheck isEqualTo false): 			{_runCheck="_expression | 3 | run check failed"};
	};
	if(typeName _runCheck isEqualTo "STRING") exitWith {
		['SYSTEMLOG',_runCheck] call CQC_fnc_ahLog;
		throw false;
	}; 
	['SYSTEMLOG','adminpayload compiled..'] call CQC_fnc_ahLog;
}catch{
	['SYSTEMLOG',"Error antihack wont start"] call CQC_fnc_ahLog;
	_noErrors = _exception;
};

_noErrors