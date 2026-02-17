// 1. UI SETTINGS
var _scale = 1.5; 
var _screen_w = display_get_gui_width();
var _margin = 20 * _scale;
var _bar_w = 400 * _scale; // 600 total width
var _bar_h = 24 * _scale;  // 36 total height

// 2. CALCULATE WAVE PROGRESS
var _z_on_map = instance_number(oZombie);
var _z_total_now = _z_on_map + zombies_to_spawn;
var _progress = 1; 
if (total_zombies_this_wave > 0) {
    _progress = 1 - (_z_total_now / total_zombies_this_wave);
}

// 3. DRAW WAVE PROGRESS BAR (TOP CENTER)
var _bx = (_screen_w / 2) - (_bar_w / 2);
var _by = 20; 

// Draw Border/Background
draw_set_color(c_black);
draw_rectangle(_bx - 4, _by - 4, _bx + _bar_w + 4, _by + _bar_h + 4, false); 
draw_set_color(make_color_rgb(60, 60, 60)); 
draw_rectangle(_bx, _by, _bx + _bar_w, _by + _bar_h, false);

// Draw the Fill (Green)
draw_set_color(c_lime);
draw_rectangle(_bx, _by, _bx + (_bar_w * _progress), _by + _bar_h, false);

// Wave Bar Text
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text_transformed(_screen_w / 2, _by + (_bar_h / 2) - (10 * _scale), "WAVE PROGRESS", _scale * 0.7, _scale * 0.7, 0);


// --- 4. MULTI-BOSS HEALTH BARS (DYNAMICALLY STACKED) ---
var _num_bosses = instance_number(oBoss);

if (_num_bosses > 0) {
    var _boss_bar_h = 10 * _scale; 
    var _spacing = 35 * _scale;    // Gap between each boss bar group
    var _start_y = _by + _bar_h + 40; // Starting Y below wave progress bar

    for (var i = 0; i < _num_bosses; i++) {
        var _inst = instance_find(oBoss, i);
        if (instance_exists(_inst)) {
            // Calculate Y for this specific boss
            var _current_by = _start_y + (i * _spacing);
            
            // Draw Boss Label
            var _boss_label = (current_wave == 25) ? "ELITE BOSS " : "BOSS ";
            _boss_label += string(i + 1);
            
            draw_set_color(c_white);
            draw_text_transformed(_screen_w / 2, _current_by - (18 * _scale), _boss_label, _scale * 0.5, _scale * 0.5, 0);

            // Draw Boss Bar Background
            draw_set_color(c_black);
            draw_rectangle(_bx - 4, _current_by - 4, _bx + _bar_w + 4, _current_by + _boss_bar_h + 4, false);
            
            // Draw Boss Health Fill (Blue/Aqua)
            var _hp_pc = clamp(_inst.hp / _inst.hp_max, 0, 1);
            draw_set_color(c_aqua);
            draw_rectangle(_bx, _current_by, _bx + (_bar_w * _hp_pc), _current_by + _boss_bar_h, false);
        }
    }
}

draw_set_halign(fa_left); // Reset alignment for status text


// 5. DRAW BOLD STATUS TEXT (TOP LEFT)
var _draw_text_big = function(_x, _y, _string, _col, _s) {
    draw_set_color(c_black);
    var _off = 1.5 * _s; 
    draw_text_transformed(_x + _off, _y, _string, _s, _s, 0);
    draw_text_transformed(_x - _off, _y, _string, _s, _s, 0);
    draw_text_transformed(_x, _y + _off, _string, _s, _s, 0);
    draw_text_transformed(_x, _y - _off, _string, _s, _s, 0);
    draw_set_color(_col);
    draw_text_transformed(_x, _y, _string, _s, _s, 0);
}

var _ty = 20; 
var _line_sep = 25 * _scale;

_draw_text_big(_margin, _ty, "WAVE: " + string(current_wave), c_yellow, _scale);
_draw_text_big(_margin, _ty + _line_sep, "ZOMBIES: " + string(_z_total_now), c_orange, _scale);

if (instance_exists(oFarmer)) {
    var _hp_col = (oFarmer.hp <= 1) ? c_red : c_lime;
    _draw_text_big(_margin, _ty + (_line_sep * 2), "LIVES: " + string(oFarmer.hp), _hp_col, _scale);
    
    var _orb_count = array_length(oFarmer.my_orbs);
    _draw_text_big(_margin, _ty + (_line_sep * 3), "SHIELDS: " + string(_orb_count), c_aqua, _scale);
}