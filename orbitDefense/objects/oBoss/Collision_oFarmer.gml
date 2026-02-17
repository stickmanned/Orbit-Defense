if (instance_exists(other)) {
    other.hp -= 1;
    
    // Calculate push direction
    var _dir = point_direction(x, y, other.x, other.y);
    var _push_dist = 60;
    var _tx = other.x + lengthdir_x(_push_dist, _dir);
    var _ty = other.y + lengthdir_y(_push_dist, _dir);
    
    // Only move the farmer if the destination is NOT a wall
    with(other) {
        if (!place_meeting(_tx, _ty, oSolid)) {
            x = _tx;
            y = _ty;
        } else {
            // If there's a wall, just nudge them slightly away from the boss
            // without clipping through the wall
            var _nudge_x = x + lengthdir_x(5, _dir);
            var _nudge_y = y + lengthdir_y(5, _dir);
            if (!place_meeting(_nudge_x, _nudge_y, oSolid)) {
                x = _nudge_x;
                y = _nudge_y;
            }
        }
    }
}