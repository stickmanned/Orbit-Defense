if (instance_exists(oFarmer)) {
    // 1. Simple Motion (Failsafe)
    // We use direct movement first to see if the game stays stable.
    var _dir = point_direction(x, y, oFarmer.x, oFarmer.y);
    
    // Manual Collision with oSolid
    if (!place_meeting(x + lengthdir_x(1.5, _dir), y, oSolid)) {
        x += lengthdir_x(1.5, _dir);
    }
    if (!place_meeting(x, y + lengthdir_y(1.5, _dir), oSolid)) {
        y += lengthdir_y(1.5, _dir);
    }

    // 2. Flip based on Farmer position
    image_xscale = (oFarmer.x > x) ? 1 : -1;
}