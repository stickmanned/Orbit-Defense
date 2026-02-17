if (instance_exists(oFarmer)) {
    // Advanced avoidance movement (no grid required)
    // 3rd argument is the distance it looks ahead to avoid oSolid
    mp_potential_step_object(oFarmer.x, oFarmer.y, spd, oSolid);
    
    // Flip sprite based on movement
    if (oFarmer.x > x) image_xscale = my_scale;
    else image_xscale = -my_scale;
}

// Check for death
if (hp <= 0) {
    instance_destroy();
}