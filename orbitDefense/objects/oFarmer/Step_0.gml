// 1. Movement & Collision
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
    }
}

// 3. Death Check
if (hp <= 0) room_restart();