// 1. Movement & Collision
if (place_meeting(x, y, oSolid)) {
    for (var i = 0; i < 100; i++) {
        for (var j = 0; j < 360; j += 45) {
            var _dist = i * 2;
            var _check_x = x + lengthdir_x(_dist, j);
            var _check_y = y + lengthdir_y(_dist, j);
            if (!place_meeting(_check_x, _check_y, oSolid)) {
                x = _check_x;
                y = _check_y;
                i = 100; 
                break; 
            }
        }
    }
}

var _hmove = (keyboard_check(ord("D")) || keyboard_check(vk_right)) - (keyboard_check(ord("A")) || keyboard_check(vk_left));
var _vmove = (keyboard_check(ord("S")) || keyboard_check(vk_down)) - (keyboard_check(ord("W")) || keyboard_check(vk_up));
var _spd = 2;

if (place_meeting(x + (_hmove * _spd), y, oSolid)) {
    while (!place_meeting(x + sign(_hmove), y, oSolid)) x += sign(_hmove);
    _hmove = 0;
}
x += _hmove * _spd;

if (place_meeting(x, y + (_vmove * _spd), oSolid)) {
    while (!place_meeting(x, y + sign(_vmove), oSolid)) y += sign(_vmove);
    _vmove = 0;
}
y += _vmove * _spd;

x = clamp(x, 0, room_width);
y = clamp(y, 0, room_height);

// 2. Orbit Logic
orbit_angle += orbit_speed;
var _total_orbs = array_length(my_orbs);
for (var i = 0; i < _total_orbs; i++) {
    var _orb = my_orbs[i];
    if (instance_exists(_orb)) {
        var _spacing = 360 / max(1, _total_orbs);
        var _target_angle = orbit_angle + (i * _spacing);
        _orb.x = x + lengthdir_x(orbit_radius, _target_angle);
        _orb.y = y + lengthdir_y(orbit_radius, _target_angle);
        _orb.image_angle = _target_angle + 90;
    }
}

// 3. HEALTH SAFETY NET & DEATH LOGIC
// Force health to never be below 0
if (hp < 0) hp = 0;

// IMPORTANT: Check for death ONLY if the manager isn't already handling it
// This prevents the infinite loop/black screen crash
if (hp <= 0) {
    if (instance_exists(obj_manager)) {
        if (obj_manager.state != "player_died") {
            obj_manager.state = "player_died";
        }
    }
}

// 4. VISUAL FLICKER (Invincibility Feedback)
if (!can_be_hit) {
    // Simple flicker logic: flips every 100 milliseconds
    image_alpha = (current_time % 200 < 100) ? 0.3 : 1.0; 
} else {
    image_alpha = 1.0;
    // Reset the red color blend from the collision event once invincibility is over
    image_blend = c_white; 
}