// 1. Check if the farmer has the variable "hp" to prevent black screen crash
if (variable_instance_exists(other, "hp")) {
    
    // Subtract health but never go below 0
    // max(0, value) compares 0 and your health, then picks the higher number
    other.hp = max(0, other.hp - 1);
}

// 2. Destroy the zombie immediately
instance_destroy();