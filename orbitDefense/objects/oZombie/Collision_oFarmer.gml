// 1. Check if the farmer has the variable "hp" to prevent black screen crash
if (variable_instance_exists(other, "hp")) {
    other.hp -= 1;
}

// 2. Destroy the zombie immediately
instance_destroy();