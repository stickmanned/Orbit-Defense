randomize(); // Ensures random spawns are different every time you play

// 1. Safe Pathfinding Grid
var _c = 32;
global.grid = mp_grid_create(0, 0, ceil(room_width / _c), ceil(room_height / _c), _c, _c);
if (instance_exists(oSolid)) mp_grid_add_instances(global.grid, oSolid, false);

// 2. Wave Variables
current_wave = 1;
max_waves = 25;
zombies_to_spawn = 0;
orbs_to_spawn = 0;
// ... keep your other variables ...
total_zombies_this_wave = 0; // New variable
item_spawn_timer = game_get_speed(gamespeed_fps) * 1; // Start with a 3s delay

spawn_timer = 0;
spawn_delay = 20; // How fast entities spawn
state = "start_wave"; // States: start_wave, spawning, playing, player_died
