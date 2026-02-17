draw_self();

// If it's a damaged sOrb, make it flicker or turn red
if (hp == 1 && sprite_index == sOrb) {
    image_alpha = 0.5; // Make it semi-transparent when it has 1 hit left
} else {
    image_alpha = 1.0;
}