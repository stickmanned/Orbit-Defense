path = path_add();

// 1. Initialize the missing variable that caused the crash
path_timer = 0; 

// 2. Safely get the wave from the manager
var _wave = 1;
if (instance_exists(obj_manager)) {
    _wave = obj_manager.current_wave;
}

// 3. Calculate intelligence based on wave
if (_wave <= 8) intel = 1;
else if (_wave <= 16) intel = 2;
else intel = 3;

// 4. Stuck Detection Variables
stuck_timer = 0;
last_x = x;
last_y = y;

// 5. Basic Stats
hp = 1;
spd = 1.5 + (_wave * 0.1); // Slightly faster in later waves