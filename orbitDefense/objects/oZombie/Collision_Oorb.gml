// oZombie -> Collision Event with Oorb
if (instance_exists(other)) {
    if (other.state == "orbiting") {
        
        // 1. Subtract 1 HP from the orb/fork
        other.hp -= 1;
        
        // 2. Change transparency to show it took damage
        // (This will make 2HP Orbs look faint after 1 hit, 
        // while 1HP Forks will just vanish immediately)
        other.image_alpha = 0.5;

        // 3. Check if it should be destroyed
        if (other.hp <= 0) {
            if (instance_exists(oFarmer)) {
                var _idx = array_get_index(oFarmer.my_orbs, other.id);
                if (_idx != -1) array_delete(oFarmer.my_orbs, _idx, 1);
            }
            instance_destroy(other);
        }
        
        // 4. The Zombie always dies on impact
        instance_destroy();
    }
}