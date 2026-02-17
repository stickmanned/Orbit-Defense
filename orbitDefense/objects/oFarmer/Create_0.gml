// obj_player - Create Event
hp = 3;

// Orbit variables
my_orbs = [];      // An empty array to hold our collected orbs
orbit_angle = 0;   // The starting rotation angle
orbit_speed = 3;   // How fast the shield spins
orbit_radius = 48; // How far the orbs float away from you
// Inside oFarmer Create Event
can_be_hit = true;
hit_cooldown = game_get_speed(gamespeed_fps) * 1.5; // 1.5 seconds of invincibility