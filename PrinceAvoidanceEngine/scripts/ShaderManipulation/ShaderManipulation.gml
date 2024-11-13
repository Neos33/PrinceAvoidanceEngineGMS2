/**
	* Clears all shader effects currently active.
*/
function shaders_clear()
{


	with(objPShaderChain) instance_destroy();
	with(objPShaderEffect) instance_destroy();
	with(objPShaderChainElement) instance_destroy();
}

/**
	* This script removes the most recent shader effect that has been applied.
	* If there is only one shader in the chain, deletes the shader chain object.
*/
function shader_pop()
{
	with (objPShaderChain)
	{
	    if (numShaders == 1)
		{
	        instance_destroy();
	    }
		else
		{
	        numShaders--;
	    }
	}
}

/**
 * Applies a screen-wide shader effect specified by shader. The shader is required to have two uniform values: "time" and "intensity".
 * @param {shaderID} shader - The shader to apply.
 * @param {float} intensity - The intensity parameter to initialize the shader handler object instance with, from 0 to 1. Default: 1.
 */
function shader_push(Shader, Intensity)
{
    if (!instance_exists(objPShaderChain))
    {
        var shaderChain = instance_create_depth(0, 0, 0, objPShaderChain);
        shaderChain.numShaders = 1;
        shader_insert(0, Shader, Intensity);
        return shaderChain.chain[0];
    }
    else
    {
        with (objPShaderChain)
        {
            numShaders++;
            shader_insert(numShaders - 1, Shader, Intensity);
            return chain[numShaders - 1];
        }
    }
}


function shader_insert(Ind, Shader, Intensity)
{
	with (objPShaderChain)
	{
	    chain[Ind] = instance_create_depth(0, 0, 0, objPShaderChainElement);
	    chain[Ind].shader = Shader;
	    chain[Ind].intensity = Intensity;
	}
}