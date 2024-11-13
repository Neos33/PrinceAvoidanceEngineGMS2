/// @desc
if(!surface_exists(surf)){
    surf=surface_create(800,608);
}
surface_copy(surf, 0, 0, application_surface);
var shaderTimerHandle = shader_get_uniform(shader,"time");
var shaderIntensityHandle = shader_get_uniform(shader,"intensity");
shader_set(shader);
	shader_set_uniform_f(shaderTimerHandle, t/50);
	shader_set_uniform_f(shaderIntensityHandle, intensity);
	draw_surface(surf, 0, 0);
shader_reset();
