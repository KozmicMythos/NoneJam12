/// STEP - obj_mostra_historia

switch (estado) {

    case 0: // fade in
        timer++;
        alpha = clamp(timer / fade_in_frames, 0, 1);
        if (timer >= fade_in_frames) {
            estado = 1;
            timer = 0;
        }
    break;

    case 1: // hold
        alpha = 1;
        timer++;
        if (timer >= hold_frames) {
            estado = 2;
            timer = 0;
        }
    break;

    case 2: // fade out
        timer++;
        alpha = 1 - clamp(timer / fade_out_frames, 0, 1);
        if (timer >= fade_out_frames) {
            instance_destroy();
        }
    break;
}