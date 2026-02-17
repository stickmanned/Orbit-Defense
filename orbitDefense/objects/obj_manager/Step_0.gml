if (state == "spawning") {
    spawn_timer++;

    if (spawn_timer >= spawn_delay) {
        spawn_timer = 0;

        // 1. Spawn ONE zombie at a time
        if (zombies_to_spawn > 0) {
            // Pick a random spot far from the map center
            var _rx = irandom_range(100, room_width - 100);
            var _ry = irandom_range(100, room_height - 100);
            
            // Create the zombie
            instance_create_layer(_rx, _ry, "Instances", obj_zombie);
            zombies_to_spawn -= 1;
        }

        // 2. Spawn ONE orb at a time
        if (orbs_to_spawn > 0) {
            var _ox = irandom_range(100, room_width - 100);
            var _oy = irandom_range(100, room_height - 100);
            instance_create_layer(_ox, _oy, "Instances", Oorb);
            orbs_to_spawn -= 1;
        }

        // 3. Finish spawning
        if (zombies_to_spawn <= 0 && orbs_to_spawn <= 0) {
            state = "waiting";
        }
    }
}