// analog glitch shader by Charles Fettinger for obs-shaderfilter plugin 3/2019
//https://github.com/Oncorporation/obs-shaderfilter
//Converted to OpenGL by Q-mii & Exeldro February 22, 2022
uniform float scan_line_jitter_displacement<
    string label = "Scan line jitter";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 33.0; // (displacement, threshold)
uniform int scan_line_jitter_threshold_percent<
    string label = "scan line jitter threshold percent";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 95;
uniform float vertical_jump_amount<
    string label = "Vertical jump amount";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
>;
uniform float vertical_speed<
    string label = "Vertical speed";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
>;// (amount, speed)
uniform float horizontal_shake<
    string label = "Horizontal shake";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
>;
uniform float color_drift_amount<
    string label = "Color drift amount";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
>;
uniform float color_drift_speed<
    string label = "Color drift speed";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
>;// (amount, speed)
uniform int pulse_speed_percent<
    string label = "Pulse speed percent";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 0;
uniform int alpha_percent<
    string label = "Aplha percent";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 100;
uniform bool rotate_colors;
uniform bool Apply_To_Alpha_Layer = false;
uniform bool Replace_Image_Color;
uniform bool Apply_To_Specific_Color;
uniform float4 Color_To_Replace;
uniform string notes<
    string widget_type = "info";
> ="play with settings!";


float nrand(float x, float y)
{
	float value = dot(float2(x, y), float2(12.9898 , 78.233 ));
	return frac(sin(value) * 43758.5453);
}

float4 mainImage(VertData v_in) : TARGET
{
	float speed = pulse_speed_percent * 0.01;	
	float alpha = alpha_percent * 0.01;
	float scan_line_jitter_threshold = scan_line_jitter_threshold_percent * 0.01;
	float u = v_in.uv.x;
	float v = v_in.uv.y;
	float t = sin(elapsed_time * speed) * 2 - 1;
	float4 rgba = image.Sample(textureSampler, v_in.uv);

	// Scan line jitter
	float jitter = nrand(v, t) * 2 - 1;
	jitter *= step(scan_line_jitter_threshold, abs(jitter)) * scan_line_jitter_displacement;

	// Vertical jump
	float jump = lerp(v, frac(v +  (t * vertical_speed)), vertical_jump_amount);

	// Horizontal shake
	float shake = ((t * (u + rand_f)/2) - 0.5) * horizontal_shake;

	//// Color drift
	float drift = sin(jump + color_drift_speed) * color_drift_amount;

	float2 src1 = float2(rgba.x, rgba.z) * clamp(frac(float2(u + jitter + shake, jump)), -10.0, 10.0);
	float2 src2 = float2(rgba.y, rgba.w) * frac(float2(u + jitter + shake + drift, jump));
	
	if(rotate_colors)
	{
		// get general time number between 0 and 4
		float tx = (t + 1) * 2;
		// 3 steps  c1->c2, c2->c3, c3->c1
		//when between 0 - 1 only c1 rises then falls
		//(min(tx, 2.0) * 0.5)  range between 0-2 converted to 0-1-0
		src1.x = lerp(src1.x, rgba.x, clamp((min(tx, 2.0) * 0.5),0.0,0.5));
		//((min(max(1.0, tx),3.0) - 1) * 0.5)   range between 1-3 converted to 0-1-0
		src2.x = lerp(src2.x, rgba.y, clamp(((min(max(1.0, tx),3.0) - 1) * 0.5),0.0,0.5));
		//((min(2.0, tx) -2) * 0.5)  range between 2 and 4  converted to 0-1-0
		src1.y = lerp(src1.y, rgba.z, clamp(((min(2.0, tx) -2) * 0.5),0.0,0.5));
		
	}

    float4 color = rgba;
    float4 original_color = color;
    rgba = float4(src1.x, src2.x, src1.y, alpha);

    if (Apply_To_Alpha_Layer)
    {
        float luma = color.r * 0.299 + color.g * 0.587 + color.b * 0.114;
        if (Replace_Image_Color)
            color = float4(luma, luma, luma, luma); 
        rgba = lerp(original_color, rgba * color, alpha);
    }
	
    if (Apply_To_Specific_Color)
    {
        color = original_color;
        color = (distance(color.rgb, Color_To_Replace.rgb) <= 0.075) ? rgba : color;
        rgba = lerp(original_color, color, alpha);
    }
	
    return rgba;
}
