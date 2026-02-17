// 1. Damage the Boss
hp -= 1;

// 2. Damage the Orb/Fork
if (instance_exists(other)) {
    other.hp -= 1;
    other.image_alpha = 0.5;
    
    if (other.hp <= 0) {
        // Remove from Farmer's list
        if (instance_exists(oFarmer)) {
            var _idx = array_get_index(oFarmer.my_orbs, other.id);
            if (_idx != -1) array_delete(oFarmer.my_orbs, _idx, 1);
        }
        instance_destroy(other);
    }
}

// 3. Boss Death Check
if (hp <= 0) instance_destroy();