/*Cyberpunk 2077 Load Remover and Auto Splitter
Written by Radioactive03, Meta and nicnacnic
Shoutout to Kuno for bein a lad and helping out with splitting logic
Thanks to Drek and Moowell for being my guinea pigs during the testing phase, and dealing with the janky splitting of early builds xD */

state("Cyberpunk2077","1.11")
{
	byte loading : 0x3C80F00;
	string50 objective : 0x04320A50, 0x260, 0x28, 0x8, 0x38, 0xB8, 0x118, 0x0;
}

state("Cyberpunk2077", "1.1")
{
	byte loading : 0x3C80F00;
    string50 objective : 0x04320A50, 0x260, 0x28, 0x8, 0x38, 0xB8, 0x118, 0x0;
}

state("Cyberpunk2077", "1.06")
{
	byte loading : 0x3C7EF40;
}

startup
  {
	refreshRate = 30;
	
	// Add buttons to settings menu.
	settings.Add("Remove Loads", true);
	
	// Completed facts.
	vars.completedSplits = new HashSet<string>();
	
	// Any% facts. Key is the split name, value is the split fact.
	vars.anyPercentDict = new Dictionary<string,string>
	{
		{"Meet Jackie","01_talk_to_jackie"},
		{"The Rescue","00_reward"},
		{"Ripperdoc","ride_with_dex"},
		{"All Foods","call_dex"},
		{"BD Tutorial","exit_judy_workshop"},
		{"Delamain","exit_delamain"},
		{"Flathead","sit_table"},
		{"Escape","07_get_to_delamain"},
		{"Title Screen","stage"},
		{"Love Like Fire","dig"},
		{"Meeting Johnny","get_up"},
		{"Clouds","03_take_elevator"},
		{"Fingers","plug_in"},
		{"Rescue Evelyn","leave_apartment"},
		{"Afterlife","wait_1_day"},
		{"Mobile Camp","ride_to_ghost_town"},
		{"Ghost Town","meet_panam"},
		{"Destroy Plant","drive_panam_hill"},
		{"Lightning Breaks","talk_with_courier"},
		{"Grand Imperial Mall","02a_talk_to_brigitte"},
		{"Atlantis Escape","02_escape_atlantis"},
		{"Never Fade Away","01_sit_down"},
		{"Killed Oda","05f3_talk_takemura_no_mp"},
		{"Nocturne OP55N1","06_talk_johnny"},
	};
	
	// Title Screen facts. Key is the split name, value is the split fact.
	vars.titleScreenDict = new Dictionary<string,string>
	{
		{"Meet Jackie","01_talk_to_jackie"},
		{"The Rescue","00_reward"},
		{"Ripperdoc","ride_with_dex"},
		{"All Foods","call_dex"},
		{"BD Tutorial","exit_judy_workshop"},
		{"Delamain","exit_delamain"},
		{"Flathead","sit_table"},
		{"Escape","07_get_to_delamain"},
	};
	
	// Joytoy facts. Key is the split name, value is the split fact.
	vars.joytoyDict = new Dictionary<string,string>
	{
		{"Enter Padre's car","08_drive_downtown"},
		{"Meet Jackie","01_talk_to_jackie"},
	};
	
	// Custom facts. Key is the fact, value is what appears in the settings.
	vars.customSplitsDict = new Dictionary<string,string>
	{
		{"08_drive_downtown","Entered Padre's Car"}, //moves from Meet Padre - Meet Jackie
		{"01_talk_to_jackie","(2 Splits) Start of the 6 Months Later Cutscene, AND killed the drones during The Heist"}, // moves from Meet Jackie - The Rescue
		{"goto_elevator1","End of The Rescue"}, //moves from The Rescue - Prologue
		{"05_go_to_vroom","End of Prologue - V Falls asleep"}, //moves from Prologue - Dupe n Elevator Skip
		{"summon_car","Summon the car after Elevator Skip and Duping"}, //moves from Dupe - The Ripperdoc
		{"ask_jackie","Completed The Ripperdoc quest"}, //moves from The Ripperdoc - To Dex's Car
		{"ride_with_dex","Entered Dexs car"}, // moves from To Dex's Car - All Foods
		{"call_dex1","All Foods Quest finishes"}, // moves from All Foods - BD Tut 1
		{"talk_judy_and_evelyn","End of Robbery Brain Dance"}, // moves from BD Tut 1 - BD Tut 2
		{"sum_up","End of Konpeki Plaza Brain Dance"}, //moves from BD Tut 2 - The Information
		{"goto_meeting_location","Completed The Information quest"}, // Moves from The Information - Excelsior Package
		{"wait_for_jackie_trunk","Get out of Delemain at Konpeki Plaza"},// moves from Excelsior Package - Flathead
		{"open_grate_sec_room","Let the Flathead into the netrunner room"}, // Moves from Flathead - Saboru Ara-fucking-saka
		{"01c_jump","Jump out of the penthouse"}, // moves from Saboru Ara-Fucking-Saka - Escape Arasaka
		{"07_get_to_delamain","Enter Delemain"}, // moves from Escape Arasaka - Drones Killed
		// 01_talk_to_jackie is called at this point to move Drones Killed - BOMB HAS BEEN PLANTED
		{"shoot_cables","Just shot the elevator cables"}, // moves BOMB HAS BEEN PLANTED - Love Like Fire
		{"dig","Completed Love Like Fire quest"}, // moves Love Like Fire - Here's Johnny
		{"prepare_before_leave","Johnny says he's gonna murder you lol"}, // moves Here's Johnny - Takemura Diner
		{"holocall_judy","Finished Takemura Diner"}, // moves Takemura Diner - Lizzie's Bar 2
		{"leave_lizzies","Lizzie's Bar 2"}, // moves from Lizzies Bar 2 - Clouds
		{"take_weapons","Take Weapons when you're done at Clouds"}, // Moves from Clouds - Fingers
		{"meet_fingers","Meet Fingers"}, // Moves from Fingers - Illegal BD's
		{"02_meet_judy_at_van","XBD bought"}, // Moves from Illegal BD's - Pizza Box Brain Dance
		{"talk_judy2","Judy BD End"}, // Moves from Pizza Box Brain Dance - Enter Compound
		{"locate_evelyn","Reached contorl room with Judy"}, // Moves from Enter Compound - Rescue Evelyn
		{"17_leave","Pickup Evelyn"}, // Moves from Rescue Evelyn - Judy's Apartment
		{"01_call_fixer","Left Judy's apartment Quest End"}, // Moves from Judy's Apartment - Oda Meeting
		{"00c_03_talk_wakako","Finish meeting with Oda and Takemura, start talking to Wakako"}, // Moves from Oda Meeting - Afterlife
		{"go_to_panam","Finish Rogue conversation"}, // Moves from Afterlife - Helping Panam
		{"ride_camp","Entered Panams car, on the way to Nomad Camp"}, // Moves from Helping Panam - Car Ride
		{"talk_scorp_mitch","Start conversation w/ Scorpion and Mitch"}, // Moves from Car Ride - Grab n Go
		{"ride_to_ghost_town","After grabbing Panams stuff from the Nomad camp"}, // Moves from Grab n Go - Ambush Setup
		{"wait_raffen","Time wait until the convoy comes through"}, // Moves from Ambush Setup - Panam's Truck
		{"rendezvous_gt_north1","Enter Panams truck"}, // Moves from Panam's Truck - Lightning Breaks Startup
		{"calibrate_turret","Start Lightning Breaks"}, // Moves from Lightning Breaks Startup - Turret Calibration
		{"plant_security","Lightning Breaks shoot drone start"}, // Moves from Turret Calibration - Crash Landing
		{"deal_av_turret","AV Scanning"}, // Moves from Crash Landing - Mitch Skip
		{"reach_gas_station","You just finished Mitch Skip, about to go interrogate Hellman"}, // Moves from Mitch Skip - Gas Station
		{"talk_with_courier","Gas Station done"}, // Moves from Gas Station - Start Map T'ann Pelen
		{"01b_wait_till_chapel_open","Finished Takemura Meeting, starting Ma'p Tenn Pelen"}, // Moves from Start Map T'ann Pelen - Meet With Placide
		{"01_exit_the_hotel","Finish Map Tann Pelen - Start GIM Skip"}, // Moves from Meet With Placide - GIM Skip
		{"05c_talk_to_netrunner","Reach the Netwatch Agent"}, // Moves from GIM Skip - Meet Brigitte
		{"05b_talk_to_queen","Enter Cyberspace with Brigitte"}, // Moves from Meet Brigitte - Meet Alt
		{"01_talk_with_ripper","Finish at the Ripperdoc in Johnny's memory"}, // Moves from Meet Alt - Kill Arasaka 1
		{"05a_call_lift","Killed all Arasaka enemies"}, // Moves from Kill Arasaka 1 - Johnny's Porsche
		{"02_escape_atlantis","Enter Johnnys Porsche"}, // Moves from Johnny's Porsche - Kill Arasaka 2
		{"04_check_on_alt","Finish killing the Arasaka enemies in the room with Alt"}, // Moves from Kill Arasaka 2 - Never Fade Away
		{"02b_leave_the_chapel","Completed Never Fade Away"}, // Moves from Never Fade Away - Arasaka Industrial Park
		{"04h_leave","Escaped Arasaka Industrial Park"}, // Moves from Arasaka Industrial Park - Takemura is Charging His Phone
		{"05a_go_parade","Takemura finally fucking called you, time for the parade bitches"}, // Moves from Takemura is Charging His Phone - Let's Start the Parade
		{"05c_kill_snipers","Parade start"}, // Moves from Let's Start the Parade - To Oda
		{"05f_fight_cyberninja","Start Oda fight"}, // Moves To Oda - Oda Fight
		{"05k_flee","GTFO of the parade"}, // Moves Oda Fight - Takemura Hideout
		{"07a_guard_door","Escaped, motel cutscene starts"}, // Moves Takemura Hideout - Meet Hanako at Embers
		{"02_meet_hanako","Meet Hanako at Embers"}, // Moves Meet Hanako at Embers - The Worst Ending
	};
	
	// Add to settings menu.
	settings.Add("Any%", false);
	settings.Add("Title Screen", false);
	settings.Add("Joytoy", false);
	settings.Add("Custom", false);
	
	foreach (var script in vars.customSplitsDict) {
		settings.Add(script.Key, false, script.Value, "Custom");
	}
	
	settings.Add("Debug", false);
}

init
{	
	vars.loading = false;
	// Asks user to change to game time if LiveSplit is currently set to Real Time.
	if (timer.CurrentTimingMethod == TimingMethod.RealTime && settings["Remove Loads"]) {
        var timingMessage = MessageBox.Show (
            "The Cyberpunk 2077 Autosplitter is currently set to include load times.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to change the timing method to Game Time?",
            "LiveSplit | Cyberpunk 2077 Autosplitter",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );   
        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
	
	// Asks user to change to real time if LiveSplit is currently set to Game Time.
	if (timer.CurrentTimingMethod == TimingMethod.GameTime && !settings["Remove Loads"]) {
        var timingMessage = MessageBox.Show (
            "The Cyberpunk 2077 Autosplitter is currently set to ignore load times.\n"+
            "Using Game Time could cause the timer to be inaccurate.\n"+
            "Would you like to change the timing method to Real Time?",
            "LiveSplit | Cyberpunk 2077 Autosplitter",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );   
        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.RealTime;
        }
    }
	
	// Asks user to select splits if none are selected.
	if (!settings["Any%"] && !settings["Title Screen"] && !settings["Joytoy"] && !settings["Custom"]) {
        var timingMessage = MessageBox.Show (
            "The Cyberpunk 2077 Autosplitter does not have any splits enabled.\n"+
            "Please make sure you have selected some splits in the settings.",
            "LiveSplit | Cyberpunk 2077 Autosplitter",
            MessageBoxButtons.OK,MessageBoxIcon.Asterisk
        );   
    }
	
	// Asks user to enable automatic splits if they are disabled.
	if (!settings.SplitEnabled) {
        var timingMessage = MessageBox.Show (
            "The Cyberpunk 2077 Autosplitter has automatic splitting disabled.\n"+
            "Any splits that you have enabled will not work.\n"+
            "If you would like to use automatic splitting, make sure to enable it in the settings.",
            "LiveSplit | Cyberpunk 2077 Autosplitter",
            MessageBoxButtons.OK,MessageBoxIcon.Asterisk
        );   
    }
	
	// Asks user to enable automatic start if its are disabled.
	if (!settings.StartEnabled) {
        var timingMessage = MessageBox.Show (
            "The Cyberpunk 2077 Autosplitter has automatic start disabled.\n"+
            "The timer will not automatically start when you start a run.\n"+
            "If you would like to use automatic start, make sure to enable it in the settings.",
            "LiveSplit | Cyberpunk 2077 Autosplitter",
            MessageBoxButtons.OK,MessageBoxIcon.Asterisk
        );   
    }
}

start
{
	// Clear the list of completed splits.
	vars.completedSplits.Clear();
	
	// Start the timer when the first objective of- the game is detected.
	if (settings.StartEnabled && settings["Remove Loads"])
		return (current.objective == "generic_sts_objective" && current.objective != old.objective);
}

update
{	
	// Show debug.
	if (settings["Debug"]) {
		print("Current Objective: " + current.objective);
		print("Game Loading: " + (current.loading != 70));
	}
	if (!settings["Remove Loads"])
		vars.loading = false;
	else
		vars.loading = current.loading != 70;
}

split
{	
	// Split if current fact equals a fact in the dictionary.
	if (settings.SplitEnabled) {
		if (current.objective != old.objective && old.objective != null && !vars.completedSplits.Contains(current.objective)) {
			
			if (vars.anyPercentDict.ContainsValue(current.objective) && settings["Any%"]) {
				vars.completedSplits.Add(current.objective);
				return true;
			}
			else if (vars.titleScreenDict.ContainsValue(current.objective) && settings["Title Screen"]) {
				vars.completedSplits.Add(current.objective);
				return true;
			}
			else if (vars.joytoyDict.ContainsValue(current.objective) && settings["Joytoy"]) {
				vars.completedSplits.Add(current.objective);
				return true;
			}
			else if (settings[current.objective] && settings["Custom"]) {
				vars.completedSplits.Add(current.objective);
				return true;
			}
		}
	}
}
	
exit
{
	// Pause timer if the game closes.
	timer.IsGameTimePaused = true;
}

isLoading
{	
	// Checks to see if the loading value is 70. If it is, pause the timer.
	return vars.loading;
}