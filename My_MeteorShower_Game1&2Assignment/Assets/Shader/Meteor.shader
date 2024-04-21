Shader "Custom/MeteorShader" {
    Properties {
        _MainColor ("Main Color", Color) = (0.5,0.5,1,1) // 浅蓝色
        _EdgeColor ("Edge Color", Color) = (1,1,1,1) // 白色
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert

        struct Input {
            float2 uv_MainTex;
            float3 worldPos;
        };

        fixed4 _MainColor;
        fixed4 _EdgeColor;

        void surf (Input IN, inout SurfaceOutput o) {
     
            float3 objectCenter = mul(unity_ObjectToWorld, float4(0.0, 0.0, 0.0, 1.0)).xyz;
    
            float dist = distance(IN.worldPos, objectCenter);

            float gradient = smoothstep(0.0, 1.0, dist); 
            fixed4 color = lerp(_MainColor, _EdgeColor, gradient);
            o.Albedo = color.rgb;
            o.Alpha = color.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
