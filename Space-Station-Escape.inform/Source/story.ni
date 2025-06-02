"Space-Station-Escape" by Ashton Smith

[Space-Escape - an interactive fiction written with Inform 7 by Ashton Smith.
In this game you play as an engineer on a space station that is about to explode - the self destruct sequence has started on the ship. But the escape pod must be fixed before you can escape. ]
Release along with an interpreter.

Section 1 - Time Mechanic & Radio

Table of TimeCost
action		time
"examine"		0.25
"look"		0.25
"n"		1.00
"e"		1.00
"s"		1.00
"w"		1.00
"radio"		0.25
"repair"		1.00
"take"		0.25
"use"		0.50
"open"		0.50
"reply"		0.25
"answer"		0.25
"install"		1.00
"put"		0.50
"insert"		0.50
"get"		0.25
"drop"		0.25
"inventory"		0.00
"i"		0.00
"unscrew"		0.50
"switch on"		0.50
"turn on"		0.50
"switch off"		0.50
"turn off"		0.50
"read"		0.25
"x"		0.25
"close"		0.25
"l"		0.25

Replying to the radio is an action applying to nothing.
Understand "a" or "answer radio" or "reply to radio"  or "reply" as replying to the radio.

The radio count is a number that varies. The radio count is 0.
already replied is a truth state variable. already replied is false.
Carry out replying to the radio:
	now timesincelastreply is 0;
	if already replied is true and firstpodentry is true:
		say "You respond to the radio: [italic type]How much time do I have??[roman type][line break][line break]";
		say "Radio: You've got [time remaining] minutes until the station self destructs!";
	if already replied is true and firstpodentry is false:
		say "BOOP";
	if radio count is 0 and already replied is false:
		say "You respond to the radio: [italic type]Acknowledged. Heading to the escape pod now.[roman type]";
		now already replied is true;
	if radio count is 1 and already replied is false:
		say "You respond to the radio: [italic type]The pod is broken! I will have to do some repairs first.[roman type][line break][line break]";
		say "Radio: [italic type]Engineer, The station's going to blow soon - you need to get that thing fixed or you are toast! [roman type]";
		now already replied is true;

Instead of replying to the radio when the player does not carry the radio:
	say "You need to have the radio to respond.";
	
The time remaining is a real number that varies. The time remaining is 60.

timesincelastreply is a number that varies. The timesincelastreply is 0.
lastchanceused is a truth state variable. lastchanceused is false.
Every turn:
	if already replied is false:
		increase the timesincelastreply by one;
		if timesincelastreply is greater than 5:
			say "Radio: [italic type]Engineer, come in! Is everything okay over there?[line break][line break][roman type] Type [bold type]reply[roman type] to reply."
		
repairmanualhint is a truth state variable. repairmanualhint is false.
stationexplodewarning is a truth state variable. stationexplodewarning is false.
twentywarning is a truth state variable. twentywarning is false.
Every turn:
	if Time Remaining <= 0:
		end the story saying "You ran out of time.";
	let T be Time Remaining to the nearest whole number;
	if  T <= 20:
		if twentywarning is false:
			say "Radio: You've got 20 minutes remaining until the station explodes! You need to get moving!";
			now twentywarning is true;
	if T <= 5:
		if lastchanceused is false:
			say "Radio: Good news! I was able to do a security override and extend the time by 20 minutes! But you need to hurry up! the self-destruct sequence cannot be stopped completley. I found some old repair manuals and to get the escape pod working you will need an [bold type]ion battery[roman type], [bold type]keys[roman type], and a[bold type] steering wheel[roman type]";
			increase time remaining by 20;
		otherwise:
			if stationexplodewarning is false:
				say "Radio: There are only 5 minutes until the station explodes!  - Get to the pod and [italic type]use[roman type] the key on the starter ASAP!!";
				now stationexplodewarning is true;
	if T <= 45:
		if repairmanualhint is false:
			say "Radio: 45 minutes remain! If you can't figure out how to fix something try checking a [bold type]Repair Manual[roman type]!";
			now repairmanualhint is true;
		
After reading a command:
	let T be 0.0;
	let the lower-case command be "[the player's command in lower case]";
	repeat through the Table of TimeCost:
		if lower-case command matches the text action entry:
			now T is time entry;
			break;
	now Time Remaining is Time Remaining - T;	
	

Section 2 - Engineering Bay (Start)

The Engineering Bay is a room.  
The description of the Engineering bay is "You step into the bay. The room is cluttered with workbenches, oscilloscopes, and spacecraft schematics, all showing signs of frantic last-minute repairs.[line break]There are two doorways: [bold type]NORTH[italic type] Command Deck [bold type]SOUTH[italic type] Escape Pod Bay[roman type] ".
The radio is an object in the engineering bay.

Before going:
	if the player does not carry the radio:
		say "You might want to take the radio before going anywhere.";
		stop the action;
		
Before going north:
	if firstpodentry is false:
		say "There is no reason to go this way! Lets get to the escape pod immediatley!";
		stop the action;
		
The MSDS Cabinet is a closed openable fixed in place container in the engineering bay.

The 'MSDS' is a thing in the MSDS Cabinet. The description of the MSDS is "The Material Safety Data Sheet — your favorite bedtime story. A hefty binder crammed with dry, detailed info on chemical safety, handling procedures, and a surprising number of warnings."

The Tool Cabinet is a closed openable fixed in place container in the engineering bay.

The hammer is a thing. The hammer is inside the tool cabinet.
		
The Repair Manual is a thing in the Tool Cabinet.

Instead of examining the Repair Manual:
	say "The repair manual is an old book on space station repair, you quickly flip through it and take note of some key details:
	
- To install components like a steering wheel, try typing [bold type]install steering wheel in control station[roman type].
	
- To open sealed panels, you may need a tool. Try typing [bold type]open panel with power drill[roman type].

- To install batteries: Try typing [bold type]put the ion battery in the battery panel[roman type].

It also mentions something about ensuring power is turned off before handling high-voltage components.";


After taking the radio for the first time:
	say "Radio: [italic type]Engineer, come in! The station's self-destruct sequence has been triggered—you have 90 minutes before total detonation. Get to the escape pod bay immediately! [roman type]";
	say "[italic type] [line break][line break]Type Reply to reply.[roman type]";

Section 3 - Escape Pod Bay

The Escape Pod Bay is a room. 
The description of the Escape Pod Bay is "A cramped escape pod awaits — a last resort for emergencies. Panoramic windows reveal the cold expanse of space and a faint glimmer of the approaching rescue ship.[line break]There is one doorway: [bold type]NORTH[roman type] Engineering Bay"

The Escape Pod Bay is south of the engineering bay.

The Battery Panel is a closed fixed in place openable container in the Escape Pod Bay.

The Control station is a fixed in place container in the Escape Pod Bay.

Understand "install [something] in [something]" as installing it in.
Installing it in is an action applying to two things.

Every turn:
	if the ion battery is in the Battery Panel:
		now the ion battery is installed;
	otherwise:
		now the ion battery is uninstalled;
	if the steering wheel is in the Control Station:
		now the steering wheel is installed;
	otherwise:
		now the steering wheel is uninstalled;

yougoteverythinghint is a number that varies. yougoteverythinghint is 3.
Every turn:
	if the steering wheel is installed and the ion battery is installed:
		if yougoteverythinghint is 3:
			if player has key:
				say "The pod is totally fixed and we have the key! Maybe it is time to leave this old ship behind by starting up the escape pod![line break][line break][italic type]hint: [bold type]turn on takeoff starter[roman type] to start the escape pod.";
				decrease yougoteverythinghint by 3;
			otherwise:
				say "You have fixed everything in the pod! We just need to find the key!";
				decrease yougoteverythinghint by 3;
		otherwise:
			increase yougoteverythinghint by 1.
			
The Takeoff Starter is a device in the Escape Pod Bay. The Takeoff Starter is fixed in place. The Takeoff Starter is switched off. The description of the takeoff storage is "The ignition for the escape pod, you will need a key to get this thing started.".

Instead of switching on the takeoff starter :
	if the steering wheel is installed and the ion battery is installed and the player has the key:
		say "You insert the keys and twist. The pod vibrates as it starts, systems come online, and you're launched into space. You made it!";
		end the story finally saying "You escaped just in time!";
		stop the action;
	if the player has the key:
		say "You try to start the pod, but the system errors out. Maybe something important is missing.";
	otherwise:
		say "You need a key to start the pod.";

Carry out installing it in:
	now the steering wheel is in the control station.

Report installing it in:
	say "You snap the steering wheel into place. The control panel lights up with a hum.";

Instead of inserting the steering wheel into the control station:
	try installing the steering wheel in the control station.

firstpodentry is a truth state variable. firstpodentry is false.
After going to the Escape Pod Bay:	
	if firstpodentry is true:
		continue the action;
	if the player has the radio:
		now firstpodentry is true;
		the radio talks in zero turns from now;
		increase radio count by 1;
		now already replied is false;
		continue the action;
	otherwise:
		stop the action;
		
The Cabin Storage is a closed fixed in place openable container in the escape pod bay.

At the time when the radio talks:
	say "Radio: [italic type]Engineer, come in! Why haven't you taken off in the escape pod yet?[roman type]"; 	

Section 4 -  Battery Room

The Battery Room is a room.
The description of the Battery Room is "Dimly lit and filled with the hum of energy, the Battery Room houses the station's core power systems. Thick cables run along the walls, and a faint smell of ozone hangs in the air. [line break]There is one doorway: [bold type]EAST[roman type] Command Deck."


The Battery Room is west of the Command Deck.
The Power Switch is a device in the battery room.  The power switch is fixed in place. 
The Power Switch is switched on.
The Main Battery Panel is a closed lockable locked openable container in the Battery room. The main battery panel is fixed in place.

The Ion Battery is a thing. The ion battery is inside the main battery panel. The ion battery can be installed or uninstalled. The ion battery is installed.

The power drill unlocks the main battery panel.

Unscrewing it with is an action applying to one thing and one carried thing.

Understand "unscrew [something]" as unscrewing it with when the player carries the power drill.
Understand "unscrew [something] with [something preferably held]" as unscrewing it with.


Check unscrewing something with:
	if the noun is not the main battery panel:
		say "You can't unscrew that." instead;
	if the second noun is not the power drill:
		say "That won't help with the screws." instead;
	if the main battery panel is unlocked:
		say "You've already unscrewed the panel." instead;

Carry out unscrewing the main battery panel with the power drill:
	now the main battery panel is unlocked;
	say "You drive the power drill into the screws. One by one they come loose with a whine, and the panel is now unscrewed."


Instead of taking the ion battery:
	if the power switch is switched on:
		say "You just got shocked!! Maybe you should try to [bold type]turn off[roman type] the power switch next time.";
	otherwise:
		now the player has the ion battery;

Before going:
	if the power switch is switched off:
		say "The doors are inoperable while the power is off. [bold type]Turn On[roman type] the power switch if you are done here!";
		stop the action;
		
Instead of opening the main battery panel:
	if the main battery panel is locked:
		say "The battery panel is secured with screws. You will need to [bold type]unscrew[roman type] them to open it.";
	otherwise:
		continue the action;

Section 5 - Command Deck

The Command Deck is a room.  
The description of the Command Deck is "The nerve center of the station, once full of activity — now quiet, with blinking consoles and flickering readouts.[line break]There are three doorways: [bold type]EAST[italic type] Storage Room [bold type]SOUTH[italic type] Engineering Bay [bold type]WEST[italic type] Battery Room[roman type]"

The Command Deck is north of the Engineering Bay.

A console is in the Command Deck. The description of the console is "A central control console with various blinking lights. A drawer is built into the frame, but it appears to be locked by a biometric scanner."

The console is fixed in place.

A scanner is part of the console. The description of the scanner is "A small glowing panel, clearly meant to scan a fingerprint."

The drawer is part of the console. The drawer is a closed, openable, locked container.

The Captain's Glove is on the chair. The chair is an enterable supporter in the Command Deck. The description of the captain's glove is "A worn leather glove. [italic type]It looks like this may have a usable fingerprint on it.[roman type]"

The key is in the drawer. The key is a thing. The description of the key is "These look like keys to a space ship, maybe these could be used to [bold type]start[roman type] one up?"

Using something on something is an action applying to one carried thing and one visible thing.
Understand "use [something] on [something]" as using something on something.

Check using something on something:
	if the second noun is not the scanner:
		say "That doesn't seem to work." instead;
	if the noun is not the captain's glove:
		say "That item can't activate the scanner." instead.

Understand "biometric scanner" as scanner.

Carry out using something on something:
	now the drawer is unlocked;
	now the drawer is open;
	say "You press the glove to the scanner. After a brief pause, the scanner beeps approvingly and the drawer pops open with a soft click."

Report using something on something:
	do nothing.



Section 6 - Storage Room

The Storage Room is a room. The description of The storage room is "Stacks of containers fill the room, dimly lit and heavy with the acrid smell of burnt rubber and scorched electronics. [line break] There is one doorway: [bold type]WEST[italic type] Command Deck[roman type]".
The storage room is east of the Command Deck.
The table is a supporter in the storage room.
The power drill is an object on the table.

Section 7 - Storage Room generated containers

The container 300b is a fixed in place closed openable container in the storage room. The description of the container 300b is "A small container with a few items inside.". 
The oxygen regulator is a thing inside the container 300b. The description of the oxygen regulator is "is slightly dented".
The magnetic boots is a thing inside the container 300b. The description of the magnetic boots is "is labeled 'fragile'".
The plasma rifle is a thing inside the container 300b. The description of the plasma rifle is "is missing its trigger".

The container 184c is a fixed in place closed openable container in the storage room. The description of the container 184c is "A small container with a few items inside.". 
The data storage drive is a thing inside the container 184c. The description of the data storage drive is "is stored in a protective case".
The radiation shield panel is a thing inside the container 184c. The description of the radiation shield panel is "is marked as 'critical equipment'".
The microfiber cleaning cloth is a thing inside the container 184c. The description of the microfiber cleaning cloth is "is surprisingly clean".

The container 225d is a fixed in place closed openable container in the storage room. The description of the container 225d is "A small container with a few items inside.". 
The navigation manual is a thing inside the container 225d. The description of the navigation manual is "is slightly dusty".
The emergency beacon is a thing inside the container 225d. The description of the emergency beacon is "is blinking faintly".
The welding goggles is a thing inside the container 225d. The description of the welding goggles is "has a few scratches but is functional".

The container 178e is a fixed in place closed openable container in the storage room. The description of the container 178e is "A small container with a few items inside.". 
The first aid kit is a thing inside the container 178e. The description of the first aid kit is "is in pristine condition".
The holographic map is a thing inside the container 178e. The description of the holographic map is "is flickering with static".
The portable water purifier is a thing inside the container 178e. The description of the portable water purifier is "is compact and efficient".

The container 118e is a fixed in place closed openable container in the storage room. The description of the container 118e is "A small container with a few items inside.". 
The cracked power cell is a thing inside the container 118e. The description of the cracked power cell is "is leaking a strange fluid".
The emergency flare is a thing inside the container 118e. The description of the emergency flare is "is unused and ready to ignite".
The heat-resistant gloves is a thing inside the container 118e. The description of the heat-resistant gloves is "are slightly charred".

The container 434e is a fixed in place closed openable container in the storage room. The description of the container 434e is "A small container with a few items inside.". 
The dehydrated meal pack is a thing inside the container 434e. The description of the dehydrated meal pack is "is labeled 'chicken flavor'".
The rusty wrench is a thing inside the container 434e. The description of the rusty wrench is "is covered in rust but still usable".
The strange rock is a thing inside the container 434e. The description of the strange rock is "is warm to the touch".

The container 152a is a fixed in place closed openable container in the storage room. The description of the container 152a is "A small container with a few items inside.". 
The repair drone is a thing inside the container 152a. The description of the repair drone is "an old repair drone, with some wear and tear".
The oxygen mask is a thing inside the container 152a. The description of the oxygen mask is "is functional but scratched".
The anti-gravity harness is a thing inside the container 152a. The description of the anti-gravity harness is "is slightly malfunctioning".

The container 217c is a fixed in place closed openable container in the storage room. The description of the container 217c is "A small container with a few items inside.". 
The broken antenna is a thing inside the container 217c. The description of the broken antenna is "is bent and unusable".
The cargo strap is a thing inside the container 217c. The description of the cargo strap is "is frayed at the edges".
The alien artifact is a thing inside the container 217c. The description of the alien artifact is "is glowing faintly with an unknown energy".

The container 297b is a fixed in place closed openable container in the storage room. The description of the container 297b is "A small container with a few items inside.". 
The steering wheel is a thing inside the container 297b. The description of the steering wheel is "A pristine steering wheel, clearly designed for a standard-issue escape pod. It still has its factory tag attached — you hope it works.".
The spare landing gear spring is a thing inside the container 297b. The description of the spare landing gear spring is "is coiled tightly".
The plasma torch is a thing inside the container 297b. The description of the plasma torch is "is glowing faintly".

The container 115a is a fixed in place closed openable container in the storage room. The description of the container 115a is "A small container with a few items inside.". 
The spare helmet visor is a thing inside the container 115a. The description of the spare helmet visor is "is scratched but usable".
The fuel injector is a thing inside the container 115a. The description of the fuel injector is "is leaking a strange liquid".
The emergency light stick is a thing inside the container 115a. The description of the emergency light stick is "is glowing faintly green".

The container 479a is a fixed in place closed openable container in the storage room. The description of the container 479a is "A small container with a few items inside.". 
The jumper cables is a thing inside the container 479a. The description of the jumper cables is "an old set of cables, but still functional".
The alien plant sample is a thing inside the container 479a. The description of the alien plant sample is "is sealed in a glass container".
The portable scanner is a thing inside the container 479a. The description of the portable scanner is "is coated in reflective material".

The container 257a is a fixed in place closed openable container in the storage room. The description of the container 257a is "A small container with a few items inside.". 
The hull patch kit is a thing inside the container 257a. The description of the hull patch kit is "is slightly dented but usable".
The old data pad is a thing inside the container 257a. The description of the old data pad is "has a flickering display".
The magnetic screwdriver is a thing inside the container 257a. The description of the magnetic screwdriver is "is sticking to nearby metal".

The container 257c is a fixed in place closed openable container in the storage room. The description of the container 257c is "A small container with a few items inside.". 
The empty fuel canister is a thing inside the container 257c. The description of the empty fuel canister is "is dented and smells of fuel".
The thermal regulator is a thing inside the container 257c. The description of the thermal regulator is "is humming faintly".
The thermal blanket is a thing inside the container 257c. The description of the thermal blanket is "is wrapped in thermal insulation".

The container 240d is a fixed in place closed openable container in the storage room. The description of the container 240d is "A small container with a few items inside.". 
The spare thruster nozzle is a thing inside the container 240d. The description of the spare thruster nozzle is "is covered in scorch marks".
The emergency oxygen tank is a thing inside the container 240d. The description of the emergency oxygen tank is "is neatly packed and labeled".
The solar panel shard is a thing inside the container 240d. The description of the solar panel shard is "is sharp and reflective".

The container 297a is a fixed in place closed openable container in the storage room. The description of the container 297a is "A small container with a few items inside.". 
The coolant canister is a thing inside the container 297a. The description of the coolant canister is "is secured with a safety latch".
The space suit gloves is a thing inside the container 297a. The description of the space suit gloves is "are slightly oversized".
The emergency rations is a thing inside the container 297a. The description of the emergency rations is "are neatly stacked in a box".

The container 433e is a fixed in place closed openable container in the storage room. The description of the container 433e is "A small container with a few items inside.". 
The gravity stabilizer module is a thing inside the container 433e. The description of the gravity stabilizer module is "is designed for zero-gravity use".
The communication headset is a thing inside the container 433e. The description of the communication headset is "is lightweight and compact".
The encrypted data chip is a thing inside the container 433e. The description of the encrypted data chip is "is glowing faintly blue".

The container 268e is a fixed in place closed openable container in the storage room. The description of the container 268e is "A small container with a few items inside.". 
The space blanket is a thing inside the container 268e. The description of the space blanket is "is folded neatly".
The radiation detector is a thing inside the container 268e. The description of the radiation detector is "is beeping intermittently".
The vacuum-sealed food pack is a thing inside the container 268e. The description of the vacuum-sealed food pack is "is stored in a vacuum-sealed bag".

The container 379e is a fixed in place closed openable container in the storage room. The description of the container 379e is "A small container with a few items inside.". 
The spare circuit board is a thing inside the container 379e. The description of the spare circuit board is "is covered in warning labels".
The damaged helmet is a thing inside the container 379e. The description of the damaged helmet is "has a shattered visor".
The navigation module is a thing inside the container 379e. The description of the navigation module is "has a cracked screen".

The container 391b is a fixed in place closed openable container in the storage room. The description of the container 391b is "A small container with a few items inside.". 
The energy drink canister is a thing inside the container 391b. The description of the energy drink canister is "is half-empty".
The holographic projector is a thing inside the container 391b. The description of the holographic projector is "is displaying static".
The spare air filter is a thing inside the container 391b. The description of the spare air filter is "looks brand new".

The container 293c is a fixed in place closed openable container in the storage room. The description of the container 293c is "A small container with a few items inside.". 
The laser cutter is a thing inside the container 293c. The description of the laser cutter is "is missing its power source".
The broken control panel is a thing inside the container 293c. The description of the broken control panel is "is sparking occasionally".
The broken navigation console is a thing inside the container 293c. The description of the broken navigation console is "is covered in scorch marks".

The Escape Pod Control Manual is a thing. The escape pod control manual is inside cabin storage. The description of the Escape Pod Control Manual is "A worn manual detailing installation and use of the escape pod's steering system, filled with diagrams and engineering shorthand. Scribbled on the back is: container 297b.".
The steering wheel can be installed or uninstalled. The steering wheel is uninstalled.

Test storage_generation with "take radio / s / reply / n / take steering wheel manual / n / x steering wheel manual / e / open container 297b / take steering wheel".