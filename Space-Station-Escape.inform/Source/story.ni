"Space-Station-Escape" by Ashton Smith

[Space-Escape - an interactive fiction written with Inform 7 by Ashton Smith.
In this game you play as an engineer on a space station that is about to explode - the self destruct sequence has started on the ship. But the escape pod must be fixed before you can escape. ]



Section 1 - Time Mechanic
[The game has a time limit and each action spends time - you start with 90 minutes. Each action will have a different amount for example examine only takes 0.5 minutes while going to another room take 1 minute. 

Player is informed of time remaining by the radio at various intervals 90, 60, 30, 15, 10, 5, 1.

Completing tasks/finding items will trigger the radio to inform them that they were able to stall the ships self destruct by various amounts (Unsure if this makes sense, or time use just needs to be balanced well)]



[
Action Time Weight Table (To be adjusted after play testing)

Action
Time Cost
Examine / Look
0.25
N, E, S, W
0.5
Radio
0.25
Repair
1
Take Item
0.25
Use Tool (The power drill)
0.5
Open (box)
0.5
]


Section 2 - Engineering Bay (Start)

The Engineering Bay is a room.
The radio is an object in the engineering bay.


Section 3 - Escape Pod Bay

The Escape Pod Bay is a room.
The Escape Pod Bay is south of the engineering bay.
[TODO require power drill to open]
The Battery Panel is a closed openable container in the Escape Pod Bay.
[Missing steering wheel - make it so you can install steering wheel]
The Control station is a fixed in place container in the Escape Pod Bay.

Section 4 -  Battery Room

The Battery Room is a room.
The Battery Room is west of the command deck.
The Power Switch is a device in the battery room.  The power switch is fixed in place. 
The Power Switch is switched on.
The Main Battery Panel is a closed openable container in the Battery room.
[Require power drill to open the container]
The Ion Battery is a thing. The ion battery is inside the main battery panel.

[When power is switched off doors do not open]

Instead of taking the ion battery:
	if the power switch is switched on:
		say "You just got shocked!! Maybe we should try to turn the power off.";
	otherwise:
		now the player has the ion battery;
		
[If the Power Switch is on:
	say "you got schocked - you might want to try turning off the power first"
]


Section 5 - Command Deck

The command deck is a room. 
The command deck is north of the engineering bay.

Section 6 - Storage Room

The storage room is a room.
The storage room is east of the command deck.
The table is a supporter in the storage room.
The powerdrill is an object on the table.