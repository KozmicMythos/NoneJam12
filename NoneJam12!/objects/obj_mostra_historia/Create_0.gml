/// CREATE - obj_mostra_historia

display_set_gui_size(320, 180);

// texto (você pode trocar depois)
texto_historia =
"Em um mundo esquecido...\n"
+ "um pequeno heroi acorda\n"
+ "sem lembrar de nada.\n\n"
+ "Mas algo o chama\n"
+ "para as profundezas...";

// fonte e escala (sua fnt_pixel é grande)
fonte = fnt_pixel;
texto_scale = 10.18;

// tempos (em frames)
fade_in_frames  = 20;  // 0.33s em 60fps
hold_frames     = 180; // 3s
fade_out_frames = 20;  // 0.33s

estado = 0; // 0=fade in, 1=hold, 2=fade out
timer  = 0;
alpha  = 0;

// fundo (opcional)
mostrar_fundo = true;
fundo_alpha_max = 0.65;

// cor do texto
cor_texto = c_white;
