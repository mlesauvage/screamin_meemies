/// @description DRAW - Disable drawing in create event!

if (drawing) {
    for (var i = 0; i < ds_list_size(graph);i++) {
    
        if (i/20 <= window_get_width()) {
            draw_point(i/20,600-(ds_list_find_value(graph,i)/32));
        } else {
            ds_list_delete(graph,i);
        }
    
    }
}

timeSinceLastFrame = current_time - lastFrameTime;
lastFrameTime = current_time;

draw_set_halign(fa_left)
draw_text(10,10, string(timeSinceLastFrame));
draw_text(10, 30, "Last Audio Update: " + string(timeSinceLastAudioUpdate));
draw_text(10, 50, "Volume: " + string(global.microphone_volume));