// oBoss Create Event
hp_max = 15; // Placeholder so the health bar works immediately
hp = hp_max;
my_scale = 1; 
spd = 1.2;

// Check if we were placed manually or by manager
alarm[0] = 1; // Run a check 1 frame later

// These are for the stuck-detection we added to zombies (good to have for Boss too)
last_x = x;
last_y = y;
stuck_timer = 0;