// Inside oFarmer - Collision Event with oBoss

if (can_be_hit && hp > 0) {
    // Subtract health
    hp -= 1;
    
    // Safety check (Double protection)
    if (hp < 0) hp = 0;
    
    // Start invincibility cooldown
    can_be_hit = false;
    alarm[0] = hit_cooldown; 
    
    // Visual feedback
    image_blend = c_red;
}