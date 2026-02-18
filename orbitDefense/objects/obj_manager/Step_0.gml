if (!instance_exists(oFarmer)) exit;

// --- 1. CONTINUOUS ITEM SPAWNING (The "Safety Net") ---
item_spawn_timer--;
if (item_spawn_timer <= 0) {
    item_spawn_timer = irandom_range(2, 5) * game_get_speed(gamespeed_fps);
    var _ox = irandom_range(64, room_width - 64);
    var _oy = irandom_range(64, room_height - 64);

    if (!position_meeting(_ox, _oy, oSolid)) {
        var _inst = instance_create_layer(_ox, _oy, "Instances", Oorb);
        var _chance = random(100);
        with (_inst) {
            if (_chance < 20) { sprite_index = sOrb; hp = 2; }
            else { sprite_index = sfork; hp = 1; }
        }
    } else {
        item_spawn_timer = 5; 
    }
}

// --- 2. WAVE STATE MACHINE ---
switch (state) {

    case "start_wave":
        if (current_wave > max_waves) {
            show_message("YOU BEST ALL 25 WAVES! The game will loop if you continue!");
            game_restart();
        }
        
        // Scale Difficulty
        zombies_to_spawn = 3 + (current_wave * 2);
        
        // SCALING STARTING ITEMS
        orbs_to_spawn = 5 + floor(zombies_to_spawn * 0.75); 
        total_zombies_this_wave = zombies_to_spawn;
        
        // --- BOSS LOGIC (MODIFIED FOR MULTIPLE BOSSES) ---
        var _num_bosses = 0;
        if (current_wave == 10) _num_bosses = 1;
        else if (current_wave == 15) _num_bosses = 1;
        else if (current_wave == 20) _num_bosses = 2; // Wave 20 -> 2 Bosses
        else if (current_wave == 25) _num_bosses = 3; // Wave 25 -> 3 Bosses

        if (_num_bosses > 0) {
            repeat(_num_bosses) {
                var _bx, _by;
                var _b_safe = false;
                var _attempts = 0;
                
                while (!_b_safe && _attempts < 100) {
                    _attempts++;
                    _bx = irandom_range(150, room_width - 150);
                    _by = irandom_range(150, room_height - 150);
                    
                    // OPEN AREA DETECTION: Check a 100px circle for walls
                    var _clearance = 100; 
                    var _no_walls = !collision_circle(_bx, _by, _clearance, oSolid, false, true);
                    var _far_from_player = (point_distance(_bx, _by, oFarmer.x, oFarmer.y) > 450);
                    // Prevent bosses from spawning directly on each other
                    var _far_from_bosses = !collision_circle(_bx, _by, 80, oBoss, false, true);
                    
                    if (_no_walls && _far_from_player && _far_from_bosses) {
                        _b_safe = true;
                    }
                }
                
                var _boss = instance_create_layer(_bx, _by, "Instances", oBoss);
                
                // Difficulty Configuration
                if (current_wave == 10)      { _boss.hp_max = 50;  _boss.my_scale = 0.8; }
                else if (current_wave == 15) { _boss.hp_max = 150; _boss.my_scale = 1.5; }
                else if (current_wave == 20) { _boss.hp_max = 150; _boss.my_scale = 1.5; } // 150 HP each
                else if (current_wave == 25) { _boss.hp_max = 150; _boss.my_scale = 1.5; } // 150 HP each
                
                _boss.hp = _boss.hp_max;
                _boss.image_xscale = _boss.my_scale;
                _boss.image_yscale = _boss.my_scale;
            }
        }

        state = "spawning";
        break;

    case "spawning":
        spawn_timer++;
        if (spawn_timer >= spawn_delay) {
            spawn_timer = 0;
            
            // SPAWN ZOMBIES
            if (zombies_to_spawn > 0) {
                var _rx = irandom_range(64, room_width - 64);
                var _ry = irandom_range(64, room_height - 64);
                var _temp_z = instance_create_layer(_rx, _ry, "Instances", oZombie);
                with(_temp_z) {
                    if (place_meeting(x, y, oSolid) || point_distance(x, y, oFarmer.x, oFarmer.y) < 250) {
                        instance_destroy(); 
                    } else {
                        other.zombies_to_spawn -= 1;
                    }
                }
            }
            
            // SPAWN STARTING WAVE ITEMS
            if (orbs_to_spawn > 0) {
                var _ox = irandom_range(64, room_width - 64);
                var _oy = irandom_range(64, room_height - 64);
                var _temp_o = instance_create_layer(_ox, _oy, "Instances", Oorb);
                with(_temp_o) {
                    if (place_meeting(x, y, oSolid)) {
                        instance_destroy();
                    } else {
                        var _chance = random(100);
                        if (_chance < 20) { sprite_index = sOrb; hp = 2; }
                        else { sprite_index = sfork; hp = 1; }
                        other.orbs_to_spawn -= 1;
                    }
                }
            }
            
            if (zombies_to_spawn <= 0 && orbs_to_spawn <= 0) {
                state = "playing";
            }
        }
        break;

    case "playing":
        if (oFarmer.hp <= 0) {
            state = "player_died";
        } 
        else if (!instance_exists(oZombie) && !instance_exists(oBoss)) {
            current_wave += 1;
            state = "start_wave";
        }
        break;

    case "player_died":
        with (oZombie) instance_destroy();
        with (oBoss) instance_destroy();
        with (Oorb) instance_destroy();
        oFarmer.my_orbs = []; 
        oFarmer.hp = 3;
        var _safe = false;
        while (!_safe) {
            var _px = irandom_range(100, room_width - 100);
            var _py = irandom_range(100, room_height - 100);
            var _old_x = oFarmer.x; var _old_y = oFarmer.y;
            oFarmer.x = _px; oFarmer.y = _py;
            if (!place_meeting(_px, _py, oSolid)) _safe = true;
            else { oFarmer.x = _old_x; oFarmer.y = _old_y; }
        }
        state = "start_wave";
        break;
}