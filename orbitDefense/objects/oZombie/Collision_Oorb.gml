// 1. Only react if the orb is attached to the farmer
if (other.state == "orbiting") {
    
    // 2. Safely remove the orb from the farmer's list
    if (instance_exists(oFarmer)) {
        var _idx = array_get_index(oFarmer.my_orbs, other.id);
        if (_idx != -1) {
            array_delete(oFarmer.my_orbs, _idx, 1);
        }
    }

    // 3. Destroy both
    instance_destroy(other); // Destroys Oorb
    instance_destroy();      // Destroys this zombie
}