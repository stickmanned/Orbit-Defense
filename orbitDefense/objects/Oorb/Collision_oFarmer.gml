// obj_orb - Collision with obj_player
if (state == "idle") {
    state = "orbiting";
    // Add this specific orb's ID to the player's array
    array_push(other.my_orbs, id); 
}