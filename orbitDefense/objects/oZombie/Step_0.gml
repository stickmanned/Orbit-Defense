if (instance_exists(oFarmer)) {
    // --- 1. MOVEMENT & INTELLIGENCE ---
    if (intel == 1) {
        // LOW INTEL: Simple potential-based avoidance
        mp_potential_step_object(oFarmer.x, oFarmer.y, 1.5, oSolid);
    } 
    else {
        // MED & HIGH INTEL: Grid-based Pathfinding
        path_timer--;
        var _update_rate = (intel == 2) ? 60 : 15; 
        
        if (path_timer <= 0) {
            path_timer = _update_rate;
            if (mp_grid_path(global.grid, path, x, y, oFarmer.x, oFarmer.y, true)) {
                path_start(path, 1.5, path_action_stop, true);
            }
        }
    }

    // Sprite Flipping
    image_xscale = (oFarmer.x > x) ? -1 : 1;
}

// --- 2. STUCK DETECTION LOGIC ---
// Check if we've moved significantly since the last check
if (point_distance(x, y, last_x, last_y) < 0.5) {
    stuck_timer++;
} else {
    stuck_timer = 0; // Reset timer if moving
}

// Record position every 30 frames
if (game_get_speed(gamespeed_fps) % 30 == 0) {
    last_x = x;
    last_y = y;
}

// If stuck for 10 seconds (assuming 60fps), teleport to a safe spot
if (stuck_timer >= 600) {
    var _safe_x, _safe_y;
    var _found_spot = false;
    var _attempts = 0;

    while (!_found_spot && _attempts < 100) {
        _safe_x = irandom_range(100, room_width - 100);
        _safe_y = irandom_range(100, room_height - 100);

        // Ensure spot is free of solids and far from player
        if (!place_meeting(_safe_x, _safe_y, oSolid) && point_distance(_safe_x, _safe_y, oFarmer.x, oFarmer.y) > 300) {
            x = _safe_x;
            y = _safe_y;
            last_x = x;
            last_y = y;
            stuck_timer = 0;
            _found_spot = true;
            path_end(); // Clear current path to force recalculation
        }
        _attempts++;
    }
}