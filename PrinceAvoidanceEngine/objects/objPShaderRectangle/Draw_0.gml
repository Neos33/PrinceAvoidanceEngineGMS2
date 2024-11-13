/// @desc
var shaderTimerHandle = shader_get_uniform(shader,"time");
var shaderIntensityHandle = shader_get_uniform(shader,"intensity");

shader_set(shader);
	shader_set_uniform_f(shaderTimerHandle,t/50);
	shader_set_uniform_f(shaderIntensityHandle,intensity);
	draw_sprite_ext(spr1x1, 0, x, y, 800 * image_xscale, 608 * image_yscale,
					image_angle, image_blend, image_alpha);

shader_reset();
