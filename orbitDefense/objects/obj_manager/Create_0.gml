current_wave = 1;
zombies_to_spawn = 5;
orbs_to_spawn = 3;
spawn_timer = 0;
spawn_delay = 60; 
state = "spawning";

// Don't initialize the grid yet. Let's get spawning working first.
global.grid = -1;